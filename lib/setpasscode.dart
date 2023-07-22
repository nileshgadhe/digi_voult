import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPasscode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SetPasscode();
}

class _SetPasscode extends State<SetPasscode>{

  final _form_key = GlobalKey<FormState>();

  var firstDigit = "";
  var secondDigit = "";
  var thirdDigit = "";
  var fourtDigit = "";

  final firstDigitController = TextEditingController();
  final secondDigitController = TextEditingController();
  final thirdDigitController = TextEditingController();
  final fourDigitController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text('Set Passcode')
        // ),
        body: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Set Passcode', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal)),
                Divider(color: Colors.transparent),
                Text('Please enter 4 digits passcode'),
                Divider(color: Colors.transparent),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value){
                          if (value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: firstDigitController,
                          validator: (value){
                            if (value!.isEmpty){
                              return '?';
                            }
                          },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value){
                          if (value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: secondDigitController,
                        validator: (value){
                          if (value!.isEmpty){
                            return '?';
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value){
                          if (value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: thirdDigitController,
                        validator: (value){
                          if (value!.isEmpty){
                            return '?';
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value){
                          if (value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: fourDigitController,
                        validator: (value){
                          if (value!.isEmpty){
                            return '?';
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.transparent),
                Container(
                  padding: EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: (){
                    print('Clicked....');
                    setState(() {
                      firstDigit = firstDigitController.text;
                      secondDigit = secondDigitController.text;
                      thirdDigit = thirdDigitController.text;
                      fourtDigit = fourDigitController.text;
                    });
                    if (firstDigit != "" && firstDigit != " " &&  secondDigit != "" && secondDigit != " " && thirdDigit != "" && thirdDigit != " " && fourtDigit != "" && fourtDigit != " "){
                      print('Not empty...');
                      savePasscode();
                    }
                  },
                      child: Text('SAVE')
                  ),
                ),
              ],
            ),
          )
        )
    );
  }

  void savePasscode() async{
    final passcode = firstDigit+secondDigit+thirdDigit+fourtDigit;
    print(passcode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('passcode', passcode);
    //Navigator.pushReplacementNamed(context, '/tab');
    Navigator.pushNamedAndRemoveUntil(context, '/tab', (route) => false);
  }
}