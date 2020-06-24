import 'package:finding_heroes/pages/mercado_pago_donation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DonationDetailPage extends StatefulWidget {
  @override
  String _project_name;
  String _description;
  String _email;
  String _phone;
  String _donation_type;

  DonationDetailPage(this._project_name, this._description, this._email,
  this._phone, this._donation_type);

  @override
  _DonationDetailPageState createState() => _DonationDetailPageState();
}

class _DonationDetailPageState extends State<DonationDetailPage> {

	TextEditingController _valorInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_createDetailBody(),
    );
  }

  _createDetailBody() {
    return Scaffold(
        body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 150.0,
                floating: true,
                pinned: false,
                backgroundColor:   Color.fromARGB(255, 112, 167, 169),
                flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'content',
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                        child: Image(                      
                          image: AssetImage(
                            'assets/images/logo.png'                        
                            ),
                            width: 50,
                          ),
                      ),
                    )
                  ),
                ),
            ];
          },
          body: Container(
            color: Color.fromARGB(255, 112, 167, 169), 
            child: Container(        
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),    
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                )
              ),
              child: Column(
                children: <Widget>[
                  _createTitleArea(),
                  _createDetailArea(),
                  _createTipoDoacaoArea(),
                  _createEmailArea(),
                  _createTelefoneArea(),
                  _createDonationArea(),
                ],
              ),
            ),        
          )
        ),
      ),
    );  
  }
                
  _createTitleArea() {
    return Container(
      height: 100,
      child: Center(
        child: Text(
          widget._project_name,
          style: TextStyle(
            color: Color.fromARGB(250, 50, 50, 50),
            fontSize: 35,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic
          ),
        ),
      ),
    );
  }

  _createDetailArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: 250,
      child: Text(
        widget._description,
        style: TextStyle(
          color: Color.fromARGB(200, 50, 50, 50),
          fontSize: 18,
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.italic
        ),
      ),      
    );
  }

  _createTipoDoacaoArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            "Tipo de doação: ",
            style: TextStyle(
              color: Color.fromARGB(250, 50, 50, 50),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic
            ),
          ),  
          Text(
            widget._donation_type,
            style: TextStyle(
              color: Color.fromARGB(250, 50, 50, 50),
              fontSize: 22,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic
            ),
          ),     
        ],
      )
    );
  }

  _createEmailArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            "Email: ",
            style: TextStyle(
              color: Color.fromARGB(250, 50, 50, 50),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic
            ),
          ),  
          Text(
            widget._email,
            style: TextStyle(
              color: Color.fromARGB(250, 50, 50, 50),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic
            ),
          ),     
        ],
      )
    );
  }

  _createTelefoneArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            "Telefone: ",
            style: TextStyle(
              color: Color.fromARGB(250, 50, 50, 50),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic
            ),
          ),  
          Text(
            widget._phone,
            style: TextStyle(
              color: Color.fromARGB(250, 50, 50, 50),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic
            ),
          ),     
        ],
      )
    );
  }

 _createDonationArea() {
  
    if ( widget._donation_type == "Livros" ) {

      return MercadoPagoDonation();

    } else {
      return Container();
    }
  }



}