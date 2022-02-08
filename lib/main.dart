import 'package:country_api/screens/country_detail_screen.dart';
import 'package:country_api/screens/country_list_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Country API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CountryListScreen(),
    );
  }
}
