import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:app/widget/box.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* backgroundColor: Appcolor.backgroundcolor, */
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.8,
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
                  micIcon: null,
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
                        micIcon: null,
                        styleTitle: AppStyle.headlineStyle3,
                        setBoder: true),
                    customTextForm(context,
                        labelText: 'Enter your Username',
                        icon: Icons.person, validator: (String? value) {
                      return value!.contains('@')
                          ? 'Do not use the @ char.'
                          : null;
                    }, onChanged: () {}),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "register");
                },
                child: textBox(context,
                    verticalPadding: 10,
                    backgroundColor: Appcolor.mainColor,
                    micIcon: null,
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
