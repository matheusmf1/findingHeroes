import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finding_heroes/pages/login_page.dart';
import 'package:finding_heroes/pages/new_project_page.dart';
import 'package:finding_heroes/widgets/donation_card.dart';
import 'package:finding_heroes/widgets/donation_detail_widget.dart';
import 'package:finding_heroes/widgets/new_project_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';


class HomeReciversPage extends StatefulWidget {
  final String user_name;

  const HomeReciversPage(this.user_name);
  @override
  _HomeReciversPageState createState() => _HomeReciversPageState();
}

class _HomeReciversPageState extends State<HomeReciversPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createUserArea(),
    );
  }
  
  _createUserArea() { 
    return Container(
      color: Color.fromARGB(255, 112, 167, 169),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    color: Colors.transparent,
                    height: 80,
                    child: DropdownButton(
                      icon: Icon(
                        Icons.view_headline, 
                        color: Colors.white,
                      ),
                      items: [
                        DropdownMenuItem(child: Container(child: Row(
                          children: <Widget>[
                            Icon(Icons.exit_to_app),
                            SizedBox(width: 8),
                            Text("Sair")
                          ],
                        ),
                      ),
                      value: 'Sair',
                    )
                    ],onChanged: (itemIdentifier){
                      if(itemIdentifier == 'Sair'){
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (builder) => LoginPage())
                        );
                      }
                    },),
                  )
                ],
              ),                              
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(        
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                )
              ),
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: StreamBuilder(
                stream: Firestore.instance.collection('donations').snapshots(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(snapshot.data.documents.length > 0){
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (ctx, index) => DonationDetailWidget(
                        snapshot.data.documents[index]['project_name'],
                        snapshot.data.documents[index]['description'],
                        snapshot.data.documents[index]['email'],
                        snapshot.data.documents[index]['phone'],
                        snapshot.data.documents[index]['donation_type']
                      )
                    );
                  }else{
                    return Column(
                      children: <Widget>[            
                        _createWelcomeUser(),      
                        _createUsrProjectsArea()
                      ],
                    );
                  }                                                         
                }
              )    
            )
          ),
        ],
      ), 
    );
  }
                                    
  _createWelcomeUser() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Text(
              widget.user_name[0].toUpperCase() + widget.user_name.substring(1),
              style: TextStyle(
                color: Color.fromARGB(250, 50, 50, 50),
                fontSize: 30,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic
              ),
            ),
            Text(
              ", seja bem vindo!",
              style: TextStyle(
                color: Color.fromARGB(230, 100, 100, 100),
                fontSize: 24,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic
              ),
            ),
          ],
        )
      ),
    );
  }
                  
  _createUsrProjectsArea() {
    return Expanded(
      flex: 7,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 150, 0, 0),
        child: Column(
          children: <Widget>[
            Text(
              "Você não tem nenhum projeto para receber doações"
            ),             
            GestureDetector(
              onTap: (){
                setState(() {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (builder) => NewProjectPage())
                  );
                });
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 112, 167, 169),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Container(               
                  child: Text(
                    "Adicionar projeto",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createNewProjectArea(){
    return Expanded(
      flex: 7,
      child: NewProjectWidget(),
    );
  }
}

getUserId() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user = await _auth.currentUser();
  return  user.uid;
}

 