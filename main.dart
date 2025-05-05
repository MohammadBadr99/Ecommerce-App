import 'package:ecommerce/CRUD/login.dart';
import 'package:ecommerce/CRUD/signup.dart';
import 'package:ecommerce/Models/CartModel.dart';
import 'package:ecommerce/checkout.dart';
import 'package:ecommerce/homepage.dart';
import 'package:ecommerce/menpage.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  runApp(const ecommerceApp());
}

// ignore: camel_case_types
class ecommerceApp extends StatefulWidget {
  const ecommerceApp({Key? key}) : super(key: key);

  @override
  State<ecommerceApp> createState() => _ecommerceAppState();
}

// ignore: camel_case_types
class _ecommerceAppState extends State<ecommerceApp> {
  get index => null;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => Cart()),
      builder: (context, child) {
        return MaterialApp(
            home: ChangeNotifierProvider(create: ((context) {
              return Cart();
            }), builder: ((context, child) {
              return FirebaseAuth.instance.currentUser == null
                  ? homepage()
                  : homepage();
            })),
            routes: {
              'home': (context) => const homepage(),
              'men': (context) => const menpage(),
              'signUp': (context) => const SignUp(),
              'logIn': (context) => const LoginPage(),
              'checkout': (context) => const chechout()
            },
            theme: ThemeData(
                textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
              titleSmall: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
              bodyMedium: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
              bodySmall: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
              titleMedium: TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold),
              displaySmall: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )));
      },
    );
  }
}
