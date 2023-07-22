import 'package:flutter/material.dart';
import '/databasemanager.dart';
import '/home.dart';

class AddCrediential extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddCrediential();
}

class _AddCrediential extends State<AddCrediential>{

  final dbhelper = DatabaseHelper.instance;

  final _form_key = GlobalKey<FormState>();

  var type = "";
  var title = "";
  var username = "";
  var password = "";
  var passwordhint = "";

  //final typeController = TextEditingController();
  final titleController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordhintController = TextEditingController();

  String _dropDownValue="Credit Card";

  List typeList = ["Credit Card", "Debit Card", "Bank", "Gmail", "Facebook", "Instagram", "LinkedIn", "Twitter", "Website", "Other"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Credientials'),
        ),
        body: Form(
          key: _form_key,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: ListView(
              children: [
                DropdownButton(
                  hint: _dropDownValue == null
                      ? Text('Select Type')
                      : Text(
                    _dropDownValue,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  isExpanded: true,
                  iconSize: 30.0,
                  iconEnabledColor: Colors.teal,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  items: typeList.map(
                        (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                          () {
                        _dropDownValue = val.toString();
                      },
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Subtype', labelStyle: TextStyle(fontSize:
                  16)),
                  controller: titleController,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Please Enter Subtype';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username', labelStyle: TextStyle(fontSize:
                  16)),
                  controller: usernameController,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Please Enter Username';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(fontSize:
                  16)),
                  controller: passwordController,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Please Enter Password';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password Hint', labelStyle: TextStyle(fontSize:
                  16,)),
                  controller: passwordhintController,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Please Enter Password Hint';
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
                          type = _dropDownValue;
                          title = titleController.text;
                          username = usernameController.text;
                          password = passwordController.text;
                          passwordhint = passwordhintController.text;
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
    Map<String, String> row = {
      DatabaseHelper.columnType : _dropDownValue,
      DatabaseHelper.columnTitle : title,
      DatabaseHelper.columnUsername : username,
      DatabaseHelper.columnPassword : password,
      DatabaseHelper.columnHint : passwordhint,
    };

    final id = await dbhelper.insertCrediential(row);
    print('ID...${id}');
    if (id != null){
      Navigator.pop(context, true);
    }
  }
}