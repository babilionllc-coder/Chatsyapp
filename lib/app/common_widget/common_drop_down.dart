import 'package:dropdown_button2/dropdown_button2.dart';

import '../helper/all_imports.dart';
import '../helper/font_family.dart';

class CommonDropDownButton extends StatelessWidget {
  final RxString itemValue;

  // final RxString? hintText;
  final bool isImage;
  final List<String> itemList;
  final void Function(String?)? onChanged;

  const CommonDropDownButton({
    required this.itemValue,
    required this.itemList,
    // this.hintText,
    this.isImage = false,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.px),
            border: Border.all(color: const Color(0XFF3CDAD3)),
          ),
          padding: EdgeInsets.symmetric(vertical: 4.px),
          child: DropdownButtonHideUnderline(
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: DropdownButton2(
                alignment: Alignment.centerLeft,

                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.px), color: AppColors().whiteAndDark),
                  maxHeight: 60.h,
                  width: (100.w - 35.px),
                ),
                // isDense: true,
                isExpanded: true,
                iconStyleData: IconStyleData(iconEnabledColor: AppColors().darkAndWhite, iconSize: 35.px),
                value: itemValue.value,
                selectedItemBuilder: (context) {
                  return itemList.map((String items) {
                    return Theme(
                      data: ThemeData(splashColor: Colors.transparent),
                      child: DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.px),
                          child: AppText(
                            items,
                            color: AppColors().darkAndWhite,
                            height: 0,
                            fontSize: 16.px,
                            fontFamily: FontFamily.helveticaBold,
                          ),
                        ),
                      ),
                    );
                  }).toList();
                },
                items: itemList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: AppText(
                      items,
                      color: AppColors().darkAndWhite,
                      fontFamily: FontFamily.helveticaBold,
                      height: 0,
                      fontSize: 16.px,
                    ),
                  );
                }).toList(),

                onChanged: (value) {
                  itemValue.value = value ?? "";
                  if (onChanged != null) onChanged!(value);
                },
              ),
            ),
          ),
        ));
  }
}
