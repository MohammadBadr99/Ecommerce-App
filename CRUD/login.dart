import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visibility = false;
  Icon iconVisibilty = Icon(Icons.visibility);
  TextEditingController? useremail = TextEditingController();
  TextEditingController? userpassword = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  RegExp patternEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  get future => null;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        margin: EdgeInsets.only(right: 10, left: 10, top: 30),
        child: Form(
          key: formState,
          child: ListView(
            children: [
              Center(
                child: Container(
                  width: 75,
                  height: 75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset("images/ecommerce_icon.png",
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login to your e-commerce account",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    controller: useremail,
                    onChanged: (value) {
                      formState.currentState!.validate();
                    },
                    validator: (value) {
                      if (patternEmail.hasMatch(value!) == false) {
                        return "incorrect email form";
                      }
                      if (value.isEmpty) {
                        return "This field can't be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your email",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(30),
                        )),
                  )),
              Divider(
                color: Colors.transparent,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this field can't be empty";
                      }
                    },
                    controller: userpassword,
                    obscureText: visibility,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (visibility == false) {
                                  iconVisibilty = Icon(Icons.visibility_off);
                                  visibility = true;
                                } else {
                                  iconVisibilty = Icon(Icons.visibility);
                                  visibility = false;
                                }
                              });
                            },
                            icon: iconVisibilty),
                        hintText: "Enter your password",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(30),
                        )),
                  )),
              Divider(
                color: Colors.transparent,
              ),
              GestureDetector(
                onTapDown: (details) {
                  print("Forgot Password?");
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Container(
                width: 150,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30)),
                child: GestureDetector(
                    onTapDown: (details) async {
                      if (formState.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: useremail!.text,
                                  password: userpassword!.text);
                          Navigator.pushReplacementNamed(context, "home");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print("User not found");
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'Either Email or Password are not valid.',
                            )..show();
                          } else if (e.code == 'wrong-password') {
                            setState(() {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'Either Email or Password are not valid.',
                              )..show();
                            });
                          }
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Row(children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey[200],
                    thickness: 3,
                  ),
                ),
                Text(" or Login with ",
                    style: Theme.of(context).textTheme.displaySmall),
                Expanded(
                  child: Divider(
                    color: Colors.grey[200],
                    thickness: 3,
                  ),
                ),
              ]),
              ////////////////////////////////////////
              Divider(
                color: Colors.transparent,
              ),
              Row(children: [
                Expanded(
                    child: GestureDetector(
                  onTapDown: (details) {
                    print("Facebook Login");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ],
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(30)),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    width: 50,
                    height: 50,
                    child: Image.asset("images/fb.png"),
                  ),
                )),
                VerticalDivider(
                  color: Colors.transparent,
                ),
                Expanded(
                    child: GestureDetector(
                  onTapDown: (details) {
                    print("Google Login");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ],
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(30)),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    width: 50,
                    height: 50,
                    child: Image.asset('images/google.png'),
                  ),
                )),
              ]),
              Divider(
                color: Colors.transparent,
              ),
              Center(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 75),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 7,
                              child: Center(
                                child: Container(
                                  child: Text("Don't have an account?"),
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: GestureDetector(
                                onTapDown: (details) {
                                  Navigator.pushReplacementNamed(
                                      context, "signUp");
                                },
                                child: Container(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              )),
                        ],
                      )))
            ],
          ),
        ),
      )),
    );
  }
}
