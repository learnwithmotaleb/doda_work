import 'package:flutter/material.dart';

/// Custom reactive AppBar that allows dynamic title updates
class ReactiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? titleWidget;
  final double height;
  final Color backgroundColor;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;

  const ReactiveAppBar({
    Key? key,
    this.titleWidget,
    this.height = kToolbarHeight,
    this.backgroundColor = Colors.white,
    this.centerTitle = true,
    this.actions,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      leading: leading,
      title: titleWidget ?? const SizedBox.shrink(),
      elevation: 2,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
