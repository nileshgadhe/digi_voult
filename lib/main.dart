
import 'dart:async';

import 'package:digi_voult/addnotes.dart';
import 'package:digi_voult/notelist.dart';
import 'package:flutter/material.dart';
import '/home.dart';
import '/addcredientials.dart';
import '/tabbar.dart';
import '/notedetails.dart';
import '/authentication.dart';
import '/setpasscode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() async {
  // runApp(MaterialApp(
  //   theme: ThemeData(primarySwatch: Colors.teal),
  //   title: 'Digi Voult',
  //   home: SetPasscode(),
  // ));

  WidgetsFlutterBinding.ensureInitialized();
  final Auth _auth = Auth();
  final bool isLogged = await _auth.isLogged();

  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.teal, brightness: Brightness.light),
    title: 'Digi Voult',
    initialRoute: isLogged ? '/' : '/setpasscode',
    routes: {
      '/' : (context) => AuthenticationPage(),
      '/setpasscode' : (context) => SetPasscode(),
      '/tab': (context) => TabBarPage(),
      '/home': (context) => MyHomePage(),
      '/note': (context) => MyNotesPage(),
      '/add_crediential': (context) => AddCrediential(),
      '/add_notes' : (context) => AddNotes(),
      '/note_detalis' : (context) => MyNotesDetails()
    },
  ));

  Timer(Duration(seconds: 5) , (){
    FlutterNativeSplash.remove();
  });

}

class Auth {
  Future<bool> isLogged() async {
    try {
      SharedPreferences prefs =  await SharedPreferences.getInstance();
      final passcode = prefs.getString('passcode');
      print('Passcode.........');
      print(passcode);
      return passcode != null;
    } catch (e) {
      return false;
    }
  }
}