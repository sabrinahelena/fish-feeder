import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trabalho_lddm/telalogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  //This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: telalogin()
    );
  }
}