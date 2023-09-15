import 'package:app/component/colors.dart';
import 'package:app/component/storage_key.dart';
import 'package:app/component/style.dart';
import 'package:app/route/name.dart';
import 'package:app/widget/box.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class InvalidRegistration extends StatelessWidget {
   InvalidRegistration({super.key});
  final LocalStorage storage = LocalStorage(StorageKey.sentence);
  @override
  Widget build(BuildContext context) {
    int currentNumber = storage.getItem(StorageKey.sentence);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                "Validation Failed",
                style: AppStyle.headlineStyle2,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Approutes.REGISTER);
                },
                child: navigationButton(context,
                    backgroundColor: Appcolor.mainColor,
                    title: "Try again",
                    styleTitle: AppStyle.headlineStyle2
                        .copyWith(color: Appcolor.whiteColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}