class ImageGenerationModel {
  final ImageGeneration? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  ImageGenerationModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  ImageGenerationModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String, dynamic>?) != null ? ImageGeneration.fromJson(json['data'] as Map<String, dynamic>) : null,
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}

class ImageGeneration {
  final String? imageSessionId;
  final String? userId;
  final String? phmId;
  final String? question;
  final String? revisedPrompt;
  final String? img;
  bool? isUpgrade;
  String? size = "";

  ImageGeneration({
    this.imageSessionId,
    this.userId,
    this.phmId,
    this.question,
    this.revisedPrompt,
    this.img,
    this.isUpgrade,
  });

  ImageGeneration.fromJson(Map<String, dynamic> json)
      : imageSessionId = json['image_session_id'] as String?,
        userId = json['user_id'] as String?,
        phmId = json['phm_id'] as String?,
        question = json['question'] as String?,
        revisedPrompt = json['revised_prompt'] as String?,
        img = json['img'] as String?;

  Map<String, dynamic> toJson() => {'image_session_id': imageSessionId, 'user_id': userId, 'phm_id': phmId, 'question': question, 'revised_prompt': revisedPrompt, 'img': img};
}
