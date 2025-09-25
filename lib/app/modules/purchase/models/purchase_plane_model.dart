import 'package:chatsy/app/modules/splash/controllers/login_model.dart';

class PurchasePlanModel {
  LoginData? data;
  int? responseCode;
  String? responseMsg;
  String? result;
  String? serverTime;

  PurchasePlanModel({this.data, this.responseCode, this.responseMsg, this.result, this.serverTime});

  PurchasePlanModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
    responseCode = json['ResponseCode'];
    responseMsg = json['ResponseMsg'];
    result = json['Result'];
    serverTime = json['ServerTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['ResponseCode'] = responseCode;
    data['ResponseMsg'] = responseMsg;
    data['Result'] = result;
    data['ServerTime'] = serverTime;
    return data;
  }
}
