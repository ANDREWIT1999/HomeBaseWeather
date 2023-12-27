import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text? title;
  final List<Widget>? widgets;
  final double? elevation;
  final Color? backgroundColor;
  final Widget? leading;
  final double? leadingWidth;

  const BaseAppBar({
    Key? key,
    this.title,
    this.widgets,
    this.elevation,
    this.leading,
    this.backgroundColor, this.leadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title,
        backgroundColor: backgroundColor,
        actions: widgets,
        elevation: elevation,
        leading: leading,
        leadingWidth: leadingWidth);
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
