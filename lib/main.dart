import 'package:app1/page/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
        appBarTheme: AppBarTheme(
          color: Colors.lightBlueAccent,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.lightBlueAccent),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          )
        ),
        useMaterial3: true,

      ),

      home: HomePage(),
    );
  }
}
