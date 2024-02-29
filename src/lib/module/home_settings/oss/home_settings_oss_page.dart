import 'package:flutter/material.dart';

import '../../../base/page/status_page_base.dart';
import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import 'body/settings_oss_body.dart';
import 'home_settings_oss_controller.dart';
import 'title/home_settings_oss_title.dart';

class HomeSettingsOssPage
    extends StatusPageBase<HomeSettingsOssController, HomeTheme> {
  const HomeSettingsOssPage() : super(customBackgroundColor: Colors.black);

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return const Column(
      children: [
        SettingsOssTitle(),
        Expanded(child: SettingsOssBody()),
      ],
    );
  }
}
