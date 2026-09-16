import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ), // ThemeData
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PRAKTIKUM MOBILE LANJUT'),
        ), // AppBar
        body: const Center(
          child: Text(
             'Ini perubahan di Pertemuan 2',
            style: TextStyle(fontSize: 24),
          ), // Text
        ), // Center
      ), // Scaffold
    ); // MaterialApp
  }
}