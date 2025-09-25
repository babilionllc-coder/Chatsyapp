class GetPlanDetailModel {
  final GetPlanDetailData? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  GetPlanDetailModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  GetPlanDetailModel.fromJson(Map<String, dynamic> json)
    : data =
          (json['data'] as Map<String, dynamic>?) != null
              ? GetPlanDetailData.fromJson(json['data'] as Map<String, dynamic>)
              : null,
      responseCode = json['ResponseCode'] as int?,
      responseMsg = json['ResponseMsg'] as String?,
      result = json['Result'] as String?,
      serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {
    'data': data?.toJson(),
    'ResponseCode': responseCode,
    'ResponseMsg': responseMsg,
    'Result': result,
    'ServerTime': serverTime,
  };
}

class GetPlanDetailData {
  final List<Model>? model;
  final List<Feature>? feature;
  final List<PlanDesc>? planDesc;
  final List<Review>? review;
  final List<Uses>? uses;
  final List<Plans>? plans;
  final String? planImgDark1;
  final String? planImgDark2;
  final String? planImgLight1;
  final String? planImgLight2;
  final String? diamond;
  final String? firstTimeSubscription;
  final String? isFirstTime;
  final String? isReview;

  GetPlanDetailData({
    this.model,
    this.feature,
    this.planDesc,
    this.isReview,
    this.review,
    this.uses,
    this.plans,
    this.planImgDark1,
    this.planImgDark2,
    this.planImgLight1,
    this.planImgLight2,
    this.diamond,
    this.firstTimeSubscription,
    this.isFirstTime,
  });

  GetPlanDetailData.fromJson(Map<String, dynamic> json)
    : model =
          (json['model'] as List?)
              ?.map((dynamic e) => Model.fromJson(e as Map<String, dynamic>))
              .toList(),
      feature =
          (json['feature'] as List?)
              ?.map((dynamic e) => Feature.fromJson(e as Map<String, dynamic>))
              .toList(),
      planDesc =
          (json['planDesc'] as List?)
              ?.map((dynamic e) => PlanDesc.fromJson(e as Map<String, dynamic>))
              .toList(),
      review =
          (json['review'] as List?)
              ?.map((dynamic e) => Review.fromJson(e as Map<String, dynamic>))
              .toList(),
      uses =
          (json['uses'] as List?)
              ?.map((dynamic e) => Uses.fromJson(e as Map<String, dynamic>))
              .toList(),
      plans =
          (json['plans'] as List?)
              ?.map((dynamic e) => Plans.fromJson(e as Map<String, dynamic>))
              .toList(),
      planImgDark1 = json['plan_img_dark_1'] as String?,
      planImgDark2 = json['plan_img_dark_2'] as String?,
      planImgLight1 = json['plan_img_light_1'] as String?,
      isReview = json['is_review'] as String?,
      diamond = json['diamond'] as String?,
      firstTimeSubscription = json['first_time_subscription'] as String?,
      isFirstTime = json['is_first_time'] as String?,
      planImgLight2 = json['plan_img_light_2'] as String?;

  Map<String, dynamic> toJson() => {
    'model': model?.map((e) => e.toJson()).toList(),
    'feature': feature?.map((e) => e.toJson()).toList(),
    'planDesc': planDesc?.map((e) => e.toJson()).toList(),
    'review': review?.map((e) => e.toJson()).toList(),
    'uses': uses?.map((e) => e.toJson()).toList(),
    'plans': plans?.map((e) => e.toJson()).toList(),
    'plan_img_dark_1': planImgDark1,
    'plan_img_dark_2': planImgDark2,
    'plan_img_light_1': planImgLight1,
    'diamond': diamond,
    'plan_img_light_2': planImgLight2,
    'is_review': isReview,
    'first_time_subscription': firstTimeSubscription,
    'is_first_time': isFirstTime,
  };
}

class Model {
  final String? detailId;
  final String? type;
  final String? img;
  final String? pro;
  final String? isActive;
  final String? isTick;
  final String? title;
  final String? basic;

  Model({
    this.detailId,
    this.type,
    this.img,
    this.pro,
    this.isActive,
    this.isTick,
    this.title,
    this.basic,
  });

  Model.fromJson(Map<String, dynamic> json)
    : detailId = json['detail_id'] as String?,
      type = json['type'] as String?,
      img = json['img'] as String?,
      pro = json['pro'] as String?,
      isActive = json['is_active'] as String?,
      isTick = json['is_tick'] as String?,
      title = json['title'] as String?,
      basic = json['basic'] as String?;

  Map<String, dynamic> toJson() => {
    'detail_id': detailId,
    'type': type,
    'img': img,
    'pro': pro,
    'is_active': isActive,
    'is_tick': isTick,
    'title': title,
    'basic': basic,
  };
}

class Feature {
  final String? detailId;
  final String? type;
  final String? img;
  final String? pro;
  final String? isActive;
  final String? isTick;
  final String? title;
  final String? basic;

  Feature({
    this.detailId,
    this.type,
    this.img,
    this.pro,
    this.isActive,
    this.isTick,
    this.title,
    this.basic,
  });

  Feature.fromJson(Map<String, dynamic> json)
    : detailId = json['detail_id'] as String?,
      type = json['type'] as String?,
      img = json['img'] as String?,
      pro = json['pro'] as String?,
      isActive = json['is_active'] as String?,
      isTick = json['is_tick'] as String?,
      title = json['title'] as String?,
      basic = json['basic'] as String?;

  Map<String, dynamic> toJson() => {
    'detail_id': detailId,
    'type': type,
    'img': img,
    'pro': pro,
    'is_active': isActive,
    'is_tick': isTick,
    'title': title,
    'basic': basic,
  };
}

class PlanDesc {
  final String? detailId;
  final String? type;
  final String? img;
  final String? pro;
  final String? isActive;
  final String? isTick;
  final String? title;
  final String? basic;

  PlanDesc({
    this.detailId,
    this.type,
    this.img,
    this.pro,
    this.isActive,
    this.isTick,
    this.title,
    this.basic,
  });

  PlanDesc.fromJson(Map<String, dynamic> json)
    : detailId = json['detail_id'] as String?,
      type = json['type'] as String?,
      img = json['img'] as String?,
      pro = json['pro'] as String?,
      isActive = json['is_active'] as String?,
      isTick = json['is_tick'] as String?,
      title = json['title'] as String?,
      basic = json['basic'] as String?;

  Map<String, dynamic> toJson() => {
    'detail_id': detailId,
    'type': type,
    'img': img,
    'pro': pro,
    'is_active': isActive,
    'is_tick': isTick,
    'title': title,
    'basic': basic,
  };
}

class Review {
  final String? detailId;
  final String? type;
  final String? img;
  final String? pro;
  final String? isActive;
  final String? isTick;
  final String? title;
  final String? basic;

  Review({
    this.detailId,
    this.type,
    this.img,
    this.pro,
    this.isActive,
    this.isTick,
    this.title,
    this.basic,
  });

  Review.fromJson(Map<String, dynamic> json)
    : detailId = json['detail_id'] as String?,
      type = json['type'] as String?,
      img = json['img'] as String?,
      pro = json['pro'] as String?,
      isActive = json['is_active'] as String?,
      isTick = json['is_tick'] as String?,
      title = json['title'] as String?,
      basic = json['basic'] as String?;

  Map<String, dynamic> toJson() => {
    'detail_id': detailId,
    'type': type,
    'img': img,
    'pro': pro,
    'is_active': isActive,
    'is_tick': isTick,
    'title': title,
    'basic': basic,
  };
}

class Uses {
  final String? detailId;
  final String? type;
  final String? img;
  final String? pro;
  final String? isActive;
  final String? isTick;
  final String? title;
  final String? basic;

  Uses({
    this.detailId,
    this.type,
    this.img,
    this.pro,
    this.isActive,
    this.isTick,
    this.title,
    this.basic,
  });

  Uses.fromJson(Map<String, dynamic> json)
    : detailId = json['detail_id'] as String?,
      type = json['type'] as String?,
      img = json['img'] as String?,
      pro = json['pro'] as String?,
      isActive = json['is_active'] as String?,
      isTick = json['is_tick'] as String?,
      title = json['title'] as String?,
      basic = json['basic'] as String?;

  Map<String, dynamic> toJson() => {
    'detail_id': detailId,
    'type': type,
    'img': img,
    'pro': pro,
    'is_active': isActive,
    'is_tick': isTick,
    'title': title,
    'basic': basic,
  };
}

class Plans {
  final String? planId;
  final String? productId;
  final String? freeTrialProductId;
  final String? isFreeTrial;
  final String? isBestOffer;
  final String? isActive;
  final String? planName;
  final String? planDesc;
  final String? name;
  String? price;
  double? rawPrice;
  String? subTitle;

  Plans({
    this.planId,
    this.productId,
    this.freeTrialProductId,
    this.isFreeTrial,
    this.isBestOffer,
    this.isActive,
    this.planName,
    this.planDesc,
    this.name,
    this.price,
    this.rawPrice,
    this.subTitle,
  });

  Plans.fromJson(Map<String, dynamic> json)
    : planId = json['plan_id'] as String?,
      productId = json['product_id'] as String?,
      freeTrialProductId = json['free_trial_product_id'] as String?,
      isFreeTrial = json['is_free_trial'] as String?,
      isBestOffer = json['is_best_offer'] as String?,
      isActive = json['is_active'] as String?,
      planName = json['plan_name'] as String?,
      name = json['name'] as String?,
      price = "",
      planDesc = json['plan_desc'] as String?,
      subTitle = json['sub_title'] as String?;

  Map<String, dynamic> toJson() => {
    'plan_id': planId,
    'product_id': productId,
    'free_trial_product_id': freeTrialProductId,
    'is_free_trial': isFreeTrial,
    'is_best_offer': isBestOffer,
    'is_active': isActive,
    'plan_name': planName,
    'plan_desc': planDesc,
    'name': name,
    'price': price,
    'raw_price': rawPrice,
    'sub_title': subTitle,
  };
}
