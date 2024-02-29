enum LeafyThemeStyle {
  // Default
  dark,
  // Custom
  rina,
}

extension LeafyThemeStyleExtensions on LeafyThemeStyle {
  String localize() {
    switch (this) {
      case LeafyThemeStyle.dark:
        return 'Dark';
      case LeafyThemeStyle.rina:
        return 'Rina';
      default:
        throw Exception('Unknown type');
    }
  }
}

const String _dark = 'Dark';
const String _rina = 'Rina';

String stringifyLeafyThemeStyle(LeafyThemeStyle style) {
  switch (style) {
    case LeafyThemeStyle.rina:
      return _rina;
    case LeafyThemeStyle.dark:
      return _dark;

    default:
      throw Exception('Unknown type');
  }
}

LeafyThemeStyle leafyThemeStyleFromString(String str) {
  switch (str) {
    case _rina:
      return LeafyThemeStyle.rina;
    case _dark:
      return LeafyThemeStyle.dark;
    default:
      throw Exception('Unknown!');
  }
}
