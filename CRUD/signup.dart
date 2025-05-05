import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool visibility = false;
  Icon iconVisibilty = Icon(Icons.visibility);
  TextEditingController? email = TextEditingController();
  TextEditingController? password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  RegExp patternEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

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
                  "Register",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Register your e-commerce account",
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
                  "Username",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Enter your Username",
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
                    controller: email,
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
                    controller: password,
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
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Confirm Password",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
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
                        hintText: "Confirm your Password",
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
                width: 150,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30)),
                child: GestureDetector(
                    onTapDown: (details) async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email!.text,
                          password: password!.text,
                        );
                        Navigator.pushReplacementNamed(context, "home");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The Password provided is too weak!',
                          )..show();
                        } else if (e.code == 'email-already-in-use') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'This email is already registered!',
                          )..show();
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Divider(
                color: Colors.transparent,
              )
            ],
          ),
        ),
      )),
    );
  }
}
