import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:flutter/material.dart';

Widget textBox(BuildContext context,
    {required Color backgroundColor,
    required String title,
    required TextStyle styleTitle,
    required bool setBoder,
    required double verticalPadding}) {
  return Container(width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: setBoder ? Border.all(width: 0.3) : null),
    padding: EdgeInsets.symmetric(vertical: verticalPadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,maxLines:3, style: styleTitle),
      ],
    ),
  );
}

Widget navigationButton(
  BuildContext context, {
  required Color backgroundColor,
  required String title,
  required TextStyle styleTitle,
}) {
  return Container(
    width: 213,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(title, style: styleTitle),
  );
}

Widget customTextForm(
    {required String labelText,
    required String? Function(String?)? validator,
    }) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.5)),
    child: TextFormField(
        cursorHeight: 25,
        decoration: InputDecoration(
          labelStyle:
              AppStyle.headlineStyle4.copyWith(color: Appcolor.textColor),
          labelText: labelText,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onSaved: null,
        validator: validator),
  );
}
Widget detailedContent(BuildContext context, {required String text}) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10, top: 10),
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Appcolor.mainBlackColor),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.78,
          child: Text(text,
              maxLines: 5,
              style: AppStyle.headlineStyle2.copyWith(
                  color: Appcolor.mainBlackColor,
                  fontWeight: FontWeight.normal)),
        )
      ],
    ),
  );
}
