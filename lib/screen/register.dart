import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:app/widget/box.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Could you please press “Record” button and speak following sentense:",
                style: AppStyle.headlineStyle2
                    .copyWith(color: Appcolor.mainBlackColor),
                maxLines: 2,
              ),
              Container(
                height: 515,
                decoration: BoxDecoration(
                    color: Appcolor.backgroundcolor,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Column(
                  children: [
                    detailedContent(context,
                        text:
                            "Sentence 1 (i.e: Hanoi is the capital of Vietnam)"),
                    SizedBox(
                      height: 20,
                    ),
                    detailedContent(context,
                        text:
                            "Sentence 2 (i.e: Team, our manager came to the office this morning and will have a meeting our team this afternoon)"),
                    SizedBox(
                      height: 20,
                    ),
                    detailedContent(context,
                        text:
                            "Sentence 3 (i.e: Manager, the printer is broken, we need to purchase a new one.)"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        color: Appcolor.iconColor1,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            height: 77,
            width: 77,
            color: Appcolor.red,
          ),
          const SizedBox(height: 20,),
          navigationButton(
            context,
            backgroundColor: Appcolor.mainColor,
            title: 'Register',
            styleTitle: AppStyle.headlineStyle3,
          )
        ]),
      ),
    );
  }
}
