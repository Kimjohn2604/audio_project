import 'package:app/component/colors.dart';
import 'package:app/screen/sign_in.dart';
import 'package:app/screen/sign_up.dart';
import 'package:app/screen/voice_enrollment.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Appcolor.mainBlackColor),
        useMaterial3: true,
      ),
      home: const VoiceEnrollMent(),
    );
  }
}
