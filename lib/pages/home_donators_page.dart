import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finding_heroes/widgets/donation_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class HomeDonatorsPage extends StatefulWidget {
  @override
  _HomeDonatorsPageState createState() => _HomeDonatorsPageState();
}

class _HomeDonatorsPageState extends State<HomeDonatorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: createHomeDonatorsPageBody(),
    );
  }

  createHomeDonatorsPageBody() {
    return NestedScrollView(
        headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 500.0,
              floating: true,
              pinned: false,
              automaticallyImplyLeading: false,
              backgroundColor:  Color.fromARGB(255, 215, 245, 248),
              flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'content',
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/persons.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.centerRight,
                            color: Colors.transparent,
                            height: 120,
                            child: GestureDetector(
                              onTap: (){
                                FirebaseAuth.instance.signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (builder) => LoginPage())
                                );
                              },
                              child: Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ),
              ),
          ];
        },
        body: Container(
          color: Color.fromARGB(255, 215, 245, 248),
          child: Column(
            children: <Widget>[
              createContentArea()
            ],
          ),
        )
    );
  }

  createContentArea() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topRight: const Radius.circular(15.0),
            topLeft: const Radius.circular(15.0)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: StreamBuilder(
          stream: Firestore.instance
            .collection('donations')
            .snapshots(),    
          builder: (ctx, streamSnapshot){
            if(streamSnapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            final documents = streamSnapshot.data.documents;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) => DonationCard(
                documents[index]['project_name'],
                documents[index]['description'],
                documents[index]['email'],
                documents[index]['phone'],
                documents[index]['donation_type']
              )
            );
          },
        )
      )
    );
  }

}
