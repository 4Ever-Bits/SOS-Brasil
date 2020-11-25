import 'package:flutter/material.dart';

import 'package:SOS_Brasil/models/news.dart';

List<News> newsList = [
  News(
    title: "Prepare-se para o lançamento",
    subtitle: "Dia 27/11 vai sair uma primeira versão deste app",
    createAt: DateTime.now(),
  ),
];

class CustomLeftDrawer extends StatelessWidget {
  const CustomLeftDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ((2 * MediaQuery.of(context).size.width) / 3),
      color: Colors.grey[200],
      child: Column(
        children: <Widget>[
          Container(
            height: kBottomNavigationBarHeight + 55,
            decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Notícias",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                title: Text(newsList[index].title),
                subtitle: Text(newsList[index].subtitle),
                contentPadding: EdgeInsets.all(15),
                isThreeLine: true,
                trailing: Text(newsList[index]
                        .createAt
                        .difference(DateTime.now())
                        .inHours
                        .toString() +
                    "h ago"),
                // dense: true,
                onTap: () {},
              ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: newsList.length,
            ),
          )
        ],
      ),
    );
  }
}
