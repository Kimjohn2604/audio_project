import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:app/route/name.dart';
import 'package:app/widget/box.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage(
                      "assets/items/tma.jpg",
                    ),
                  )),
              height: 147,
              width: 302,
            ),
            const SizedBox(
              height: 50,
            ),
            textBox(context,
                verticalPadding: 20,
                backgroundColor: Appcolor.backgroundcolor,
                title: "VoiceSens Sample Web Application",
                styleTitle: AppStyle.headlineStyle2,
                setBoder: false),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "signin");
                },
                child: navigationButton(
                  context,
                  backgroundColor: Appcolor.mainColor,
                  title: 'Login',
                  styleTitle: AppStyle.headlineStyle4
                      .copyWith(color: Appcolor.whiteColor),
                )),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Approutes.USER);
                },
                child: navigationButton(
                  context,
                  backgroundColor: Appcolor.mainColor,
                  title: 'Register',
                  styleTitle: AppStyle.headlineStyle4
                      .copyWith(color: Appcolor.whiteColor),
                ))
          ],
        ),
      ),
    );
  }
}
