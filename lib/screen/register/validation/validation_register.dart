import 'package:app/component/storage_key.dart';
import 'package:app/component/style.dart';
import 'package:app/route/name.dart';
import 'package:app/screen/call_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:localstorage/localstorage.dart';

class RegisterValidation extends StatefulWidget {
  const RegisterValidation({super.key});

  @override
  State<RegisterValidation> createState() => _RegisterValidationState();
}

class _RegisterValidationState extends State<RegisterValidation> {
  final _callApi = ApiSimulator();
  final LocalStorage storage = LocalStorage(StorageKey.sentence);

  @override
  void initState() {
    // call api from backend
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      int currentNumber = storage.getItem(StorageKey.sentence);
      final postApi = await _callApi.postVoiceApiCall(
          '/sdcard/Download/audio_$currentNumber.wav', 0);
      String getApi = await _callApi.voiceApiCall(0);
      if (getApi.isNotEmpty || postApi["data"] == null) {
        storage.setItem(StorageKey.sentence, currentNumber + 1);
        await Navigator.of(context).pushNamedAndRemoveUntil(
            Approutes.FAILURE_REGISTRATION, (route) => false);
      }
      await Navigator.of(context).pushNamedAndRemoveUntil(
          Approutes.FAILURE_REGISTRATION, (route) => false);
    });
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
