import '../helper/all_imports.dart';

CommonShowModelBottomSheet({required Widget child, bool? isDismissible, bool? enableDrag, double? horizontal, Color? color, bool isDivider = true, EdgeInsetsGeometry? childPadding}) async {
  await Get.bottomSheet(
    isScrollControlled: true,
    enableDrag: enableDrag ?? true,
    isDismissible: isDismissible ?? true,
    Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 80.h),
      decoration: BoxDecoration(
        color: color ?? AppColors().backgroundColor1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.px),
          topRight: Radius.circular(30.px),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal ?? 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isDivider)
              Center(
                  child: Container(
                width: 64.px,
                height: 4.px,
                margin: EdgeInsets.only(top: 12.px),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(43.px)),
              )),
            Flexible(
              child: ListView(
                padding: childPadding,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  child,
                  SizedBox(height: 10.px),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
