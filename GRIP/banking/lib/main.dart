import 'package:banking/core/sqldatabase.dart';
import 'package:flutter/material.dart';

import 'pages/customer details.dart';
import 'pages/customers list.dart';
import 'pages/home page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SqlDB sqlDB = SqlDB();
  sqlDB.db;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomersList(),
    );
  }
}

