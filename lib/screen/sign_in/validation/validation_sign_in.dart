import 'package:app/component/storage_key.dart';
import 'package:app/component/style.dart';
import 'package:app/route/name.dart';
import 'package:app/screen/call_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:localstorage/localstorage.dart';

class SigninValidation extends StatefulWidget {
  const SigninValidation({super.key});

  @override
  State<SigninValidation> createState() => _SigninValidationState();
}

class _SigninValidationState extends State<SigninValidation> {
  final _callApi = ApiSimulator();
  final LocalStorage storageUsername = LocalStorage(StorageKey.username);
  @override
  void initState() {
    // call api from backend
    super.initState();
    /* Future<bool> passed =
        _callApi.simulateApiCall(storageUsername.getItem(StorageKey.username));

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (await passed) {
        await Navigator.of(context).pushNamed(Approutes.SUCCESS_SIGNIN);
      } else {}
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 75,
              width: 75,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 20),
            Text(
              "Validation In Progress",
              style: AppStyle.headlineStyle2,
            )
          ],
        ),
      ),
    );
  }
}
