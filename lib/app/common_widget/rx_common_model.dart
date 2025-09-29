import '../helper/all_imports.dart';

class RxCommonModel {
  String title;
  String unit;
  String purpose;
  String nameOfVisitor;
  String date;
  String typeOfServices;
  String status;
  String subTitle;
  String image;
  String count;
  String uploadId;
  Color color;
  bool isSelected;
  bool? isPro;
  List? dataList;

  RxCommonModel({
    this.title = "",
    this.subTitle = "",
    this.image = "",
    this.count = "",
    this.color = AppColors.white,
    this.unit = "",
    this.purpose = "",
    this.nameOfVisitor = "",
    this.date = "",
    this.typeOfServices = "",
    this.status = "",
    this.isSelected = false,
    this.isPro = false,
    this.dataList,
    this.uploadId = "",
  });
}
