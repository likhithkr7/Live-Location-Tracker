import 'package:flutter/material.dart';
import 'package:trackit/Animations/FadeAnimation.dart';
import 'package:trackit/main.dart';
import 'package:trackit/main_screen.dart';
import 'package:trackit/login.dart';
import 'package:trackit/Data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password, _name;
  bool _passwordVisible=false;

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
                          "SignUp",
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
                                      return "Enter Username";
                                    }
                                  },
                                  onSaved: (input) {
                                    _name = input;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "Name",
                                      hintText: "Enter username",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                      )),
                                ),
                              ),
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
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Password",
                                    hintText: "Enter Password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                                      color: Colors.blue[800],
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                          });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                  2,
                                  Container(
                                      height: 50,
                                      child: ElevatedButton(
                                          onPressed: navSignUp,
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
                                                  child: Text("SignUp",
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
                            Text("Already have an account?"),
                            TextButton(
                                onPressed: navLogin,
                                child: Text("Login",
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

  void navLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  void navSignUp() async {
    final formstate = _formkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        ))
            .user;
        if (user != null) {
          Map userDataMap = {
            "name": _name.trim(),
            "email": _email.trim(),
            "password": _password.trim(),
          };
          usersRef.child(user.uid).set(userDataMap);
          final data = Data(username: _name, usermail: _email);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(data: data)));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("User Not Created"),
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
        //user.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        print(e.message);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(e.code),
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
