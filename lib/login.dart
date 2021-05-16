import 'package:flutter/material.dart';
import 'package:trackit/Animations/FadeAnimation.dart';
import 'package:trackit/main_screen.dart';
import 'package:trackit/Data.dart';
import 'package:trackit/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
              child: Column(children: <Widget>[
        Container(
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 30,
                width: 80,
                height: 200,
                child: FadeAnimation(
                    1,
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/light-1.png'),
                      )),
                    )),
              ),
              Positioned(
                left: 140,
                width: 80,
                height: 150,
                child: FadeAnimation(
                    1.3,
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/light-2.png'),
                        ),
                      ),
                    )),
              ),
              Positioned(
                child: FadeAnimation(
                    1.6,
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                      1.8,
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, 0.2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Colors.grey[100],
                                ))),
                                child: TextFormField(
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return "Enter Email";
                                    }
                                  },
                                  onSaved: (input) {
                                    _email = input;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "Email",
                                      hintText: "Enter Email",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                      )),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (input) {
                                    if (input.length < 6) {
                                      return "Enter ateast 6 characters";
                                    }
                                  },
                                  onSaved: (input) {
                                    _password = input;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Password",
                                    hintText: "Enter Password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                  2,
                                  Container(
                                      height: 50,
                                      child: ElevatedButton(
                                          onPressed: navLogin,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Color.fromRGBO(
                                                      143, 148, 251, 1),
                                                  Color.fromRGBO(
                                                      143, 148, 251, .6),
                                                ]),
                                              ),
                                              child: Center(
                                                  child: Text("Login",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ))))))),
                            ],
                          ))),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.5,
                      Container(
                          child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New User?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Text("Sign Up",
                                    style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                    ))),
                          ],
                        ),
                      )))
                ],
              ),
            ))
      ]))),
    );
  }

  Future<void> navLogin() async {
    final formstate = _formkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        User user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        final data = Data(usermail: _email);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(data: data)));
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Enter valid Email and Password"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("CLOSE"),
                  )
                ],
              );
            });
      }
    }
  }
}
