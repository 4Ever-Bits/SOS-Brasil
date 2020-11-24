import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class CompressFile {
  static Future<File> compressImage(File file) async {
    final filePath = file.absolute.path;

    Directory tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.path}/emergency.${filePath.split(".").last}';
    print(targetPath);

    var result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      targetPath,
      quality: 60,
      minHeight: 230,
      minWidth: 300,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }
}
