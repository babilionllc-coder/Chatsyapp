// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
  data:
      json['data'] == null
          ? null
          : LoginData.fromJson(json['data'] as Map<String, dynamic>),
  responseCode: (json['ResponseCode'] as num?)?.toInt(),
  responseMsg: json['ResponseMsg'] as String?,
  result: json['Result'] as String?,
  serverTime: json['ServerTime'] as String?,
);

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'ResponseCode': instance.responseCode,
      'ResponseMsg': instance.responseMsg,
      'Result': instance.result,
      'ServerTime': instance.serverTime,
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
  userId: json['user_id'] as String?,
  name: json['name'] as String?,
  profile: json['profile'] as String?,
  profileImg: json['profile_img'] as String?,
  planExpiry: json['plan_expiry'] as String?,
  productId: json['product_id'] as String?,
  isSubscription: json['is_subscription'] as String?,
  lastPurchaseToken: json['last_purchase_token'] as String?,
  appleOriginalTransactionId: json['apple_original_transaction_id'] as String?,
  modelId: json['model_id'] as String?,
  deviceType: json['device_type'] as String?,
  deviceToken: json['device_token'] as String?,
  deviceId: json['device_id'] as String?,
  chatGptModel: json['chat_gpt_model'] as String?,
  language: json['language'] as String?,
  length: json['length'] as String?,
  responseTone: json['response_tone'] as String?,
  chatLimit: json['chat_limit'] as String?,
  chatLimitResetDate: json['chat_limit_reset_date'] as String?,
  remainingChatLimit: json['remaining_chat_limit'] as String?,
  remainingChatLimitResetDate:
      json['remaining_chat_limit_reset_date'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  email: json['email'] as String?,
  isGoogle: json['is_google'] as String?,
  googleId: json['google_id'] as String?,
  firstTimeSubscription: json['first_time_subscription'] as String?,
  isApple: json['is_apple'] as String?,
  appleId: json['apple_id'] as String?,
  token: json['token'] as String?,
  isFirstTime: json['is_first_time'] as String?,
  planName: json['plan_name'] as String?,
  isSocial: json['is_social'] as String?,
  isGuestMode: json['is_guest_mode'] as String?,
);

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
  'user_id': instance.userId,
  'name': instance.name,
  'profile': instance.profile,
  'profile_img': instance.profileImg,
  'plan_expiry': instance.planExpiry,
  'product_id': instance.productId,
  'is_subscription': instance.isSubscription,
  'last_purchase_token': instance.lastPurchaseToken,
  'apple_original_transaction_id': instance.appleOriginalTransactionId,
  'device_type': instance.deviceType,
  'device_token': instance.deviceToken,
  'device_id': instance.deviceId,
  'chat_gpt_model': instance.chatGptModel,
  'model_id': instance.modelId,
  'language': instance.language,
  'length': instance.length,
  'response_tone': instance.responseTone,
  'chat_limit': instance.chatLimit,
  'chat_limit_reset_date': instance.chatLimitResetDate,
  'remaining_chat_limit': instance.remainingChatLimit,
  'remaining_chat_limit_reset_date': instance.remainingChatLimitResetDate,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'token': instance.token,
  'email': instance.email,
  'is_google': instance.isGoogle,
  'google_id': instance.googleId,
  'is_apple': instance.isApple,
  'apple_id': instance.appleId,
  'first_time_subscription': instance.firstTimeSubscription,
  'is_first_time': instance.isFirstTime,
  'plan_name': instance.planName,
  'is_social': instance.isSocial,
  'is_guest_mode': instance.isGuestMode,
};
