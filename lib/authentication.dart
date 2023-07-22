import 'package:flutter/material.dart';
import 'package:pin_code_view/pin_code_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPage extends StatefulWidget{
  @override
  _AuthenticationPage createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PinCode(
        codeLength: 4,
        codeTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
        title: 'Welcome',
        titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 30, color: Colors.white),
        subtitle: 'Enter your passcode',
        subtitleTextStyle: TextStyle(color: Colors.white),
        obscurePin: true,
        backgroundColor: Colors.teal,
        keyTextStyle: TextStyle(color: Colors.white),
        onChange: (value) {
          if (value.length == 4){
            this.getPasscode(value);
          }
        },
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Okay", style: TextStyle(color: Colors.teal)),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert Dialog", style: TextStyle(color: Colors.teal),),
      content: Text("You have entered wrong passcode please try again."),
      actions: [
        cancelButton
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

  void getPasscode(String enteredPasscode) async {
    try {
      SharedPreferences prefs =  await SharedPreferences.getInstance();
      final passcode = prefs.getString('passcode');
      print('Passcode.........');
      print(passcode);
      if (enteredPasscode == passcode){
        //Navigator.pushReplacementNamed(context, '/tab');
        Navigator.pushNamedAndRemoveUntil(context, '/tab', (route) => false);
      } else{
        showAlertDialog(context);
      }
    } catch (e) {
      print(e);
    }
  }

}