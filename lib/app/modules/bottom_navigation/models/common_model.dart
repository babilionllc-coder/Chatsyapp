import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommonModel {
  final int? id;
  final RxBool? isCheck;
  final void Function()? onTap;
  final Widget? screen, screenName;
  final String? title, subTitle, subTitle1, imagePath, thumbnail;

  const CommonModel({
    this.id,
    this.onTap,
    this.title,
    this.screen,
    this.isCheck,
    this.subTitle,
    this.thumbnail,
    this.subTitle1,
    this.imagePath,
    this.screenName,
  });
}
