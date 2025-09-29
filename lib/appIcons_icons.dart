// Place fonts/appIcons.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: appIcons
//      fonts:
//       - asset: fonts/appIcons.ttf
import 'package:flutter/widgets.dart';

class AppIcons {
  AppIcons._();

  static const String _fontFamily = 'appIcons';

  static const IconData regenerate = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData copy = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData textSelection = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData share = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData readLoud = IconData(0xe904, fontFamily: _fontFamily);
}
