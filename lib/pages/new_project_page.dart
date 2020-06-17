import 'package:finding_heroes/widgets/new_project_widget.dart';
import 'package:flutter/material.dart';


class NewProjectPage extends StatefulWidget {
  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createNewProjPageBody(),
    );
  }

  _createNewProjPageBody() {
    return Container(
      color: Color.fromARGB(255, 112, 167, 169),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(   
              padding: const EdgeInsets.all(10),       
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.fill,
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
              child: NewProjectWidget()
            )
          ),
        ],
      ), 
    );
  }


}

