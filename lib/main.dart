import 'package:flutter/material.dart';
import 'package:pluto/model.dart';
import 'package:pluto/screens/bir_home.dart';
import 'package:pluto/screens/home.dart';
import 'package:pluto/screens/login.dart';
import 'package:pluto/screens/signup.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Model(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      title: 'Electronic Official Receipt',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignupScreen(),
        '/bir/home': (context) => BIRHomeScreen(),
      },
      home: LoginScreen(),
    );
  }
}
