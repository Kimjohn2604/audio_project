import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:app/widget/box.dart';
import 'package:flutter/material.dart';

class VoiceEnrollMent extends StatelessWidget {
  const VoiceEnrollMent({super.key});

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
                        "assets/items/tma.jpg",
                      ),
                    )),
                height: 50,
                width: 100,
              ),
              textBox(context,
                  verticalPadding: 15,
                  micIcon: null,
                  backgroundColor: Appcolor.backgroundcolor,
                  title: "VoiceSens Sample Web Application",
                  styleTitle: AppStyle.headlineStyle1,
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
                        title: "User Voice Print Enrollment",
                        micIcon: null,
                        styleTitle: AppStyle.headlineStyle2,
                        setBoder: true),
                    Container(
                      decoration:
                          const BoxDecoration(color: Appcolor.iconColor1),
                      height: 100,
                      width: double.infinity,
                    ),
                    textBox(context,
                        verticalPadding: 5,
                        backgroundColor: Appcolor.backgroundcolor,
                        title: "Start Recording",
                        micIcon: Icons.mic,
                        styleTitle: AppStyle.headlineStyle4,
                        setBoder: false),
                    textBox(context,
                        verticalPadding: 5,
                        backgroundColor: Appcolor.textColor,
                        title: "Stop Recording",
                        micIcon: Icons.mic_off,
                        styleTitle: AppStyle.headlineStyle4,
                        setBoder: false),
                    const SizedBox(
                      height: 20,
                    ),
                   /*  authentiactionBox(context,
                        bigText: "Please recite the following words",
                        smallText: "months truth capacitance galley agreement",
                        themeColor: Appcolor.mainColor) */
                        warningBox(context,showDetail: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
