import 'package:bioappmikary/pages/src/bluetooth/bluetoothv2.dart';
import 'package:bioappmikary/pages/src/menu/menu.dart';
import 'package:bioappmikary/pages/src/splashScreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Menu()
    );
  }
}