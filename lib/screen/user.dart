import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:app/route/name.dart';
import 'package:app/widget/box.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String textvalue = "";
    String? errorText(String? value) {
      if (value!.isEmpty) {
        return "you must fill your name";
      } else if (value.contains('@')) {
        return 'Do not use the @ char.';
      }
      return null;
    }

    void checkText(BuildContext context) {
      if (errorText(textvalue)!.isNotEmpty) {
        print(textvalue);
        return;
      }
      Navigator.of(context).pushNamed(Approutes.REGISTER);
    }

    return Scaffold(
      /* backgroundColor: Appcolor.backgroundcolor, */
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          color: Appcolor.backgroundcolor,
          child: Column(
            children: [
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
                        icon: Icons.person,
                        validator: errorText, onChanged: (value) {
                        textvalue = value;
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                  onTap: () {
                    checkText(context);
                  },
                  child: navigationButton(context,
                      backgroundColor: Appcolor.mainColor,
                      title: "Next",
                      styleTitle: AppStyle.headlineStyle4
                          .copyWith(color: Appcolor.whiteColor)))
            ],
          ),
        ),
      ),
    );
  }
}
