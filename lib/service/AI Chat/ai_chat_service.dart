import 'package:chatsy/app/helper/constants.dart';
import 'package:chatsy/app/modules/home/controllers/user_profile_model.dart';
import 'package:chatsy/app/modules/newChat/models/phm_id_model.dart';
import 'package:chatsy/service/core/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ai_chat_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AIChatService {
  factory AIChatService() => _instance;

  static final _instance = _AIChatService(AppClient());

  @POST('imageGenerationLatest')
  Future<PhmIdModel> imageGeneration({
    @Part(name: 'user_id') required String userId,
    @Part(name: 'question') required String question,
    @Part(name: 'size') required String size,
    @Part(name: 'phm_id') String? phmId,
    @Part(name: 'ai_model') required String aiModel,
    @Part(name: 'title') required String title,
    @Part(name: 'is_edit') String? isEdit,
    @Part(name: 'filter_type') String? filterType,
    @CancelRequest() CancelToken? cancelToken,
  });
}

@RestApi(baseUrl: Constants.baseUrl)
abstract class UserDataService {
  factory UserDataService() => _instance;

  static final _instance = _UserDataService(AppClient());

  @POST(Constants.getUserProfile)
  Future<UserProfileModel> getUserProfile({
    @Field('user_id') required String userId,
  });
}
