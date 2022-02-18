import 'package:cakrawala_mobile/Screens/SplashScreen/splash_screen.dart';
import 'package:cakrawala_mobile/Screens/Transfer/transfer_screen.dart';
import 'package:cakrawala_mobile/Screens/Welcome/welcome_screen.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: primaryColor, scaffoldBackgroundColor: Colors.black),
        home: const TransferScreen());
  }
}
