import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finding_heroes/pages/home_donators_page.dart';
import 'package:finding_heroes/pages/home_recivers_page.dart';
import 'package:finding_heroes/widgets/animated_alert_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IndicatorPage extends StatefulWidget {
  @override
  _IndicatorPageState createState() => _IndicatorPageState();
}

class _IndicatorPageState extends State<IndicatorPage> {



  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(        
        future: getUserId(),
        builder: (context, snapshot){
          getUserType(snapshot.data, context);
          return CircularProgressIndicator();
        },
      )
    );
  }
}


getUserId() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user = await _auth.currentUser();
  return  user.uid;
}

getUserType(uid, context) async {
  try{
    await Firestore.instance.collection('users')
    .document(uid)
    .get()
    .then((value) {
      if(value.data.values.toList()[0] == 1){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => HomeReciversPage(value.data.values.toList()[1]))
        );
      }else{
        Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => HomeDonatorsPage())
      );
      }
    }); 
  }catch (e) {    
    showDialog(
      context: context,
      builder: (_) => AnimatedAlertWidget(
        Icon(Icons.error, color: Colors.red,),
        "Desculpa! Tivemos um erro ao tentar logar"
      )
    );
  }
}