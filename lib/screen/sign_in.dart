import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:app/widget/box.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String textEmail = "";
  String textPass = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* backgroundColor: Appcolor.backgroundcolor, */
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          color: Appcolor.backgroundcolor,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage(
                        "assets/items/audio.png",
                      ),
                    )),
                height: 50,
                width: 50,
              ),
              textBox(context,
                  verticalPadding: 15,
                  backgroundColor: Appcolor.backgroundcolor,
                  title: "VoiceSens Sample Web Application",
           
                  styleTitle: AppStyle.headlineStyle2,
                  setBoder: false),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Appcolor.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    textBox(context,
                        verticalPadding: 15,
                        backgroundColor: Appcolor.backgroundcolor,
                        title: "User Signin",
            
                        styleTitle: AppStyle.headlineStyle3,
                        setBoder: true),
                    customTextForm(context,
                        labelText: 'Enter your Username',
                         validator: (String? value) {
                      return value!.contains('@')
                          ? 'Do not use the @ char.'
                          : null;
                    }, onChanged: (value) {
                      textEmail = value;
                    }),
                    customTextForm(context,
                        labelText: 'Enter your Password',
                     validator: (String? value) {
                      return value!.contains('x')
                          ? 'Do not use the @ char.'
                          : null;
                    }, onChanged: (value) {}),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {},
                child: textBox(context,
                    verticalPadding: 10,
           
                    backgroundColor: Appcolor.mainColor,
                    title: "Next",
                    styleTitle: AppStyle.headlineStyle4
                        .copyWith(color: Appcolor.whiteColor),
                    setBoder: false),
              )
            ],
          ),
        ),
      ),
    );
  }
}
