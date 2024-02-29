import 'package:flutter/material.dart';

import '../../utils/enum/leafy_theme_style.dart';
import 'leafy_theme.dart';
import 'leafy_theme_constants.dart';

const Color _kDarkForegroundColor = Colors.white;

const Radius _defaultRadius = Radius.zero;

// WIP: In progress of changing to ColorScheme System
class HomeTheme extends LeafyTheme {
  const HomeTheme.dark(Widget child)
      : super(
          child: child,
          style: LeafyThemeStyle.dark,
          leafyColor: const Color(0xffab4b76),
          foregroundColor: Colors.white,
          foregroundPressedColor: Colors.grey,
          backgroundColor: Colors.black,
          secondaryBackgroundColor: Colors.black54,
          textInfoColor: Colors.white,
          dialogPositiveColor: Colors.green,
          dialogNegativeColor: Colors.red,
          separatorColor: const Color(0x30FFFFFF),
          deleteColor: Colors.red,
          bodyText1: const TextStyle(
            fontSize: kBodyText1FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText2: const TextStyle(
            fontSize: kBodyText2FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText3: const TextStyle(
            fontSize: kBodyText3FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText4: const TextStyle(
            fontSize: kBodyText4FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText5: const TextStyle(
            fontSize: kBodyText5FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText6: const TextStyle(
            fontSize: kBodyText6FontSize,
            color: _kDarkForegroundColor,
          ),
          defaultRadius: _defaultRadius,
        );

  const HomeTheme.rina(Widget child)
      : super(
          child: child,
          style: LeafyThemeStyle.rina,
          leafyColor: const Color(0xff992966),
          foregroundColor: const Color(0xfff1d3e1),
          foregroundPressedColor: const Color(0xffcd8498),
          backgroundColor: const Color(0xff642a40),
          secondaryBackgroundColor: const Color.fromARGB(104, 100, 42, 64),
          textInfoColor: Colors.white,
          dialogPositiveColor: Colors.green,
          dialogNegativeColor: Colors.red,
          separatorColor: const Color(0xfff1d3e1),
          deleteColor: Colors.red,
          bodyText1: const TextStyle(
            fontSize: kBodyText1FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText2: const TextStyle(
            fontSize: kBodyText2FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText3: const TextStyle(
            fontSize: kBodyText3FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText4: const TextStyle(
            fontSize: kBodyText4FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText5: const TextStyle(
            fontSize: kBodyText5FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText6: const TextStyle(
            fontSize: kBodyText6FontSize,
            color: _kDarkForegroundColor,
          ),
          defaultRadius: _defaultRadius,
        );
}
