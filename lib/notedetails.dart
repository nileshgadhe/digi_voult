import 'package:flutter/material.dart';
import '/databasemanager.dart';

class MyNotesDetails extends StatelessWidget{

  final dbhelper = DatabaseHelper.instance;
  var id = 0;
  @override
  Widget build(BuildContext context) {

    final note = ModalRoute.of(context)!.settings.arguments as Map;
    id = note['id'];
    return Scaffold(
      appBar: AppBar(
          title: Text('Note Details'),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: (){
                  showAlertDialog(context);
                }
                ),
          ]
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(padding: EdgeInsets.only(left: 20, bottom:0, top: 20, right: 20),child: Text(note['title'], textDirection: TextDirection.ltr, style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500))),
            //Divider(color: Colors.transparent,),
            Container(padding: EdgeInsets.only(left: 20, bottom: 0, top: 5, right: 20), child: Text(note['details'], textDirection: TextDirection.ltr, style: TextStyle(fontSize: 16, color: Colors.grey))),
            Container(padding: EdgeInsets.only(left: 20, bottom: 20, top: 5, right: 20), child: Text('Created on: ${note['date']}', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 12, color: Colors.teal)))
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        Navigator.of(context).pop();
        deleteRecord(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert Dialog"),
      content: Text("Are you sure you want to delete this note?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void deleteRecord(BuildContext context) async{
    int res = await dbhelper.deleteNote(id);
    print('Deleted number of record ${res}');
    if (res != null){
      Navigator.pop(context);
    }
  }
}