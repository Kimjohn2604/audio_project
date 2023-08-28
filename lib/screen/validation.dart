import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:app/route/name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({super.key});

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  bool _callApi() {
    return true;
  }

  @override
  void initState() {
    // call api from backend
    super.initState();
    bool passed = _callApi();
    if (passed) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(Approutes.USER);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 75,
              width: 75,
              child: const CircularProgressIndicator(),
              /* child: const CircularProgressIndicator(), */
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
