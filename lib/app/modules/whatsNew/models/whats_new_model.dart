import 'package:video_player/video_player.dart';

class WhatsNewModel {
  final List<WhatsNewData>? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  WhatsNewModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  WhatsNewModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => WhatsNewData.fromJson(e as Map<String, dynamic>)).toList(),
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.map((e) => e.toJson()).toList(), 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}

class WhatsNewData {
  VideoPlayerController? videoController;
  final String? whatsNewId;
  final String? title;
  final String? description;
  final String? media;
  final String? thumbnail;
  final String? mediaType;
  final String? mimeType;

  WhatsNewData({
    this.whatsNewId,
    this.title,
    this.description,
    this.media,
    this.thumbnail,
    this.mediaType,
    this.mimeType,
  });

  WhatsNewData.fromJson(Map<String, dynamic> json)
      : whatsNewId = json['whats_new_id'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        media = json['media'] as String?,
        thumbnail = json['thumbnail'] as String?,
        mediaType = json['media_type'] as String?,
        mimeType = json['mime_type'] as String?;

  Map<String, dynamic> toJson() => {'whats_new_id': whatsNewId, 'title': title, 'description': description, 'media': media, 'thumbnail': thumbnail, 'media_type': mediaType, 'mime_type': mimeType};
}
