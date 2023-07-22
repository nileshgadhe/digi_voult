import 'package:digi_voult/addnotes.dart';
import 'package:flutter/material.dart';
import '/databasemanager.dart';

class MyNotesPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyNotesPage();
}

class _MyNotesPage extends State<MyNotesPage>{

  final dbhelper = DatabaseHelper.instance;

  List credentialList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Notes')
        ),
        body: isDataAvailable(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //Navigator.pushNamed(context, '/add_notes');
            bool isRefresh = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNotes())
            );
            if (isRefresh){
              fetchAllRecords();
            }
          },
          child: Icon(Icons.add),
        )
    );
  }

  void fetchAllRecords() async{
    List allRecords = await dbhelper.fetchAllNotes();
    setState(() {
      credentialList = allRecords;
    });
    print('All Record...${allRecords}');
  }

  Widget isDataAvailable(){
    if (credentialList.length == 0){
      return Center(child: Padding(padding: EdgeInsets.only(left: 30, right: 30), child: Text('No note found to add new note please click on + icon', style: TextStyle(color: Colors.grey))));
    } else{
      return ListView.builder(
          itemCount: credentialList.length,
          itemBuilder: (context, index){
            return Card(
                color: Colors.blueGrey,
                child: ListTile(
                  leading: Icon(Icons.notes, color: Colors.white),
                  title: Text(credentialList[index]['title'], style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500), maxLines: 1,),
                  subtitle: Text(credentialList[index]['details'], style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal), maxLines: 1),
                  onTap: (){
                    Navigator.pushNamed(context, '/note_detalis', arguments: credentialList[index]);
                  },
                )
            );
          }
      );
    }
  }
}