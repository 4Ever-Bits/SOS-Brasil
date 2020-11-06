import 'package:SOS_Brasil/components/backdrop_close_bar.dart';
import 'package:SOS_Brasil/utils/numbers_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyList extends StatelessWidget {
  const EmergencyList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.indigo[900], Colors.indigo[500]],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: <Widget>[
          CloseBar(),
          SizedBox(height: 10),
          Text(
            "Números de Emergência",
            style: TextStyle(
              fontSize: 25,
              color: Colors.grey[200],
            ),
          ),
          SizedBox(height: 50),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => ListTile(
                  onTap: () async {
                    String number = "tel: ${phonelist[index].number}";

                    if (await canLaunch(number)) {
                      await launch(number);
                    } else {
                      throw 'Could not launch $number';
                    }
                  },
                  leading: Text(
                    phonelist[index].name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[200],
                    ),
                  ),
                  trailing: Text(
                    phonelist[index].number,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 18),
                itemCount: phonelist.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
