import 'package:flutter/material.dart';

class DonationDetailWidget extends StatelessWidget {
  String _project_name;
  String _description;
  String _email;
  String _phone;
  String _donation_type;
  DonationDetailWidget(this._project_name, this._description, this._email,
  this._phone, this._donation_type); 

  Widget build(BuildContext context) {
    return Container(
      child: Container(        
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),    
        child: Column(
          children: <Widget>[
            _createTitleArea(),
            _createDetailArea(),
            _createTipoDoacaoArea(),
            _createEmailArea(),
            _createTelefoneArea()
          ],
        ),
      ),        
    ); 
  }

   _createTitleArea() {
    return Container(
      height: 100,
      child: Center(
        child: Text(
          _project_name,
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
        _description,
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
            _donation_type,
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
            _email,
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
            _phone,
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
}