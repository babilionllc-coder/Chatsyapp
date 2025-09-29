import 'dart:developer' as dev;
import 'dart:math' show max;

import 'package:chatsy/app/helper/all_imports.dart';

extension LogX<T> on T {
  T get log {
    switch (this) {
      case TypeError(stackTrace: var stack):
        dev.log(toString(), stackTrace: stack);
        break;
      default:
        dev.log(toString());
    }

    return this;
  }

  T logNamed(String name) {
    dev.log(toString(), name: name);
    return this;
  }
}

extension EdgeInsetsX on EdgeInsets {
  EdgeInsets min({double? top, double? bottom, double? left, double? right}) {
    return EdgeInsets.only(
      top: top == null ? this.top : max(top, this.top),
      bottom: bottom == null ? this.bottom : max(bottom, this.bottom),
      left: left == null ? this.left : max(left, this.left),
      right: right == null ? this.right : max(right, this.right),
    );
  }
}

extension ColorX on Color {
  Color changeOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }
}
