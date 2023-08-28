import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconData? leadingIcon;
  final void Function()? leadingTap;

  CustomAppbar({
    super.key,
    this.title,
    this.leadingIcon,
    this.leadingTap,
  });

  final double appbarHeight = AppBar().preferredSize.height;
  @override
  Size get preferredSize => Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          height: 1.0,
        ),
      ),
      elevation: 0,
      title: Text(
        title!,
        style: AppStyle.headlineStyle2,
      ),
      centerTitle: true,
      leading: InkWell(
        onTap: leadingTap,
        child: Icon(
          leadingIcon,
          size: 24,
          color: Appcolor.mainBlackColor,
        ),
      ),
    );
  }
}
