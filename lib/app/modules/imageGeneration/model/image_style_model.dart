class ImageStyleModel {
  final List<StyleList>? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  ImageStyleModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  ImageStyleModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => StyleList.fromJson(e as Map<String, dynamic>)).toList(),
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.map((e) => e.toJson()).toList(), 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}

class StyleList {
  final String filterId;
  final String title;
  String isSelected;
  final String image;

  StyleList({
    this.filterId = "",
    this.title = "",
    this.isSelected = "",
    this.image = "",
  });

  StyleList.fromJson(Map<String, dynamic> json)
      : filterId = json['filter_id'] as String,
        title = json['title'] as String,
        isSelected = json['is_selected'] as String,
        image = json['image'] as String;

  Map<String, dynamic> toJson() => {'filter_id': filterId, 'title': title, 'is_selected': isSelected, 'image': image};
}
