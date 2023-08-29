import 'package:app/component/storage_key.dart';
import 'package:app/component/style.dart';
import 'package:app/route/name.dart';
import 'package:app/screen/call_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:localstorage/localstorage.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({super.key});

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final _callApi = ApiSimulator();
  final LocalStorage storage = LocalStorage(StorageKey.sentence);

  @override
  void initState() {
    // call api from backend
    super.initState();
    Future<bool> passed = _callApi.simulateApiCall();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (await passed) {
        int currentNumber = storage.getItem(StorageKey.sentence);
        if (currentNumber >= 3) {
          storage.setItem(StorageKey.sentence, 1);
          await Navigator.of(context)
              .pushNamedAndRemoveUntil(Approutes.INITIAL, (route) => false);
        }
        storage.setItem(StorageKey.sentence, currentNumber + 1);
        await  Navigator.of(context)
              .pushNamedAndRemoveUntil(Approutes.SUCCESS, (route) => false);
      }
      await Navigator.of(context).pushNamedAndRemoveUntil(Approutes.FAILURE, (route) => false);
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
