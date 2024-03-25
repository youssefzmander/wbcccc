import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:wbcc/view/SignIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 249, 0, 0)),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget { 
  @override 
  _MyHomePageState createState() => _MyHomePageState(); 
} 
class _MyHomePageState extends State<MyHomePage> { 
  @override 
  void initState() { 
    super.initState(); 
    Timer(Duration(seconds: 3), 
   ()=>Navigator.pushReplacement(context, 
     MaterialPageRoute(builder: 
    (context) =>   SignIn()    ) 
 ) 
         ); 
  } 
  @override 
 Widget build(BuildContext context) {
  return Container(
    color: Color.fromARGB(255, 216, 194, 194),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          width: double.infinity,
          height: 200,
        ),
        SizedBox(height: 20), 
        AnimatedTextKit(
  animatedTexts: [
    TypewriterAnimatedText(
      'WBCC ASSISTANCE',
      textStyle: const TextStyle(
        color: Colors.red,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      speed: const Duration(milliseconds: 80),
    ),
  ],
  displayFullTextOnTap: true,
  isRepeatingAnimation: false,
  

)
      ],
    ),
  );
}
} 