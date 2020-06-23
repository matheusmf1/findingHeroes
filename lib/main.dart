import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finding_heroes/pages/home_donators_page.dart';
import 'package:finding_heroes/pages/home_recivers_page.dart';
import 'package:finding_heroes/pages/login_page.dart';
import 'package:finding_heroes/pages/page_indicator.dart';
import 'package:finding_heroes/pages/splashscreen_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
   SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finding Heroes',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot){
          if(userSnapshot.hasData){            
            return IndicatorPage();
          }else{
            return SplashScreenPage();
          }
        },
      )
    );
  }    
}

