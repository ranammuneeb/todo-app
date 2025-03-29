import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/screen/homepage.dart';

void main() {
  runApp( 
    DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(),
  ),);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      //theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home:  Homepage(),
      //theme: ThemeData.dark(),
      title: "Todo App",
      debugShowCheckedModeBanner: false,
    
    );
  }
}