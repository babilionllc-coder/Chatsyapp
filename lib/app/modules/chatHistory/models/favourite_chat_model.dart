class FavouriteUnFavouriteChatModel {
  final bool? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  FavouriteUnFavouriteChatModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  FavouriteUnFavouriteChatModel copyWith({
    bool? data,
    int? responseCode,
    String? responseMsg,
    String? result,
    String? serverTime,
  }) {
    return FavouriteUnFavouriteChatModel(
      data: data ?? this.data,
      responseCode: responseCode ?? this.responseCode,
      responseMsg: responseMsg ?? this.responseMsg,
      result: result ?? this.result,
      serverTime: serverTime ?? this.serverTime,
    );
  }

  FavouriteUnFavouriteChatModel.fromJson(Map<String, dynamic> json)
      : data = json['data'] as bool?,
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data, 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}
