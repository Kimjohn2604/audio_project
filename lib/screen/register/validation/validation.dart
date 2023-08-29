import 'package:app/component/style.dart';
import 'package:app/route/name.dart';
import 'package:app/screen/call_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({super.key});

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final _callApi = ApiSimulator();

  @override
  void initState() {
    // call api from backend
    super.initState();
    Future<bool> passed = _callApi.simulateApiCall();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await passed
          ? Navigator.of(context).pushNamedAndRemoveUntil(Approutes.SUCCESS, (route) => false)
          : Navigator.of(context).pushNamedAndRemoveUntil(Approutes.FAILURE, (route) => false);
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
