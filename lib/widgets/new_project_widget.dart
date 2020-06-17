import 'package:finding_heroes/widgets/animated_alert_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class NewProjectWidget extends StatefulWidget {
  @override
  _NewProjectWidgetState createState() => _NewProjectWidgetState();
}

class _NewProjectWidgetState extends State<NewProjectWidget> {

  final project_name_controller = TextEditingController();
  final project_detail_controller = TextEditingController();
  final project_phone_controller = TextEditingController();
  final project_email_controller = TextEditingController();
  String selected_value = "Tipo de doação";

  @override
  void dispose() {    
    project_name_controller.dispose();
    project_detail_controller.dispose();
    project_phone_controller.dispose();
    project_email_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: KeyboardAvoider(
        autoScroll: true,
        child: Column(
          children: <Widget>[
            _createProjectNameFormField(),
            _createProjectDetailFormField(),
            _createPhoneFormField(),
            _createEmailFormField(),
            _createValueFormField(),
          ],
        ),
      ),
    );
  }


  _createProjectNameFormField(){
    return Container(
      height: 55,  
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: new BoxDecoration(
          color: Color.fromARGB(255, 210, 210, 210),
          borderRadius: new BorderRadius.all(Radius.circular(20))
      ),
      child: TextFormField(   
        controller: project_name_controller,
        validator: (value){
          if(value.isEmpty){
            return "Entre com um nome projeto";
          }
          return null;
        },     
        decoration: const InputDecoration(
            labelText: 'Nome do Projeto',
            border: InputBorder.none,
            hintText: 'Nome do Projeto'
        ),        
      ),
    );
  }

  _createProjectDetailFormField(){
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: new BoxDecoration(
          color: Color.fromARGB(255, 210, 210, 210),
          borderRadius: new BorderRadius.all(Radius.circular(20))
      ),
      child: TextFormField(  
        controller: project_detail_controller,
        validator: (value){
          if(value.isEmpty){
            return "Escreva um detalhe sobre o seu projeto";
          }
          return null;
        },   
        keyboardType: TextInputType.multiline,
        maxLines: 2,  
        decoration: const InputDecoration(
            labelText: 'Detalhes',
            border: InputBorder.none,
            hintText: 'Detalhes'
        ),        
      ),    
    );
  }

  _createPhoneFormField(){
    return Container(
      height: 55,  
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: new BoxDecoration(
          color: Color.fromARGB(255, 210, 210, 210),
          borderRadius: new BorderRadius.all(Radius.circular(20))
      ),
      child: TextFormField( 
        controller: project_phone_controller,
        validator: (value){
          if(value.isEmpty){
            return "Entre com um telefone";
          }
          return null;
        },   
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
            labelText: 'Telefone para contato',
            border: InputBorder.none,
            hintText: 'Telefone para contato'
        ),        
      ),   
    );
  }

  _createEmailFormField(){
    return Container(
      height: 55,    
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: new BoxDecoration(
          color: Color.fromARGB(255, 210, 210, 210),
          borderRadius: new BorderRadius.all(Radius.circular(20))
      ),
      child: TextFormField(   
        controller: project_email_controller,
        validator: (value){
          if(value.isEmpty){
            return "Entre com um email";
          }
          return null;
        }, 
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            labelText: 'Email para contato',
            border: InputBorder.none,
            hintText: 'Email para contato'
        ),        
      ),              
    );
  }

  _createValueFormField(){
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            child: Center(
              child: Container(
                width: 200,
                height: 40, 
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: new BoxDecoration(
                    color: Color.fromARGB(255, 210, 210, 210),
                    borderRadius: new BorderRadius.all(Radius.circular(20))
                ),
                child: DropdownButton<String>(
                  hint: Text(selected_value),
                  items: <String>['Alimentos', 'Roupas', 'Brinquedos', 'Livros', 'Dinheiro']
                  .map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selected_value = value;
                    });              
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Center(
              child: GestureDetector(
                onTap: () => _createNewProject(),
                child: Container(  
                  height: 40,     
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),    
                   decoration: new BoxDecoration(
                    color: Color.fromARGB(255, 112, 167, 169),
                    borderRadius: new BorderRadius.all(Radius.circular(20))
                  ),
                  child: Center(
                    child: Text(
                      "Criar Projeto",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _createNewProject() async {   
    String msg;
    try{
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser user = await _auth.currentUser();

      await Firestore.instance.collection('donations')
      .document(user.uid)
      .setData({
        'project_name': project_name_controller.text,
        'description': project_detail_controller.text,
        'email': project_email_controller.text,
        'phone': project_phone_controller.text,
        'donation_type': selected_value
      });   

      msg = 'Projeto cadastrado com sucesso';

      showDialog(
        context:  context,
        builder:  (BuildContext context) {
          return AlertDialog(
            title: Icon(Icons.check, color: Colors.green,),
            content: Container(
              height: 100,
              child: Column(
                children: <Widget>[
                  Text(msg),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Text(
                        "Continuar",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          );
        },
      );
    }catch (err){
        msg = 'Ocorreu um erro, favor verificar os dados preenchidos';

        showDialog(
          context: context,
          builder: (_) => AnimatedAlertWidget(
            Icon(Icons.error, color: Colors.red,),
            msg
          )
        );
      }
    }
}
