import 'package:app/component/colors.dart';
import 'package:app/route/name.dart';
import 'package:app/screen/init.dart';
import 'package:app/screen/register/validation/invalid_register.dart';
import 'package:app/screen/register/validation/valid_register.dart';
import 'package:app/screen/register/voice_register.dart';
import 'package:app/screen/sign_in/sign_in.dart';
import 'package:app/screen/register/user_register.dart';
import 'package:app/screen/register/validation/validation_register.dart';
import 'package:app/screen/sign_in/validation/valid_sign_in.dart';
import 'package:app/screen/sign_in/validation/validation_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.microphone.request();
  await Permission.storage.request();

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
        Approutes.REGISTER_VALIDATION: (context) => const RegisterValidation(),
        Approutes.SIGNIN_VALIDATION: (context) => const SigninValidation(),
        Approutes.SUCCESS_REGISTRATION: (context) => ValidRegistration(),
        Approutes.FAILURE_REGISTRATION: (context) =>
            const InvalidRegistration(),
        Approutes.SUCCESS_SIGNIN: (context) => ValidLogin(),
      },
    );
  }
}
