import 'package:flutter/material.dart';
import 'package:todo/screen/homepage.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Homepage(),
      theme: ThemeData.dark(),
      title: "Todo App",
      debugShowCheckedModeBanner: false,
    
    );
  }
}