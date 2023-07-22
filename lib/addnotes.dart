import 'package:flutter/material.dart';
import '/databasemanager.dart';
import 'package:intl/intl.dart';

class AddNotes extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddNotes();
}

class _AddNotes extends State<AddNotes>{

  final dbhelper = DatabaseHelper.instance;

  final _form_key = GlobalKey<FormState>();

  var title = "";
  var detail = "";

  final titleController = TextEditingController();
  final detailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Notes'),
        ),
        body: Form(
          key: _form_key,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title', labelStyle: TextStyle(fontSize:
                  16)),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  controller: titleController,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Please Enter Title';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Details', labelStyle: TextStyle(fontSize:
                  16)),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  controller: detailController,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Please Enter Details';
                    }
                  },
                ),
                Divider(color: Colors.transparent),
                Container(
                  padding: EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: (){
                    if (_form_key.currentState!.validate()){
                      print('Clicked');
                      setState(() {
                        title = titleController.text;
                        detail = detailController.text;
                      });
                      insertData();
                    }
                  },
                      child: Text('SAVE')
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  void insertData() async{
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MMM-yyyy');
    String formattedDate = formatter.format(now);

    Map<String, String> row = {
      DatabaseHelper.columnTitleNote : title,
      DatabaseHelper.columnDetailsNote : detail,
      DatabaseHelper.columnDateNote: formattedDate
    };

    final id = await dbhelper.insertNote(row);
    print('ID...${id}');
    if (id != null){
      Navigator.pop(context, true);
    }
  }
}