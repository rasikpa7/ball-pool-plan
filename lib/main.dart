import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/view/homeScreen/home_screen.dart';


void main() async {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        title: 'Plan it',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(color: Color(0xff3f4850), elevation: 0)),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}
