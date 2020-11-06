import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class VoiceRecordFAB extends StatefulWidget {
  final Function callback;
  final Color color;

  const VoiceRecordFAB({
    Key key,
    @required this.callback,
    @required this.color,
  }) : super(key: key);

  @override
  _VoiceRecordFABState createState() => _VoiceRecordFABState();
}

class _VoiceRecordFABState extends State<VoiceRecordFAB> {
  FlutterSoundRecorder myRecorder = FlutterSoundRecorder();

  String _mPath;
  IOSink _sink;
  StreamSubscription _mRecordingDataSubscription;
  StreamController<Food> _recordingDataController;
  File _outputFile;

  Timer _timer;
  int _start = 0;

  double _width = 0;

  @override
  void dispose() {
    if (myRecorder != null) {
      myRecorder.closeAudioSession();
    }

    _sink.close();
    _recordingDataController.close();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start >= 10) {
            stopRecorder().then((value) {
              _start = 0;
              _width = 0;
              timer.cancel();
              print("end");
            });
          } else {
            _start = _start + 1;
          }
        },
      ),
    );
  }

  Future<IOSink> createFile() async {
    Directory tempDir = await getTemporaryDirectory();
    _mPath = '${tempDir.path}/emergency.pcm';
    _outputFile = File(_mPath);
    if (_outputFile.existsSync()) await _outputFile.delete();
    return _outputFile.openWrite();
  }

  Future<void> record() async {
    myRecorder.openAudioSession();

    _sink = await createFile();
    _recordingDataController = StreamController<Food>();
    _mRecordingDataSubscription =
        _recordingDataController.stream.listen((Food buffer) {
      if (buffer is FoodData) _sink.add(buffer.data);
    });
    await myRecorder.startRecorder(
      toStream: _recordingDataController.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: 8000,
    );
    setState(() {});
  }

  Future<void> stopRecorder() async {
    await myRecorder.stopRecorder();

    _outputFile = File(_mPath);

    if (_mRecordingDataSubscription != null) {
      await _mRecordingDataSubscription.cancel();
      _mRecordingDataSubscription = null;
    }
    widget.callback(_outputFile);
    myRecorder.closeAudioSession();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        buildRecordStatus(),
        buildRecordButton(),
      ],
    );
  }

  Positioned buildRecordStatus() {
    return Positioned(
      right: 25,
      top: 0,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 500),
        width: _width,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
          border: Border.all(color: widget.color, width: 1),
          color: Colors.grey[200],
        ),
        child: Center(
          child: Text(
            _start >= 10 ? "00:$_start" : "00:0$_start",
            style: TextStyle(color: widget.color, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Positioned buildRecordButton() {
    return Positioned(
      child: GestureDetector(
        onLongPressStart: (details) {
          print("start");
          setState(() {
            _width = 120;
          });
          record();
          startTimer();
        },
        onLongPressEnd: (details) {
          print("end");
          if (myRecorder.isRecording) {
            stopRecorder();
            _timer.cancel();
          }
          setState(() {
            _width = 0;
            _start = 0;
          });
        },
        child: InkWell(
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {},
            child: Icon(
              Icons.mic,
              color: widget.color,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
