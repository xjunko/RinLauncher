import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rin_launcher/module/home/home_controller.dart';
import 'package:rin_launcher/module/home_settings/widgets/home_settings_widgets_controller.dart';
import 'package:rin_launcher/module/home_settings/widgets/widget/leafy_section_enabled_state_item.dart';
import 'package:rin_launcher/resources/localization/l10n.dart';
import 'package:rin_launcher/resources/localization/l10n_provider.dart';
import 'package:rin_launcher/resources/theme/home_theme.dart';
import 'package:rin_launcher/resources/theme/leafy_theme.dart';
import 'package:rin_launcher/shared_widget/section/src/items/leafy_section_text_item.dart';
import 'package:rin_launcher/shared_widget/themed_get_widget.dart';

class ClockEnabledState
    extends ThemedGetWidget<HomeSettingsWidgetsController, HomeTheme> {
  const ClockEnabledState({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsSectionIsEnabled),
      onTap: controller.updateIsClockVisible,
      value: GetBuilder<HomeController>(
        id: HomeController.clockBuilderKey,
        builder: (controller) {
          return LeafySectionEnabledStateItem(
            isEnabled: controller.isClockVisible,
          );
        },
      ),
    );
  }
}
