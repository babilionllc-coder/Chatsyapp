import 'dart:io';

import 'package:chatsy/app/helper/constants.dart';
import 'package:chatsy/app/modules/home/controllers/ai_assistants_model.dart';
import 'package:chatsy/models/API%20Response/api_response.dart';
import 'package:chatsy/service/core/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ai_assistant_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AiAssistantService {
  factory AiAssistantService() => _instance;

  static final _instance = _AiAssistantService(AppClient());

  @POST('createAssistant')
  Future<CreateAssistantModel> createAssistant({
    @Part(name: 'user_id') required String userId,
    @Part(name: 'model') required String model,
    @Part(name: 'assistant_img') required File assistantImg,
    @Part(name: 'assistant_title') required String assistantTitle,
    @Part(name: 'assistant_desc') required String? assistantDesc,
    @Part(name: 'backend_prompt') required String backendPrompt,
  });

  @POST('getAssistantData')
  Future<AssistantsModel> getAssistantData({
    @Field('user_id') required String userId,
    @Field('limit') required String? limit,
    @Field('page') required String? page,
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST('deleteAssistant')
  Future<RawBaseResponse> deleteAssistant({
    @Field('user_id') required String userId,
    @Field('assistant_id') required String? assistantId,
  });

  @GET('https://ipinfo.io/json')
  Future<HttpResponse<dynamic>> getLocationData();
}
