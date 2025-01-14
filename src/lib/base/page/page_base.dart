import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/theme/leafy_theme.dart';
import '../controller/controller_base.dart';

class OnWillPopData {
  OnWillPopData(this.onWillPop);

  Future<bool> Function() onWillPop;
}

abstract class PageBase<TController extends ControllerBase,
    TTheme extends LeafyTheme> extends GetView<TController> {
  const PageBase({Key? key, this.customBackgroundColor = Colors.transparent})
      : super(key: key);
  final Color customBackgroundColor;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  bool get safeArea => false;

  @protected
  OnWillPopData? get onWillPopData => OnWillPopData(controller.back);

  @override
  Widget build(BuildContext context) {
    Widget widget = LeafyThemeState<TTheme>(
      builder: (context, theme) {
        Color finalColor = customBackgroundColor;

        // Assume black means whatever the theme backgroundColor is.
        if (customBackgroundColor == Colors.black) {
          finalColor = theme.backgroundColor;
        } else if (customBackgroundColor == Colors.black54) {
          finalColor = theme.backgroundColor.withAlpha(137);
        }

        Widget widget = Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: finalColor,
          body: pageBody(context, theme),
          floatingActionButton: fab(context, theme),
        );

        if (safeArea) {
          widget = SafeArea(child: widget);
        }

        return widget;
      },
    );

    if (onWillPopData != null) {
      widget = WillPopScope(
        onWillPop: onWillPopData!.onWillPop,
        child: widget,
      );
    }

    return widget;
  }

  Widget pageBody(BuildContext context, LeafyTheme theme);

  Widget? fab(BuildContext context, LeafyTheme theme) {
    return null;
  }
}
