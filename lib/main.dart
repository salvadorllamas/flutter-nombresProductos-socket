import 'package:ban_name/pages/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'nueva aplicasion',
      initialRoute: 'home',
      routes: {'home': (_) => const HomePage()},
    );
  }
}
