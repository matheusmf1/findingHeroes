import 'package:flutter/material.dart';

class DonationCard extends StatefulWidget {
  String _titulo;
  String _text;
  DonationCard(this._titulo, this._text);
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
          widget._titulo,
          style: TextStyle(
            color: Colors.red,
            fontSize: 24,
            fontWeight: FontWeight.w600
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
            widget._text
        ),
      ),
    );
  }

  createSaibaMais() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: const EdgeInsets.fromLTRB(240, 0, 15, 15),
        decoration: new BoxDecoration(
            color: Colors.blue,
            borderRadius: new BorderRadius.all(Radius.circular(10.0))
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
    );
  }
}
