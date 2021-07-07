import 'package:flutter/material.dart';

import '../../resources/app_constants.dart';
import '../leafy_spacer.dart';

enum SeparatorType { line, space, none }

class ListBuilder<T> extends StatelessWidget {
  final Widget Function(T item) builder;
  final Iterable<T> items;
  final SeparatorType separatorType;
  final bool addBottomBarPadding;
  final EdgeInsets? padding;
  final double? spacing;

  ListBuilder({
    required this.builder,
    required this.items,
    this.separatorType = SeparatorType.line,
    this.padding,
    this.addBottomBarPadding = true,
    this.spacing,
  });
  @override
  Widget build(BuildContext context) {
    if (separatorType != SeparatorType.none) {
      return ListView.separated(
        padding: padding,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (_, index) {
          return builder(items.elementAt(index));
        },
        separatorBuilder: (_, index) {
          if (index == items.length - 1) {
            return SizedBox(height: spacing ?? kDefaultPadding * 3.0);
          }

          if (separatorType == SeparatorType.line) {
            return spacing == null
                ? const Divider(height: kDefaultPadding * 3.0)
                : Divider(
                    height: spacing,
                  );
          } else {
            return spacing == null
                ? const LeafySpacer(multipler: 3.0)
                : SizedBox(height: spacing);
          }
        },
      );
    }

    return ListView.builder(
      padding: padding,
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (_, index) {
        return builder(items.elementAt(index));
      },
    );
  }
}