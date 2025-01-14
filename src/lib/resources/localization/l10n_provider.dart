import 'dart:ui';

import 'package:get/get.dart';

import 'l10n.dart';

part 'l10n_provider_map_en_us.dart';

class L10nProvider extends Translations {
  static String getText(String key) {
    final localizedString = key.tr;

    return localizedString == key ? 'UNKNOWN: $key' : localizedString;
  }

  String _getKey(Locale locale) {
    return '${locale.languageCode}_${locale.countryCode}';
  }

  @override
  Map<String, Map<String, String>> get keys => {
        _getKey(L10n.enLocale): _mapEn,
        _getKey(L10n.ruLocale): _mapEn,
        _getKey(L10n.frLocale): _mapEn,
      };
}
