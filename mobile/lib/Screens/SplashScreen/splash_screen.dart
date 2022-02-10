import 'dart:async';

import 'package:cakrawala_mobile/Screens/SplashScreen/components/body.dart';
import 'package:cakrawala_mobile/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SplashView();
  }
}

class SplashView extends State<SplashScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    var durasi = Duration(seconds: 3);
    return Timer(durasi, (){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => WelcomeScreen()
      ));
    });
  }
}