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
                  micIcon: null,
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
                        backgroundColor: Appcolor.backgroundcolor,
                        title: "User Voice Print Enrollment",
                        micIcon: null,
                        styleTitle: AppStyle.headlineStyle3,
                        setBoder: true),
                    Container(
                      decoration:
                          const BoxDecoration(color: Appcolor.iconColor1),
                      height: 100,
                      width: double.infinity,
                    ),
                    textBox(context,
                        backgroundColor: Appcolor.backgroundcolor,
                        title: "Start Recording",
                        micIcon: Icons.mic,
                        styleTitle: AppStyle.headlineStyle4,
                        setBoder: false),
                    textBox(context,
                        backgroundColor: Appcolor.backgroundcolor,
                        title: "Stop Recording",
                        micIcon: Icons.mic_off,
                        styleTitle: AppStyle.headlineStyle4,
                        setBoder: false)
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {},
                child: textBox(context,
                    micIcon: null,
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
