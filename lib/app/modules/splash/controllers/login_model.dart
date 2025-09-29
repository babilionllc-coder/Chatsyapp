import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginModel {
  LoginData? data;
  @JsonKey(name: 'ResponseCode')
  int? responseCode;
  @JsonKey(name: 'ResponseMsg')
  String? responseMsg;
  @JsonKey(name: 'Result')
  String? result;
  @JsonKey(name: 'ServerTime')
  String? serverTime;

  LoginModel({this.data, this.responseCode, this.responseMsg, this.result, this.serverTime});

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
  /* {
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
    responseCode = json['ResponseCode'];
    responseMsg = json['ResponseMsg'];
    result = json['Result'];
    serverTime = json['ServerTime'];
  } */

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
  /* {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['ResponseCode'] = responseCode;
    data['ResponseMsg'] = responseMsg;
    data['Result'] = result;
    data['ServerTime'] = serverTime;
    return data;
  } */
}

@JsonSerializable(explicitToJson: true)
class LoginData {
  @JsonKey(name: 'user_id')
  final String? userId;

  final String? name;

  final String? profile;

  @JsonKey(name: 'profile_img')
  final String? profileImg;

  @JsonKey(name: 'plan_expiry')
  final String? planExpiry;

  @JsonKey(name: 'product_id')
  final String? productId;

  @JsonKey(name: 'is_subscription')
  String? isSubscription;

  @JsonKey(name: 'last_purchase_token')
  final String? lastPurchaseToken;

  @JsonKey(name: 'apple_original_transaction_id')
  final String? appleOriginalTransactionId;

  @JsonKey(name: 'device_type')
  final String? deviceType;

  @JsonKey(name: 'device_token')
  final String? deviceToken;

  @JsonKey(name: 'device_id')
  final String? deviceId;

  @JsonKey(name: 'chat_gpt_model')
  final String? chatGptModel;

  @JsonKey(name: 'model_id')
  final String? modelId;

  final String? language;

  final String? length;

  @JsonKey(name: 'response_tone')
  final String? responseTone;

  @JsonKey(name: 'chat_limit')
  final String? chatLimit;

  @JsonKey(name: 'chat_limit_reset_date')
  final String? chatLimitResetDate;

  @JsonKey(name: 'remaining_chat_limit')
  final String? remainingChatLimit;

  @JsonKey(name: 'remaining_chat_limit_reset_date')
  final String? remainingChatLimitResetDate;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'is_google')
  final String? isGoogle;

  @JsonKey(name: 'google_id')
  final String? googleId;

  @JsonKey(name: 'is_apple')
  final String? isApple;

  @JsonKey(name: 'apple_id')
  final String? appleId;

  @JsonKey(name: 'first_time_subscription')
  final String? firstTimeSubscription;

  @JsonKey(name: 'is_first_time')
  final String? isFirstTime;

  @JsonKey(name: 'plan_name')
  final String? planName;

  @JsonKey(name: 'is_social')
  final String? isSocial;

  @JsonKey(name: 'is_guest_mode')
  final String? isGuestMode;

  LoginData({
    this.userId,
    this.name,
    this.profile,
    this.profileImg,
    this.planExpiry,
    this.productId,
    this.isSubscription,
    this.lastPurchaseToken,
    this.appleOriginalTransactionId,
    this.modelId,
    this.deviceType,
    this.deviceToken,
    this.deviceId,
    this.chatGptModel,
    this.language,
    this.length,
    this.responseTone,
    this.chatLimit,
    this.chatLimitResetDate,
    this.remainingChatLimit,
    this.remainingChatLimitResetDate,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.isGoogle,
    this.googleId,
    this.firstTimeSubscription,
    this.isApple,
    this.appleId,
    this.token,
    this.isFirstTime,
    this.planName,
    this.isSocial,
    this.isGuestMode,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json)
  /* : userId = json['user_id'] as String?,
      name = json['name'] as String?,
      profile = json['profile'] as String?,
      profileImg = json['profile_img'] as String?,
      planExpiry = json['plan_expiry'],
      productId = json['product_id'],
      isSubscription = json['is_subscription'] as String?,
      isSocial = json['is_social'] as String?,
      modelId = json['model_id'] as String?,
      lastPurchaseToken = json['last_purchase_token'],
      appleOriginalTransactionId = json['apple_original_transaction_id'],
      deviceType = json['device_type'] as String?,
      deviceToken = json['device_token'] as String?,
      firstTimeSubscription = json['first_time_subscription'] as String?,
      deviceId = json['device_id'] as String?,
      chatGptModel = json['chat_gpt_model'] as String?,
      language = json['language'] as String?,
      length = json['length'] as String?,
      responseTone = json['response_tone'] as String?,
      chatLimit = json['chat_limit'] as String?,
      chatLimitResetDate = json['chat_limit_reset_date'] as String?,
      remainingChatLimit = json['remaining_chat_limit'] as String?,
      remainingChatLimitResetDate = json['remaining_chat_limit_reset_date'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?,
      email = json['email'] as String?,
      isGoogle = json['is_google'] as String?,
      googleId = json['google_id'] as String?,
      isApple = json['is_apple'] as String?,
      appleId = json['apple_id'] as String?,
      planName = json['plan_name'] as String?,
      isFirstTime = json['is_first_time'] as String?,
      isGuestMode = json['is_guest_mode'] as String?,
      token = json['token'] as String? */
  ;

  Map<String, dynamic> toJson() => _$LoginDataToJson(this)
  /* {
    'user_id': userId,
    'name': name,
    'profile': profile,
    'profile_img': profileImg,
    'plan_expiry': planExpiry,
    'product_id': productId,
    'is_subscription': isSubscription,
    'model_id': modelId,
    'last_purchase_token': lastPurchaseToken,
    'apple_original_transaction_id': appleOriginalTransactionId,
    'device_type': deviceType,
    'is_guest_mode': isGuestMode,
    'device_token': deviceToken,
    'device_id': deviceId,
    'chat_gpt_model': chatGptModel,
    'is_social': isSocial,
    'language': language,
    'length': length,
    'response_tone': responseTone,
    'chat_limit': chatLimit,
    'chat_limit_reset_date': chatLimitResetDate,
    'remaining_chat_limit': remainingChatLimit,
    'remaining_chat_limit_reset_date': remainingChatLimitResetDate,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'email': email,
    'is_google': isGoogle,
    'first_time_subscription': firstTimeSubscription,
    'google_id': googleId,
    'is_apple': isApple,
    'apple_id': appleId,
    'plan_ame': planName,
    'is_first_time': isFirstTime,
    'token': token,
  } */
  ;
}
