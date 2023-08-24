import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:flutter/material.dart';

Widget textBox(BuildContext context,
    {required Color backgroundColor,
    required String title,
    required IconData? micIcon,
    required TextStyle styleTitle,
    required bool setBoder}) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: setBoder ? Border.all(width: 0.3) : null),
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(micIcon),
        Text(title, style: styleTitle),
      ],
    ),
  );
}

Widget customTextForm(BuildContext context,
    {required String labelText,
    required IconData icon,
    required Function(String?)? validator,
    required Function onChanged}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.1)),
    child: TextFormField(
      cursorHeight: 20,
        onChanged: onChanged(),
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          icon: Icon(icon),
          labelStyle:
              AppStyle.headlineStyle4.copyWith(color: Appcolor.textColor),
          labelText: labelText,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onSaved: null,
        validator: validator!("")),
  );
}
