import 'package:app/component/storage_key.dart';
import 'package:app/component/style.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ValidLogin extends StatelessWidget {
   ValidLogin({super.key});

  final LocalStorage storageUsername = LocalStorage(StorageKey.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Well come: ${storageUsername.getItem(StorageKey.username)}",
        style: AppStyle.headlineStyle2,
      )),
    );
  }
}
