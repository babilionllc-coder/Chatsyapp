// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:chatsy/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../api_repository/api_function.dart';
// import '../../../common_widget/error_and_update_dialog.dart';
// import '../../../helper/Global.dart';
// import '../../../helper/all_imports.dart';
// import '../controllers/new_chat_controller.dart';
// import '../models/phm_id_model.dart';
//
// class ChatApi {
//   static RxBool isStreamingData = false.obs;
//   static StreamSubscription? sub;
//   RxString dataUser = "".obs;
//   String documentAddText = "Hi AI I will send you some text and then I will ask you some questions related to the text please answer me.";
//   String healthSystemText =
//       "You are a knowledgeable assistant trained in various domains, including but not limited to healthcare, finance, technology, legal, and general knowledge. When responding to queries, prioritize accuracy, clarity, and contextual understanding, considering any specific regulations or industry practices (e.g., HIPAA, GDPR, PCI DSS, etc.). Initiate conversations by understanding the user’s needs and adjust the response accordingly. If the query involves sensitive or regulated information, ensure compliance with the relevant standards, provide examples of best practices, and cite trusted sources, especially for medical or legal information. When addressing healthcare-related questions, follow a structured format that includes an overview, common causes, symptoms, management or solutions, when to seek professional help, and additional resources or citations.";
//   static bool isEdit = false;
//   static int selectModelIndex = (getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex)) : 0;
//
//   void scrollToEnd(ScrollController scrollController) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       try {
//         if (isStreamingData.value) scrollController.jumpTo(scrollController.position.maxScrollExtent);
//       } catch (e) {
//         printAction("eerror$e");
//       }
//     });
//   }
//
//   apiCalling({
//     required String textQuestion,
//     RxBool? isRegenerate,
//     bool? notAddPrompt,
//     required RxList<ChatItem> chatItem,
//     required ScrollController scrollController,
//     String? documentText,
//     String? systemText,
//     String? link,
//     String? modelType,
//     String? modelName,
//     String? modelTitle,
//     String? promptId,
//     String? fileName,
//     String? fileSize,
//     String? assistantId,
//     String? type,
//   }) async {
//     if (Utils().isValidationEmpty(modelName)) {
//       modelName = (Get.put(BottomNavigationController()).selectAiModelList.isEmpty ? "gpt-3.5-trbuo" : Get.put(BottomNavigationController()).selectAiModelList[selectModelIndex].model ?? "gemini-1.5-flash");
//     }
//
//     log("123123selectModelIndex------------------$selectModelIndex");
//     log("123123modelTitle------------------$modelName");
//
//     if (Global.isSubscription.value != "1" && Global.chatLimit.value < 1) {
//       String? logo = Get.put(BottomNavigationController()).selectAiModelList[(getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex)) : 0].logo;
//       chatItem.add(ChatItem(question: textQuestion, isUpgraded: true, modelLogo: logo));
//       logo = null;
//
//       scrollToEnd(scrollController);
//
//       return;
//     }
//
//     if (isStreamingData.value) {
//       return;
//     }
//     if (utils.isValidationEmpty(textQuestion)) {
//       return;
//     }
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         log("===============phmId=111111${isRegenerate?.value ?? false}");
//
//         isEdit = isRegenerate?.value ?? false;
//
//         log("===============phmId=22222222$isEdit");
//
//         stopStreaming();
//
//         if (!isEdit) {
//           await modelsHistoryAPI(chatItem, modelName ?? "", modelTitle ?? "", link: link, fileSize: fileSize, fileName: fileName, fileText: documentText ?? systemText, promptId: promptId, assistantId: assistantId, type: type);
//         }
//         printAction("API class call   ${(Get.put(BottomNavigationController()).selectAiModelList.isEmpty ? "gpt-3.5-trbuo" : Get.put(BottomNavigationController()).selectAiModelList[selectModelIndex].model ?? "gemini-1.5-flash")}");
//         scrollToEnd(scrollController);
//         if (!(isRegenerate?.value ?? false)) {
//           String? logo = Get.put(BottomNavigationController()).selectAiModelList[(getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex)) : 0].logo;
//
//           chatItem.add(ChatItem(question: textQuestion, phmID: (chatItem.isNotEmpty) ? chatItem[0].phmID : null, modelLogo: logo));
//           logo = null;
//         } else {
//           chatItem[chatItem.length - 1].question = textQuestion;
//           // chatItem[chatItem.length - 1].answer = "...";
//         }
//         log("===============phmId=33333333$isEdit");
//
//         chatItem.refresh();
//
//         String addPromText(int i) {
//           if (notAddPrompt != null && notAddPrompt) {
//             return "";
//           } else {
//             return " ${((i == (chatItem.length - 1) && ((chatItem[i].question?.length ?? 0) > 7))) ? " with ${Get.put(BottomNavigationController()).loginData?.length?.toLowerCase() ?? "Auto"} length. make this text ${Get.put(BottomNavigationController()).loginData?.responseTone!.toLowerCase() ?? "Default"} Please don't return length and tone in answer." : ""} ";
//           }
//         }
//
//         FocusManager.instance.primaryFocus?.unfocus();
//
//         isStreamingData.value = true;
//         if ((modelType ?? (Get.put(BottomNavigationController()).selectAiModelList.isEmpty ? null.obs : Get.put(BottomNavigationController()).selectAiModelList[(getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex)) : 0].modelType ?? "chatgpt")) == "gemini") {
//           final safetySettings = [
//             SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
//             SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
//             SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
//             SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.low),
//           ];
//
//           final model = GenerativeModel(
//             model: modelName ?? (Get.put(BottomNavigationController()).selectAiModelList.isEmpty ? "gemini-1.5-flash" : Get.put(BottomNavigationController()).selectAiModelList[(getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex)) : 0].model ?? "gemini-1.5-flash"),
//             apiKey: Constants.geminiKey,
//             safetySettings: safetySettings,
//           );
//
//           List<Content> data = [];
//
//           if (!utils.isValidationEmpty(systemText)) {
//             data.add(Content('user', Content.system(systemText!).parts));
//           }
//
//           /// For Document
//           if (!utils.isValidationEmpty(documentText)) {
//             data.add(Content('user', Content.system(documentAddText).parts));
//             data.add(Content('user', Content.text(documentText ?? "").parts));
//           }
//
//           for (int i = 0; i < chatItem.length; i++) {
//             if (chatItem[i].question != "") {
//               data.add(Content('user', Content.text("${chatItem[i].question}${addPromText(i)}".trim()).parts));
//             }
//             if (!Utils().isValidationEmpty(chatItem[i].answer)) {
//               data.add(Content('model', Content.text(chatItem[i].answer.toString()).parts));
//             }
//           }
//
//           sub = model.generateContentStream(data).listen((response) {
//             response.functionCalls.forEach((element) {
//               printAction("elementelementelement ${element}");
//             });
//
//             dataUser.value = dataUser.value + (response.text ?? "");
//
//             chatItem[chatItem.length - 1].answer = dataUser.value;
//             chatItem.refresh();
//             scrollToEnd(scrollController);
//           }, onDone: () async {
//             updateChatLimit();
//             stopStreaming();
//             printAction("0--=-= ${chatItem.length % 3}");
//             if (chatItem.length == 1 || (chatItem.length % 3 == 0)) {
//               Global.showTheReview();
//             }
//             await modelsHistoryAPI(chatItem, modelName ?? "", link: link, modelTitle ?? "", fileSize: fileSize, fileName: fileName, fileText: documentText ?? systemText, promptId: promptId, assistantId: assistantId, type: type);
//           }, onError: (error) async {
//             printAction("error rorr rorr ${error.toString()}");
//             if ((chatItem.last.answer?.length ?? 0) > 10) {
//               updateChatLimit();
//               await modelsHistoryAPI(chatItem, modelName ?? "", link: link, modelTitle ?? "", fileSize: fileSize, fileName: fileName, fileText: documentText ?? systemText, promptId: promptId, assistantId: assistantId, type: type);
//             }
//             stopStreaming();
//
//             utils.showToast(message: error.toString());
//             return;
//           });
//         } else {
//           var data = [];
//
//           if (!utils.isValidationEmpty(systemText)) {
//             printAction("systemTextsystemTextsystemTextsystemText ${systemText}");
//             data.add({"role": "system", "content": systemText});
//           }
//
//           ///For Document
//           if (!utils.isValidationEmpty(documentText)) {
//             data.add({"role": "system", "content": documentAddText});
//             data.add({"role": "user", "content": documentText});
//           }
//
//           for (int i = 0; i < chatItem.length; i++) {
//             if (chatItem[i].question != "") {
//               data.add({"role": "user", "content": "${chatItem[i].question}${addPromText(i)}"});
//             }
//
//             if (!Utils().isValidationEmpty(chatItem[i].answer)) {
//               // if (chatItem[i].answer != "" && chatItem[i].answer != "...") {
//               data.add({"role": "assistant", "content": "${chatItem[i].answer}"});
//             }
//           }
//
//           try {
//             var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ${Constants.chatToken}', 'Cookie': '__cf_bm=qe9F.Cz6WtHtAoRGOo5UrIwNvTMv5DuEv7eQMQZucsM-1723022735-1.0.1.1-NabnBPbBSnMcapR7COOsoEi.7fg_rQ4ypj4GI1EO.ysVB10yNbdIb2FOAbSM1AYjlw8ol56AomvRljAxYODtQQ; _cfuvid=02ShQqnUwFNE_vyBo5e2.5uJ6ZnJsV.eLYc5k0E3tuI-1723015328845-0.0.1.1-604800000'};
//             var request = http.Request('POST', Uri.parse(Constants.gptURL));
//
//             request.body = json.encode({
//               "model": modelName ?? (Get.put(BottomNavigationController()).selectAiModelList.isEmpty ? "gpt-3.5-trbuo" : Get.put(BottomNavigationController()).selectAiModelList[(getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex)) : 0].model ?? "gpt-3.5-turbo"),
//               "messages": data,
//               "stream": true,
//             });
//
//             request.headers.addAll(headers);
//             http.StreamedResponse response = await request.send().timeout(const Duration(seconds: 20));
//             printAction("response.statusCoderesponse.statusCoderesponse.statusCode ${response.statusCode.toString()}");
//             if (response.statusCode == 200) {
//               sub = response.stream.listen((value) async {
//                 var val = utf8.decode(value);
//
//                 var matches = RegExp('{.*}').allMatches(val);
//                 for (var e in matches) {
//                   var val = e.group(0);
//                   if (val != null) {
//                     try {
//                       // jsonDecode(val);
//                       final parsed = jsonDecode(val);
//                       if (parsed != null) {
//                         final choices = parsed['choices'][0];
//                         if (choices != null) {
//                           final delta = choices['delta'];
//                           if (delta != null || !delta.isBlank) {
//                             final content = delta['content'];
//                             if (content != null) {
//                               final finishReason = choices['finish_reason'];
//                               if (finishReason == null) {
//                                 dataUser.value = dataUser.value + content.toString();
//
//                                 chatItem[chatItem.length - 1].answer = dataUser.value.trim();
//                                 chatItem.refresh();
//                               } else {
//                                 updateChatLimit();
//                                 if (chatItem.length == 1 || (chatItem.length % 3 == 0)) {
//                                   Global.showTheReview();
//                                 }
//                                 stopStreaming();
//                               }
//                             } else {
//                               final finishReason = choices['finish_reason'];
//                               if (finishReason == "stop") {
//                                 updateChatLimit();
//                                 stopStreaming();
//                                 debugPrint("==============      111111111111111111111e ");
//                                 printAction("0--=-= ${chatItem.length % 3}");
//
//                                 if (chatItem.length == 1 || (chatItem.length % 3 == 0)) {
//                                   Global.showTheReview();
//                                 }
//                                 await modelsHistoryAPI(chatItem, modelName ?? "", link: link, modelTitle ?? "", fileSize: fileSize, fileName: fileName, fileText: documentText ?? systemText, promptId: promptId, assistantId: assistantId, type: type);
//                               }
//                             }
//                           } else {
//                             final finishReason = choices['finish_reason'] ?? "";
//                             if (finishReason == "stop") {
//                               updateChatLimit();
//                               stopStreaming();
//                               debugPrint("==============      222222222222222222222222 ");
//                               printAction("0--=-= ${chatItem.length % 3}");
//
//                               if (chatItem.length == 1 || (chatItem.length % 3 == 0)) {
//                                 Global.showTheReview();
//                               }
//                               await modelsHistoryAPI(chatItem, modelName ?? "", link: link, modelTitle ?? "", fileSize: fileSize, fileName: fileName, fileText: documentText ?? systemText, promptId: promptId, assistantId: assistantId, type: type);
//                             }
//                           }
//                         }
//                       }
//                       scrollToEnd(scrollController);
//                     } on Exception catch (e) {
//                       printAction("ExceptionExceptionExceptionException ");
//                       String text = val.toString();
//                       int specificIndexAfterQuote = text.toString().indexOf("content");
//                       specificIndexAfterQuote = specificIndexAfterQuote + 10;
//
//                       int indexOfQuoteAfterStart = text.indexOf('"', specificIndexAfterQuote);
//
//                       if (specificIndexAfterQuote < text.length) {
//                         String ans = text.substring(specificIndexAfterQuote, indexOfQuoteAfterStart);
//                         if ((!Utils().isValidationEmpty(ans)) && ans != "0,") {
//                           dataUser.value = dataUser.value + ans;
//
//                           printAction("==============   Exception    dataUser.value    ${dataUser.value}");
//                           printAction("==============    dataUser.value    ${text.substring(specificIndexAfterQuote, indexOfQuoteAfterStart)}");
//
//                           chatItem[chatItem.length - 1].answer = dataUser.value.trim();
//                           chatItem.refresh();
//                         }
//                       } else {
//                         debugPrint('Quotation mark not found or index out of range.');
//                       }
//                     }
//                   } else {
//                     debugPrint("==================           Val Not Found");
//                   }
//                 }
//               }, onDone: () {
//                 printAction("onDone onDone onDone onDone onDone");
//                 updateChatLimit();
//
//                 stopStreaming();
//                 if (chatItem.length == 1 || (chatItem.length % 3 == 0)) {
//                   Global.showTheReview();
//                 }
//               }, onError: (error, StackTrace stackTrace) async {
//                 if ((chatItem.last.answer?.length ?? 0) > 10) {
//                   updateChatLimit();
//                   await modelsHistoryAPI(chatItem, modelName ?? "", link: link, modelTitle ?? "", fileSize: fileSize, fileName: fileName, fileText: documentText ?? systemText, promptId: promptId, assistantId: assistantId, type: type);
//                 }
//                 stopStreaming();
//                 utils.showToast(message: error.toString());
//                 return;
//               });
//
//               // Future.delayed(Duration(seconds: 2),(){
//               //   sun.cancel();
//               // });
//             } else {
//               isStreamingData.value = false;
//
//               debugPrint("response.reasonPhrase ${response.reasonPhrase}");
//               stopStreaming();
//             }
//           } on TimeoutException catch (e) {
//             debugPrint('Request timed out: $e');
//           } on http.ClientException catch (e) {
//             debugPrint('Client error: $e');
//           } catch (e) {
//             debugPrint('Unexpected error: $e');
//           }
//         }
//       } else {
//         utils.hideKeyboard();
//         utils.showToast(message: "Your internet is not available, please try again later");
//         debugPrint('not connected');
//         return;
//       }
//     } on SocketException catch (_) {
//       utils.hideKeyboard();
//       utils.showToast(message: "Your internet is not available, please try again later");
//       debugPrint('not connected');
//       return;
//     }
//   }
//
//   static stopStreaming() {
//     if (sub != null) {
//       printAction("stopStreaming stopStreaming");
//
//       isStreamingData.value = false;
//       sub?.cancel();
//     }
//   }
// }
//
// updateChatLimit() {
//   if (Global.isSubscription.value == "0") {
//     printAction("Global.chatLimit.value ${Global.chatLimit.value}");
//     if (Global.chatLimit.value >= 1) {
//       Global.chatLimit.value = --Global.chatLimit.value;
//     }
//     printAction("Global.chatLimit.value ${Global.chatLimit.value}");
//   }
//   getStorageData.saveString(getStorageData.chatLimit, Global.chatLimit.value.toString());
// }
//
// Future<void> modelsHistoryAPI(
//   RxList<ChatItem> chatItemList,
//   String? modelName,
//   String? title, {
//   String? fileName,
//   String? fileSize,
//   String? fileText,
//   String? promptId,
//   String? link,
//   String? assistantId,
//   String? type,
// }) async {
//   if (!(utils.isValidationEmpty(fileText)) && (fileText!.length > 16777215)) {
//     fileText = fileText.substring(0, 16777215);
//   }
//   printAction("assistantId--------------$assistantId");
//   printAction("modelNamemodelNamemodelNamemodelName $modelName");
//   printAction("ChatApi.selectModelIndexChatApi.selectModelIndexChatApi.selectModelIndex ${ChatApi.selectModelIndex}");
//   if (Utils().isValidationEmpty(modelName)) {
//     modelName = (Get.put(BottomNavigationController()).selectAiModelList.isEmpty ? "gpt-3.5-trbuo" : Get.put(BottomNavigationController()).selectAiModelList[ChatApi.selectModelIndex].model ?? "gemini-1.5-flash");
//   }
//   printAction("modelNamemodelNamemodelNamemodelName ${modelName}");
//
//   log("===============phmId=44444444${ChatApi.isEdit}");
//   for (int i = 0; i < chatItemList.length; i++) {
//     if (((!chatItemList[i].isHistorySave) || (i == (chatItemList.length - 1) ? ChatApi.isEdit : false)) && (!Utils().isValidationEmpty(chatItemList[i].answer)) && (chatItemList[i].answer != "...")) {
//       ChatItem chatItem = chatItemList[i];
//
//       String uid = await getStorageData.readString(getStorageData.userId) ?? "";
//       Codec<String, String> stringToBase64 = utf8.fuse(base64);
//
//       FormData formData = FormData.fromMap({
//         'user_id': uid,
//         'ai_model': modelName,
//         'is_edit': i == (chatItemList.length - 1)
//             ? ChatApi.isEdit
//                 ? "1"
//                 : "0"
//             : "0",
//         if (!utils.isValidationEmpty(type)) "type": type,
//         'title': utils.isValidationEmpty(title) ? (Get.put(BottomNavigationController()).selectAiModelList.isEmpty ? null.obs : Get.put(BottomNavigationController()).selectAiModelList[(getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex)) : 0].name ?? "Chat GPT").toString() : title,
//         'question': stringToBase64.encode(chatItem.question ?? ""),
//         'answer': stringToBase64.encode((!(utils.isValidationEmpty(chatItem.answer))
//             ? chatItem.answer!.length > 16777215
//                 ? chatItem.answer!.substring(0, 16777215)
//                 : chatItem.answer ?? ""
//             : "")),
//         if (!utils.isValidationEmpty(assistantId)) 'assistant_id': assistantId,
//         if (title == "Youtube Summary" && ((!Utils().isValidationEmpty(fileText)) || (!Utils().isValidationEmpty(fileName))) && i == 0) ...{
//           'link': link,
//           'youtube_text': stringToBase64.encode(fileText ?? ""),
//           'youtube_title': stringToBase64.encode(fileName ?? ""),
//         },
//         if (!utils.isValidationEmpty(promptId)) 'prompt_id': promptId,
//         if (!Utils().isValidationEmpty(chatItem.phmID)) 'phm_id': chatItem.phmID.toString(),
//         if (title == "Summarize Doc" && ((!Utils().isValidationEmpty(fileText)) || (!Utils().isValidationEmpty(fileName)) || (!Utils().isValidationEmpty(fileSize)))) ...{
//           'file_name': fileName,
//           'file_size': fileSize,
//           'file_text': stringToBase64.encode(fileText ?? ""),
//         },
//         if (title == "Summarize Web" && ((!Utils().isValidationEmpty(fileText)) || (!Utils().isValidationEmpty(fileName)))) ...{
//           'link': fileName,
//           'web_text': stringToBase64.encode(fileText ?? ""),
//         },
//       });
//
//       final data = await APIFunction().apiCall(
//           apiName: title == "Summarize Doc"
//               ? Constants.summarizeDocument
//               : title == "Summarize Web"
//                   ? Constants.summarizeWeb
//                   : (!utils.isValidationEmpty(promptId))
//                       ? Constants.promptQueAns
//                       : title == "Youtube Summary"
//                           ? Constants.youtubeSummary
//                           : (!utils.isValidationEmpty(assistantId))
//                               ? Constants.assistantQueAns
//                               : Constants.storeQueAns,
//           params: formData,
//           isLoading: false,
//           token: await getStorageData.readString(getStorageData.token));
//       PhmIdModel model = PhmIdModel.fromJson(data);
//
//       if (model.responseCode == 1) {
//         if (i == (chatItemList.length - 1)) {
//           if (ChatApi.isEdit) {
//             ChatApi.isEdit = false;
//           }
//         }
//         log("===============phmId=${model.phmId}");
//         chatItem.phmID = model.phmId.toString();
//         log("===============chatItem.phmID=${chatItem.phmID}");
//
//         chatItem.isHistorySave = true;
//       } else if (model.responseCode == 0) {
//         // errorDialog("Something went wrong, please try after sometime");
//       } else if (model.responseCode == 26) {
//         updateDialog(model.responseMsg);
//       }
//     }
//   }
// }
