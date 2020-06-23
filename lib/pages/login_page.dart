import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finding_heroes/widgets/animated_alert_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'create_account_page.dart';
import 'home_donators_page.dart';
import 'home_recivers_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin  {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();  
  TextEditingController _passwordController = TextEditingController();  
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Color.fromARGB(255, 132, 187, 189),
        child: Column(children: <Widget>[
          Expanded(
            flex: 2,
            child: _createLogoArea(),
          ),
          Expanded(
            flex: 6,
            child: _createLoginForm(),
        )
      ],),
    ),
  );
 }

  _createLogoArea() {
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
          
  _createLoginForm() {
    return Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(        
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
        ),
        child: Column(children: <Widget>[
          Expanded(
            flex: 4,
            child: _createLoginButtons(),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Image(        
                image: AssetImage("assets/images/persons2.png"),
              ),
            ),
          )          
        ],),
    );
  }

  _createLoginButtons() {
        return Column(children: <Widget>[
          Container(
            height: 90,
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 150, 150, 150)
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: new BoxDecoration(
                color: Color.fromARGB(255, 230, 230, 230),
                borderRadius: new BorderRadius.all(Radius.circular(20))
            ),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: InputBorder.none,
                  hintText: 'Email'
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: new BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
              borderRadius: new BorderRadius.all(Radius.circular(20))
            ),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                  labelText: 'Senha',
                hintText: 'Senha'
             ),
          ),
      ),
      Container(
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                height: 80,
                width: (MediaQuery.of(context).size.width/2)  - 40,
                child: Center(
                  child:  GestureDetector(
                    onTap: () => _loginUser(),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: new BoxDecoration(
                        color: Color.fromARGB(255, 170, 191, 81),
                        borderRadius: new BorderRadius.all(Radius.circular(24))
                      ),
                      child: Center(
                        child: Text(
                          "Entrar",
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
            Container(
              height: 80,
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              width: (MediaQuery.of(context).size.width/2),
              padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (buillder) => CreateAccountPage())
                  );
                },
                child: Text(
                  "Criar uma conta",
                  style: TextStyle(
                    color: Color.fromARGB(255, 106, 176, 76),
                    decoration: TextDecoration.underline,
                    fontSize: 16
                  ),
                ),
              ),
            )
          ],
        ),
      )
    ],);
  }

  _loginUser() async {
    AuthResult _autResult;

    try {
      _autResult = await _auth.signInWithEmailAndPassword(
        email: _emailController.value.text.trim(),
        password: _passwordController.value.text.trim()
      );

      if(!_autResult.user.uid.isEmpty){

       await Firestore.instance.collection('users')
       .document(_autResult.user.uid)
       .get()
       .then((value) {
         if(value.data.values.toList()[0] == 1){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => HomeReciversPage(value.data.values.toList()[1], _autResult.user.uid))
          );
         }else{
           Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => HomeDonatorsPage())
          );
         }

       }); 
      }else{
        showDialog(
          context: context,
          builder: (_) => AnimatedAlertWidget(
            Icon(Icons.error, color: Colors.red,),
            "Ocorreu um erro. Tente novamente mais tarde" 
          )
        );
      }
    } catch (e) {    
      showDialog(
        context: context,
        builder: (_) => AnimatedAlertWidget(
          Icon(Icons.error, color: Colors.red,),
          "Email ou senha incorretos"
        )
      );
    }
  }

}