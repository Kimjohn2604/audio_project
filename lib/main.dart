import 'package:app/component/colors.dart';
import 'package:app/route/name.dart';
import 'package:app/screen/init.dart';
import 'package:app/screen/register.dart';
import 'package:app/screen/sign_in.dart';
import 'package:app/screen/user.dart';
import 'package:app/screen/validation.dart';
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
      title: 'Audio Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Appcolor.mainBlackColor),
        useMaterial3: true,
      ),
      home: const InitialScreen(),
      routes: {
        Approutes.USER: (context) => const UserScreen(),
        Approutes.REGISTER: (context) => const RegisterScreen(),
        Approutes.SIGN_IN: (context) => const SignInScreen(),
         Approutes.VALIDATION: (context) => const ValidationScreen(),
        /* Approutes.VOICE_ENROLLMENT: (context) => const VoiceEnrollMent() */
      },
    );
  }
}
