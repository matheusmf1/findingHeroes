import 'package:finding_heroes/pages/donation_detail_page.dart';
import 'package:flutter/material.dart';

class DonationCard extends StatefulWidget {
  String _project_name;
  String _description;
  String _email;
  String _phone;
  String _donation_type;


  DonationCard(this._project_name, this._description, this._email,
  this._phone, this._donation_type);
  @override
  _DonationCardState createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      decoration: new BoxDecoration(
          color: Color.fromARGB(100, 180, 180, 180),
          borderRadius: new BorderRadius.all(Radius.circular(10.0))
      ),
      child: Column(
        children: <Widget>[
          createTitle(),
          createContent(),
          createSaibaMais()
        ],
      ),    
    );
  }

  createTitle() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Text(
          widget._project_name,
          style: TextStyle(
            color: Color.fromARGB(250, 50, 50, 50),
            fontSize: 24,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic
          ),
        ),
      ),
    );
  }

  createContent() {
    return Expanded(
      flex: 5,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Text(
            widget._description
        ),
      ),
    );
  }
  
  createSaibaMais() {
    return Expanded(
      flex: 2,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(120, 100, 100, 100),
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Center(
                  child: Text(
                    widget._donation_type,
                    style: TextStyle(
                      color: Color.fromARGB(220, 255, 255, 255),                      
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
              child: Center(
                child: GestureDetector(
                  onTap: (){          
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => DonationDetailPage(widget._project_name, widget._description, 
                        widget._email, widget._phone, widget._donation_type)
                      )
                    );          
                  },
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.all(Radius.circular(30.0))
                    ),
                    width: 130,
                    child: Center(
                      child: Text(
                        "Saiba Mais",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
