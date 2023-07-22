import 'package:flutter/material.dart';
import '/addcredientials.dart';
import '/databasemanager.dart';

class MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>{

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
          title: Text('Home')
      ),
      body: isDataAvailable(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          //Navigator.pushNamed(context, '/add_crediential');
          bool isRefresh = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCrediential())
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
    List allRecords = await dbhelper.fetchAllCrediential();
    setState(() {
      credentialList = allRecords;
    });
    print('All Record...${allRecords}');
  }

  Widget isDataAvailable(){
    if (credentialList.length == 0){
      return Center(child: Padding(padding: EdgeInsets.only(left: 30, right: 30), child: Text('No criediential found to add new crediential please click on + icon', style: TextStyle(color: Colors.grey))));
    } else{
      return ListView.builder(
          itemCount: credentialList.length,
          itemBuilder: (context, index){
            return Card(
              color: Colors.blueGrey,
              child: ExpansionTile(
                iconColor: Colors.white,
                leading: getIcon(credentialList[index]['type']),//Icon(Icons.credit_card, color: Colors.white),
                //trailing: Icon(Icons.delete, color: Colors.white),
                title: Text('${credentialList[index]['type']} / ${credentialList[index]['title']}', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500), maxLines: 1),
                subtitle: Text('Hint: ${credentialList[index]['hint']}', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal), maxLines: 1),
                children: [
                  Container(
                    height: 70,
                    color: Colors.blueGrey,
                    child: ListTile(
                      //leading: Icon(Icons.edit, color: Colors.white),
                      //trailing: Icon(Icons.delete, color: Colors.white),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: (){
                            showAlertDialog(context, credentialList[index]['id']);
                          }
                      ),
                      title: Container(padding: EdgeInsets.only(left: 0, bottom: 0),child: Text('Username : ${credentialList[index]['username']}', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 16, color: Colors.white), maxLines: 2)),
                      subtitle: Container(padding: EdgeInsets.only(left: 0, bottom: 0), child: Text('Password : ${credentialList[index]['password']}', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 16, color: Colors.white), maxLines: 1)),
                    ),
                  )
                ],
              ),
            );
          }
      );
    }
  }

  Widget getIcon(String type){
    switch (type) {
      case "Credit Card":
        return Icon(Icons.credit_card, color: Colors.white);
        break;
      case "Debit Card":
        return Icon(Icons.credit_card, color: Colors.white);
        break;
      case "Bank":
        return Image(image: AssetImage('images/bank.png'), width: 28, height: 28);
        break;
      case "Gmail":
        return Icon(Icons.email, color: Colors.white);
        break;
      case "Facebook":
        return Icon(Icons.facebook, color: Colors.white);
        break;
      case "Instagram":
        return Image(image: AssetImage('images/instagram.png'), width: 28, height: 28);
        break;
      case "LinkedIn":
        return Image(image: AssetImage('images/linkedin.png'), width: 28, height: 28);
        break;
      case "Twitter":
        return Image(image: AssetImage('images/twitter.png'), width: 28, height: 28);
        break;
      case "Website":
        return Icon(Icons.web, color: Colors.white);
        break;
      case "Other":
        return Image(image: AssetImage('images/other.png'), width: 28, height: 28);
        break;
      default:
        return Image(image: AssetImage('images/other.png'), width: 28, height: 28);
        break;
    }
    //return Icon(Icons.credit_card, color: Colors.white);
  }

  showAlertDialog(BuildContext context, int id) {
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
        deleteRecord(id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert Dialog"),
      content: Text("Are you sure you want to delete this crediential?"),
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

  void deleteRecord(int id) async{
    int res = await dbhelper.deleteCrediential(id);
    print('Deleted number of record ${res}');
    if (res != null){
      //Navigator.pop(context);
      fetchAllRecords();
    }
  }

}