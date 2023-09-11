import 'package:app/component/colors.dart';
import 'package:app/component/storage_key.dart';
import 'package:app/component/style.dart';
import 'package:app/route/name.dart';
import 'package:app/screen/call_api.dart';
import 'package:app/widget/box.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

final _callApi = ApiSimulator();

class _UserScreenState extends State<UserScreen> {
  String textValue = "";
  final LocalStorage storageUsername = LocalStorage(StorageKey.username);
  final LocalStorage storageSentence = LocalStorage(StorageKey.sentence);
  String? errorText(String? value) {
    if (value!.isEmpty) {
      return "You must fill your name";
    } else if (value
        .contains(RegExp(r'[@,#,",",",.,:,$,%,^,,*,(,),-,_,+,=,!,/,<,>,;,]'))) {
      return 'Do not use the speacial char.';
    }

    storageUsername.setItem(StorageKey.username, value);
    return null;
  } //Check for null and special characters of input string (textValue) and save to username Key

  Future<void> checkText(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final result = await _callApi
          .simulateApiCall(storageUsername.getItem(StorageKey.username));
      if (result) {
        Navigator.of(context).pushNamed(Approutes.REGISTER);
        storageSentence.setItem(StorageKey.sentence, 1);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User already exists")));
      }
    }
  } //Check if the current state of the Form is valid and save to sentence Key

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        color: Appcolor.backgroundcolor,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        title: "User Signup",
                        styleTitle: AppStyle.headlineStyle3,
                        setBoder: true),
                    customTextForm(labelText: "Username", validator: errorText),
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
