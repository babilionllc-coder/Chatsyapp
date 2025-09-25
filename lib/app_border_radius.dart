import 'package:flutter/widgets.dart';

class AppBorderRadius extends BorderRadius {
  const AppBorderRadius.all10() : super.all(const Radius.circular(10));
  const AppBorderRadius.all24() : super.all(const Radius.circular(24));

  const AppBorderRadius.top30()
    : super.vertical(top: const Radius.circular(30));
}
