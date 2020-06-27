import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finding_heroes/widgets/animated_alert_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usrName = TextEditingController();
  var _isLogin = true;
  var _usrEmail = '';
  var _usrPassword = '';
  var _usrType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 132, 187, 189),
        child: Column(children: <Widget>[
          Expanded(
            flex: 2,
            child: _createLogoArea(),
          ),
          Expanded(
            flex: 6,
            child: _createCreateAccountForm(context),
          )
        ],),
      ),
    );
  }
  _createLogoArea(){
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Center(
        child: Hero(
          tag: 'content',
          child: Image(
            image: AssetImage("assets/images/logo.png"),
            width: 270,
          ),
        ),
      ),
    );
  }

  _createCreateAccountForm(ctx) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
            )
        ),
        child: KeyboardAvoider(
          autoScroll: true,
          child: Column(
            children: <Widget>[
              Container(
                height: 120,
                child: Center(
                  child: Text(
                    "Faça o seu cadastro",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 120, 120, 120)
                    ),
                  ),
                ),
              ),
              _createEmailFormField(),
              _createUserNameFormField(_usrName),
              _createPasswordFormField(),
              _createUsrTypeRadioArea(),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: GestureDetector(
                        onTap: () => _trySubmit(ctx),
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                "Cadastrar",
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
          ),
        ),
      ),
    );
  }

  _createEmailFormField(){
    return  Container(
      height: 80,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: new BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
              borderRadius: new BorderRadius.all(Radius.circular(20))
          ),
          child: TextFormField(
            validator: (value){
              if(value.isEmpty || !value.contains('@')){
                return 'Porfavor, entre com um email valido';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Email',
                border: InputBorder.none,
                hintText: 'Email'
            ),
            onSaved: (value) {
              this._usrEmail = value;
            },
          ),
        ),
      ),
    );
  }

  _createUserNameFormField(_usrName){
    return Container(
      height: 80,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: new BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
              borderRadius: new BorderRadius.all(Radius.circular(20))
          ),
          child: TextFormField(
            controller: _usrName,
            validator: (value){
              if(value.isEmpty){
                return "Entre com um nome de usuario valido";
              }
              return null;
            },
            decoration: const InputDecoration(
                labelText: 'Nome do Usuario',
                border: InputBorder.none,
                hintText: 'Nome do Usuario'
            ),
          ),
        ),
      ),
    );
  }

  _createPasswordFormField(){
    return Container(
      height: 80,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: new BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
              borderRadius: new BorderRadius.all(Radius.circular(20))
          ),
          child: TextFormField(
            validator: (value){
              if(value.isEmpty || value.length <= 7){
                return "Crie uma senha com 8 caracteres no minimo";
              }
              return null;
            },
            obscureText: true,
            decoration: const InputDecoration(
                labelText: 'Senha',
                border: InputBorder.none,
                hintText: 'Senha'
            ),
            onSaved: (value){
              this._usrPassword = value;
            },
          ),
        ),
      ),
    );
  }

  _createUsrTypeRadioArea(){
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: new BoxDecoration(
          color: Color.fromARGB(255, 230, 230, 230),
          borderRadius: new BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        children: <Widget>[
          Container(
            child:ListTile(
              title: Text("Quero  fazer uma doação!"),
              leading: Radio(
                groupValue: _usrType,                     
                value: 0,          
                onChanged: (val){
                  setState(() {
                    _usrType = val;
                  });
                },
              ),
            )       
          ),
          Container(
            child:ListTile(
              title: Text("Quero receber doação!"),
              leading: Radio(
                groupValue: _usrType,                   
                value: 1, 
                onChanged: (val){
                  setState(() {
                    _usrType = val;
                  });
                },              
              ),
            )       
          ),
        ],
      ),
    );
  }

  _trySubmit(ctx) async {
    AuthResult authResult;
    String msg;
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(isValid){
      _formKey.currentState.save();

      try {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: this._usrEmail.trim(),
            password: this._usrPassword.trim()
        );
        Firestore.instance.collection('users')
        .document(authResult.user.uid)
        .setData({
          'username': _usrName.value.text.trim(),
          'user_type':_usrType
        });


        msg = 'Cadastrado com sucesso';

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
                       Navigator.pop(ctx);
                       Navigator.pop(ctx);
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

      }on PlatformException catch (err){
        msg = 'Ocorreu um erro, favor verificar suas credenciais';

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

}