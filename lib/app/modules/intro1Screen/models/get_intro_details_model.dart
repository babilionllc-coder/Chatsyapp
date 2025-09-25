class GetIntroDataModel {
  final GetIntroData? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  GetIntroDataModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  GetIntroDataModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String, dynamic>?) != null ? GetIntroData.fromJson(json['data'] as Map<String, dynamic>) : null,
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}

class GetIntroData {
  final List<ModelList>? modelList;
  final List<ToolList>? toolList;
  final List<SolveProblemList>? solveProblemList;
  final List<LanguageList>? languageList;
  final String? intro1;
  final String? intro2;
  final String? intro3;
  final String? didUKnow;
  final String? videoLink;
  final String? happyUsers;
  final String? notifications;
  final String? problemSolvingTasks;

  GetIntroData({
    this.modelList,
    this.toolList,
    this.solveProblemList,
    this.languageList,
    this.intro1,
    this.intro2,
    this.intro3,
    this.didUKnow,
    this.videoLink,
    this.notifications,
    this.happyUsers,
    this.problemSolvingTasks,
  });

  GetIntroData.fromJson(Map<String, dynamic> json)
      : modelList = (json['modelList'] as List?)?.map((dynamic e) => ModelList.fromJson(e as Map<String, dynamic>)).toList(),
        toolList = (json['toolList'] as List?)?.map((dynamic e) => ToolList.fromJson(e as Map<String, dynamic>)).toList(),
        solveProblemList = (json['solveProblemList'] as List?)?.map((dynamic e) => SolveProblemList.fromJson(e as Map<String, dynamic>)).toList(),
        languageList = (json['languageList'] as List?)?.map((dynamic e) => LanguageList.fromJson(e as Map<String, dynamic>)).toList(),
        intro1 = json['intro_1'] as String?,
        intro2 = json['intro_2'] as String?,
        intro3 = json['intro_3'] as String?,
        videoLink = json['video_link'] as String?,
        notifications = json['notifications'] as String?,
        happyUsers = json['happy_users'] as String?,
        problemSolvingTasks = json['problem_solving_tasks'] as String?,
        didUKnow = json['did_u_know'] as String?;

  Map<String, dynamic> toJson() => {
        'modelList': modelList?.map((e) => e.toJson()).toList(),
        'toolList': toolList?.map((e) => e.toJson()).toList(),
        'solveProblemList': solveProblemList?.map((e) => e.toJson()).toList(),
        'languageList': languageList?.map((e) => e.toJson()).toList(),
        'intro_1': intro1,
        'intro_2': intro2,
        'intro_3': intro3,
        'video_link': videoLink,
        'did_u_know': didUKnow,
        'happy_users': happyUsers,
        'notifications': notifications,
        'problem_solving_tasks': problemSolvingTasks,
      };
}

class ModelList {
  final String? infoId;
  final String? img;
  final String? description;
  final String? type;
  final String? isActive;

  ModelList({
    this.infoId,
    this.img,
    this.description,
    this.type,
    this.isActive,
  });

  ModelList.fromJson(Map<String, dynamic> json)
      : infoId = json['info_id'] as String?,
        img = json['img'] as String?,
        description = json['description'] as String?,
        type = json['type'] as String?,
        isActive = json['is_active'] as String?;

  Map<String, dynamic> toJson() => {'info_id': infoId, 'img': img, 'description': description, 'type': type, 'is_active': isActive};
}

class ToolList {
  final String? infoId;
  final String? img;
  final String? description;
  final String? type;
  final String? isActive;

  ToolList({
    this.infoId,
    this.img,
    this.description,
    this.type,
    this.isActive,
  });

  ToolList.fromJson(Map<String, dynamic> json)
      : infoId = json['info_id'] as String?,
        img = json['img'] as String?,
        description = json['description'] as String?,
        type = json['type'] as String?,
        isActive = json['is_active'] as String?;

  Map<String, dynamic> toJson() => {'info_id': infoId, 'img': img, 'description': description, 'type': type, 'is_active': isActive};
}

class SolveProblemList {
  final String? infoId;
  final String? img;
  final String? description;
  final String? type;
  final String? isActive;

  SolveProblemList({
    this.infoId,
    this.img,
    this.description,
    this.type,
    this.isActive,
  });

  SolveProblemList.fromJson(Map<String, dynamic> json)
      : infoId = json['info_id'] as String?,
        img = json['img'] as String?,
        description = json['description'] as String?,
        type = json['type'] as String?,
        isActive = json['is_active'] as String?;

  Map<String, dynamic> toJson() => {'info_id': infoId, 'img': img, 'description': description, 'type': type, 'is_active': isActive};
}

class LanguageList {
  final String? infoId;
  final String? img;
  final String? description;
  final String? type;
  final String? isActive;

  LanguageList({
    this.infoId,
    this.img,
    this.description,
    this.type,
    this.isActive,
  });

  LanguageList.fromJson(Map<String, dynamic> json)
      : infoId = json['info_id'] as String?,
        img = json['img'] as String?,
        description = json['description'] as String?,
        type = json['type'] as String?,
        isActive = json['is_active'] as String?;

  Map<String, dynamic> toJson() => {'info_id': infoId, 'img': img, 'description': description, 'type': type, 'is_active': isActive};
}
