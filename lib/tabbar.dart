import 'package:digi_voult/home.dart';
import 'package:digi_voult/notelist.dart';
import 'package:flutter/material.dart';
import '/settings.dart';

class TabBarPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TabBarPage();
}

class _TabBarPage extends State<TabBarPage>{
  int myIndex = 0;

  List pagesList = [
    MyHomePage(),
    MyNotesPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text('Home')
        // ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          onTap: (index){
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.teal),
            BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notes', backgroundColor: Colors.teal),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings', backgroundColor: Colors.teal),
          ],
        ),
        body: pagesList[myIndex],
    );
  }
}