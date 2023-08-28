import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:flutter/material.dart';

class ValidationScreen extends StatelessWidget {
  const ValidationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 75,
              width: 75,
              color: Appcolor.iconColor1,
              /* child: const CircularProgressIndicator(), */
            ),
            const SizedBox(height: 20),
            Text("Validation In Progress",style: AppStyle.headlineStyle2,)
          ],
        ),
      ),
    );
  }
}