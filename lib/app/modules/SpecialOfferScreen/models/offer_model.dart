import '../../purchase/models/get_plan_details_model.dart';

class OfferModel {
  final OfferData? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  OfferModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  OfferModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String, dynamic>?) != null ? OfferData.fromJson(json['data'] as Map<String, dynamic>) : null,
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}

class OfferData {
  final Plans? offerPlan;

  final List<Plans>? plans;
  final List<PlanDesc>? planDesc;

  OfferData({
    this.offerPlan,
    this.plans,
    this.planDesc,
  });

  OfferData.fromJson(Map<String, dynamic> json)
      : offerPlan = (json['offer_plan'] as Map<String, dynamic>?) != null ? Plans.fromJson(json['offer_plan'] as Map<String, dynamic>) : null,
        plans = (json['plans'] as List?)?.map((dynamic e) => Plans.fromJson(e as Map<String, dynamic>)).toList(),
        planDesc = (json['planDesc'] as List?)?.map((dynamic e) => PlanDesc.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'offer_plan': offerPlan?.toJson(),
        'plans': plans?.map((e) => e.toJson()).toList(),
        'planDesc': planDesc?.map((e) => e.toJson()).toList(),
      };
}
