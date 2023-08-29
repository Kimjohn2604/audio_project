import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:flutter/material.dart';

Widget textBox(BuildContext context,
    {required Color backgroundColor,
    required String title,
    required TextStyle styleTitle,
    required bool setBoder,
    required double verticalPadding}) {
  return Container(
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: setBoder ? Border.all(width: 0.3) : null),
    padding: EdgeInsets.symmetric(vertical: verticalPadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: styleTitle),
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

Widget customTextForm(BuildContext context,
    {required String labelText,
    required String? Function(String?)? validator,
    required void Function(String)? onChanged}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.1)),
    child: TextFormField(
        cursorHeight: 25,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.always,
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

Widget authentiactionBox(BuildContext context,
    {required String bigText, required String smallText, required themeColor}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    decoration: BoxDecoration(
        color: Appcolor.backgroundcolor,
        border: Border.all(width: 1, color: themeColor),
        borderRadius: BorderRadius.circular(5)),
    height: 70,
    width: double.infinity,
    child: Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          color: Appcolor.mainColor,
          height: 40,
          width: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              bigText,
              style: AppStyle.headlineStyle3.copyWith(color: themeColor),
            ),
            Text(
              smallText,
              style: AppStyle.headlineStyle4.copyWith(color: themeColor),
            )
          ],
        )
      ],
    ),
  );
}

Widget warningBox(BuildContext context, {required bool showDetail}) {
  return Container(
    decoration: BoxDecoration(
      color: Appcolor.backgroundcolor,
      border: Border.all(width: 1, color: Appcolor.iconColor2),
    ),
    padding: const EdgeInsets.only(left: 15, top: 15, right: 5, bottom: 15),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your voice sample",
                    style:
                        AppStyle.headlineStyle3.copyWith(color: Appcolor.red)),
                Text("This could be",
                    style: AppStyle.headlineStyle4
                        .copyWith(color: Appcolor.iconColor2)),
                showDetail
                    ? const Column(
                        children: [
                          SizedBox(height: 10),
                          /* detailedContent(context,
                              text:
                                  "The word you have spoken aren't entirely correct"),
                          detailedContent(context,
                              text:
                                  "The word you have spoken aren't entirely correct"),
                          detailedContent(context,
                              text:
                                  "The word you have spoken aren't entirely correct"), */
                        ],
                      )
                    : Container(),
              ],
            ),
            const Icon(
              Icons.close,
              size: 18,
              color: Appcolor.red,
            )
          ],
        )
      ],
    ),
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
