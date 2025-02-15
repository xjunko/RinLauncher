import 'package:flutter/material.dart';
import 'package:rin_launcher/resources/theme/leafy_theme.dart';
import 'package:rin_launcher/shared_widget/themed_widget.dart';

class LeafySectionHeader<TTheme extends LeafyTheme>
    extends ThemedWidget<TTheme> {
  const LeafySectionHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Text(
      title.toUpperCase(),
      style: theme.bodyText6.copyWith(
        color: theme.textInfoColor,
      ),
      textAlign: TextAlign.start,
    );
  }
}
