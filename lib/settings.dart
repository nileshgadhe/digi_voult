import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage>{

  List settingList = ["Delete All Data", "Export Data", "Reset PIN", "Rate App", "Share App", "Contact Us", "FAQ"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Settings')
        ),
        body: ListView.builder(
            itemCount: settingList.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: getIcon(settingList[index]),
                title: Text(settingList[index]),
              );
            }
        )
    );
  }

  Widget getIcon(String type){
    switch (type) {
      case "Delete All Data":
        return Icon(Icons.delete);
        break;
      case "Export Data":
        return Icon(Icons.arrow_right_alt);
        break;
      case "Reset PIN":
        return Icon(Icons.pin);
        break;
      case "Rate App":
        return Icon(Icons.star_rate);
        break;
      case "Share App":
        return Icon(Icons.share);
        break;
      case "Contact Us":
        return Icon(Icons.contact_mail);
        break;
      case "FAQ":
        return Icon(Icons.question_answer);
        break;
      default:
        return Image(image: AssetImage('images/other.png'), width: 28, height: 28);
        break;
    }
    //return Icon(Icons.credit_card, color: Colors.white);
  }

}