// import 'dart:io';
//
// import 'package:chatsy/app/modules/newChat/component/text_to_speech.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../Localization/local_language.dart';
// import '../../../common_widget/common_container.dart';
// import '../../../helper/Global.dart';
// import '../../../helper/all_imports.dart';
// import '../../../helper/font_family.dart';
// import '../../../helper/image_path.dart';
// import '../../chat_gpt/controllers/chat_gpt_controller.dart';
// import '../../chat_gpt/views/chat_gpt_view.dart';
// import '../../imageGeneration/controllers/image_generation_controller.dart';
// import '../controllers/new_chat_controller.dart';
// import 'new_chat_helper.dart';
//
// class ChatQuestionAnsView extends StatelessWidget {
//   ChatQuestionAnsView({
//     super.key,
//     this.scrollController,
//     this.question,
//     this.questionIcon,
//     this.suggestionList,
//     this.suggestionOnTap,
//     this.questionImage,
//     this.ansImage,
//     this.ans,
//     this.isEdit = false,
//     this.ansIcon,
//     this.isUpgrade,
//     this.isBorder = true,
//     this.isAnimatedText = false,
//     this.isRealTime = false,
//     this.isImageScan,
//     this.onTap,
//     this.onTapAns,
//     this.onTapEdit,
//     this.regenerateResponseOnTap,
//   });
//
//   ScrollController? scrollController;
//   String? question;
//   String? questionIcon;
//   RxList<String>? suggestionList;
//   Function(String data)? suggestionOnTap;
//   String? questionImage;
//   String? ansImage;
//   String? ans;
//   bool isEdit = false;
//   String? ansIcon;
//   bool? isUpgrade;
//   bool isBorder = true;
//   bool isAnimatedText = false;
//   bool isRealTime = false;
//   bool? isImageScan;
//   Function(LongPressStartDetails)? onTap;
//   Function()? onTapAns;
//   Function(String)? onTapEdit;
//   Function()? regenerateResponseOnTap;
//
//   @override
//   Widget build(BuildContext context) {
//     if (isUpgrade ?? false || suggestionList != null) {
//       if (scrollController != null) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           scrollController?.jumpTo(scrollController!.position.maxScrollExtent);
//         });
//       }
//     }
//
//     return Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
//       if (!utils.isValidationEmpty(question))
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             (utils.isValidationEmpty(questionIcon))
//                 ? (!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) && getStorageData.readString(getStorageData.profile).toString().compareTo("https//aichatsy.com") == 1)
//                     ? ClipOval(
//                         child: CachedNetworkImage(
//                           imageUrl: getStorageData.readString(getStorageData.profile).toString(),
//                           progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
//                           errorWidget: (context, url, uri) => errorWidgetView(height: 32.px, wight: 32.px),
//                           height: 25.px,
//                           width: 25.px,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     : Image.asset(
//                         (!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) ? getStorageData.readString(getStorageData.profile) : ImagePath.user4),
//                         height: 25.px,
//                       )
//                 : (questionIcon!.compareTo("https//aichatsy.com") == 1)
//                     ? ClipOval(
//                         child: CachedNetworkImage(
//                           imageUrl: questionIcon ?? "",
//                           progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
//                           errorWidget: (context, url, uri) => errorWidgetView(height: 32.px, wight: 32.px),
//                           height: 25.px,
//                           width: 25.px,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     : Image.asset(
//                         questionIcon!,
//                         height: 25.px,
//                       ),
//             SizedBox(width: 8.px),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (!utils.isValidationEmpty(questionImage))
//                     ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(12.px)),
//                       child: (questionImage!.contains("https://aichatsy.com"))
//                           ? CachedNetworkImage(
//                               imageUrl: questionImage ?? "",
//                               progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(borderRadius: 12.px),
//                               errorWidget: (context, url, uri) => errorWidgetView(height: 32.px, wight: 32.px),
//                               width: 150.px,
//                               height: 150.px,
//                               fit: BoxFit.cover,
//                             )
//                           : Image.file(
//                               File(questionImage ?? ""),
//                               width: 150.px,
//                               height: 150.px,
//                               fit: BoxFit.cover,
//                             ),
//                     ).paddingOnly(bottom: 5.px),
//                   if (!utils.isValidationEmpty(question))
//                     Stack(
//                       alignment: Alignment.bottomLeft,
//                       children: [
//                         GestureDetector(
//                           onLongPressStart: onTap ??
//                               (value) {
//                                 FocusManager.instance.primaryFocus?.unfocus();
//
//                                 Navigator.of(Get.context!)
//                                     .push(
//                                   PageRouteBuilder(
//                                       pageBuilder: (context, _, __) => NewChatHelper(
//                                             text: question ?? "",
//                                             isQuestion: true,
//                                             isEdit: isEdit,
//                                             imageView: ((!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) && getStorageData.readString(getStorageData.profile).toString().compareTo("https//aichatsy.com") == 1)
//                                                 ? ClipOval(
//                                                     child: CachedNetworkImage(
//                                                       imageUrl: getStorageData.readString(getStorageData.profile).toString(),
//                                                       progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
//                                                       errorWidget: (context, url, uri) => errorWidgetView(height: 32.px, wight: 32.px),
//                                                       height: 25.px,
//                                                       width: 25.px,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   )
//                                                 : Image.asset(
//                                                     questionIcon ?? (!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) ? getStorageData.readString(getStorageData.profile) : ImagePath.user4),
//                                                     height: 25.px,
//                                                   )),
//                                           ),
//                                       opaque: false),
//                                 )
//                                     .then(
//                                   (value) {
//                                     if (value != null) {
//                                       if (value[HttpUtil.type] == Languages.of(Get.context!)!.edit) {
//                                         if (onTapEdit != null) {
//                                           onTapEdit!(question?.trim() ?? '');
//                                         }
//                                       } else if (value[HttpUtil.type] == Languages.of(Get.context!)!.readLoud) {
//                                         showDialog(
//                                           barrierDismissible: false,
//                                           context: Get.context!,
//                                           builder: (context) {
//                                             return AlertDialog(
//                                               backgroundColor: Colors.transparent,
//                                               alignment: Alignment.bottomCenter,
//                                               content: TextToSpeechView(text: (question ?? "").obs),
//                                             );
//                                           },
//                                         );
//                                       }
//                                     }
//                                   },
//                                 );
//                               },
//                           child: Container(
//                             // width: double.infinity,
//                             margin: EdgeInsets.only(left: 6.px),
//                             decoration: BoxDecoration(color: AppColors.question, borderRadius: BorderRadius.all(Radius.circular(10.px))),
//                             padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 12.px),
//                             child: AppText(
//                               question?.trim() ?? '',
//                               fontSize: 14.px,
//                               color: AppColors.white,
//                             ),
//                           ),
//                         ),
//                         SvgPicture.asset(
//                           ImagePath.arrowChat,
//                           width: 12.px,
//                           height: 12.px,
//                         )
//                       ],
//                     ),
//                 ],
//               ),
//             )
//           ],
//         ).marginOnly(bottom: 8.px, top: 8.px),
//       if ((!utils.isValidationEmpty(ans)) || (!utils.isValidationEmpty(ansImage)) || isUpgrade != null || isImageScan != null)
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             (isUpgrade == null && isImageScan != null && isImageScan!)
//                 ? Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       SizedBox(
//                         height: 20.px,
//                         width: 20.px,
//                         child: const CircularProgressIndicator(
//                           color: AppColors.primary,
//                           strokeWidth: 2,
//                         ),
//                       ),
//                       SvgPicture.asset(
//                         ImagePath.icImageLoading,
//                         width: 15.px,
//                         height: 15.px,
//                       ),
//                       // Container(
//                       //   height: 12.px,
//                       //   width: 12.px,
//                       //   decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
//                       // )
//                     ],
//                   )
//                 : Container(
//                     height: 25.px,
//                     width: 25.px,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: isBorder ? Border.all(color: AppColors().darkAndWhite.changeOpacity(0.05)) : null,
//                     ),
//                     child: ansIcon?.contains("https://aichatsy.com") ?? false
//                         ? ClipOval(
//                             child: CachedNetworkImage(
//                               imageUrl: ansIcon ?? "",
//                               progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
//                               errorWidget: (context, url, uri) => errorWidgetView(height: 25.px, wight: 25.px),
//                               height: 25.px,
//                               width: 25.px,
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : (ansIcon != null)
//                             ? ClipOval(child: (ansIcon!.contains(".svg")) ? SvgPicture.asset(ansIcon!, height: isBorder ? 13.px : 23.px) : Image.asset(ansIcon!, height: isBorder ? 18.px : 30.px))
//                             : Image.asset(((isLight) ? ImagePath.darkLogo : ImagePath.logo), height: isBorder ? 13.px : 23.px)),
//             SizedBox(width: 8.px),
//             Flexible(
//               child: (isUpgrade != null && isUpgrade!)
//                   ? Column(
//                       children: [
//                         AnimatedTextKit(
//                           isRepeatingAnimation: false,
//                           onFinished: () {
//                             if (scrollController != null) {
//                               WidgetsBinding.instance.addPostFrameCallback((_) {
//                                 scrollController?.jumpTo(scrollController!.position.maxScrollExtent);
//                               });
//                             }
//
//                             Global.isVibrate = false;
//                             Global.showTheReview();
//                           },
//                           onNext: (p0, p1) {
//                             if (scrollController != null) {
//                               WidgetsBinding.instance.addPostFrameCallback((_) {
//                                 scrollController?.jumpTo(scrollController!.position.maxScrollExtent);
//                               });
//                             }
//                             printAction("onNextintp0 $p0 ");
//                             printAction("onNextboolp1 $p1 ");
//                           },
//                           onNextBeforePause: (p0, p1) {
//                             printAction("onNextBeforePauseintp0 $p0 ");
//                             printAction("onNextBeforePauseboolp1 $p1 ");
//                             if (scrollController != null) {
//                               WidgetsBinding.instance.addPostFrameCallback((_) {
//                                 scrollController?.jumpTo(scrollController!.position.maxScrollExtent);
//                               });
//                             }
//                           },
//                           animatedTexts: [
//                             TyperAnimatedText(
//                               Languages.of(Get.context!)!.oopsYouReachedYourDailyMessaging,
//                               speed: const Duration(milliseconds: 10),
//                               textStyle: TextStyle(
//                                 fontSize: 14.px,
//                                 color: AppColors().darkAndWhite,
//                                 fontFamily: FontFamily.helveticaRegular,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                           onTap: () {
//                             if (kDebugMode) {
//                               debugPrint("I am executing");
//                             }
//                           },
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             // if (Global.isSubscription.value != "1") {
//                             Get.put(ChatGptController()).goToPurchasePage();
//                             // } else {
//                             //   Get.delete<PurchaseController>();
//                             //   Get.toNamed(Routes.PURCHASE)!.then((value) {
//                             //     if (value != null && value == "plan_purchase") {
//                             //       // controller.getHomeAPI();
//                             //     }
//                             //   });
//                             // }
//                           },
//                           child: Container(
//                             width: double.infinity,
//                             alignment: Alignment.center,
//                             margin: EdgeInsets.only(top: 10.px),
//                             padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 10.w),
//                             decoration: BoxDecoration(border: Border.all(color: AppColors().darkAndWhite.changeOpacity(0.04)), borderRadius: BorderRadius.circular(25.px), color: AppColors().bgColor),
//                             child: RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: Languages.of(Get.context!)!.upgradeToPRO,
//                                     style: TextStyle(
//                                       fontSize: 16.px,
//                                       color: AppColors().darkAndWhite,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: Languages.of(Get.context!)!.pro,
//                                     style: TextStyle(
//                                       fontSize: 18.px,
//                                       color: AppColors.primary,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   : GestureDetector(
//                       onTap: (ansImage == ImagePath.icImageLoading) ? () {} : onTapAns,
//                       onLongPressStart: (onTapAns != null || (isImageScan != null && isImageScan!))
//                           ? (value) {}
//                           : (value) {
//                               FocusManager.instance.primaryFocus?.unfocus();
//
//                               Navigator.of(Get.context!)
//                                   .push(PageRouteBuilder(
//                                       pageBuilder: (context, _, __) => NewChatHelper(
//                                             text: ans ?? "",
//                                             isQuestion: false,
//                                             isEdit: isEdit,
//                                             imageView: ansIcon?.contains("https://aichatsy.com") ?? false
//                                                 ? ClipOval(
//                                                     child: CachedNetworkImage(
//                                                       imageUrl: ansIcon ?? "",
//                                                       progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
//                                                       errorWidget: (context, url, uri) => errorWidgetView(height: 25.px, wight: 25.px),
//                                                       height: 25.px,
//                                                       width: 25.px,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   )
//                                                 : (ansIcon != null)
//                                                     ? ClipOval(child: (ansIcon!.contains(".svg")) ? SvgPicture.asset(ansIcon!, height: isBorder ? 13.px : 23.px) : Image.asset(ansIcon!, height: isBorder ? 18.px : 30.px))
//                                                     : Image.asset(((isLight) ? ImagePath.darkLogo : ImagePath.logo), height: isBorder ? 13.px : 23.px),
//                                           ),
//                                       opaque: false))
//                                   .then(
//                                 (value) {
//                                   if (value != null) {
//                                     if (value[HttpUtil.type] == Languages.of(Get.context!)!.edit) {
//                                       ChatItem askData = value[HttpUtil.data];
//                                       Utils().showToast(message: askData.question.toString());
//                                     } else if (value[HttpUtil.type] == Languages.of(Get.context!)!.readLoud) {
//                                       showDialog(
//                                         barrierDismissible: false,
//                                         context: Get.context!,
//                                         builder: (context) {
//                                           return AlertDialog(
//                                             backgroundColor: Colors.transparent,
//                                             alignment: Alignment.bottomCenter,
//                                             content: TextToSpeechView(text: (ans ?? "").obs),
//                                           );
//                                         },
//                                       );
//                                     } else if (value[HttpUtil.type] == Languages.of(Get.context!)!.regenerateResponse) {
//                                       if (regenerateResponseOnTap != null) {
//                                         regenerateResponseOnTap!();
//                                       }
//                                     }
//                                   }
//                                 },
//                               );
//                             },
//                       child: !utils.isValidationEmpty(ansImage)
//                           ? (ansImage == ImagePath.icImageLoading)
//                               ? Container(
//                                   // width: double.infinity,
//                                   // height: Get.size.width / 1.3,
//                                   decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(20.px))),
//                                   padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 8.px),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(17.px),
//                                     child: imageGenerationLoadingImage(),
//                                   ),
//                                 )
//
//                               // Shimmer.fromColors(
//                               //     baseColor: Colors.grey,
//                               //     highlightColor: AppColors().darkAndWhite,
//                               //     child: Text(
//                               //       'Creating Image',
//                               //       textAlign: TextAlign.center,
//                               //       style: TextStyle(fontSize: 16.px, fontFamily: FontFamily.helveticaBold),
//                               //     ))
//                               : Hero(
//                                   tag: ansImage ?? "",
//                                   child: Container(
//                                     // width: double.infinity,
//                                     // height: Get.size.width / 1.3,
//                                     decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(20.px))),
//                                     padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 8.px),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(17.px),
//                                       child: CachedNetworkImage(
//                                         imageUrl: ansImage ?? "",
//                                         progressIndicatorBuilder: (context, url, progress) => imageGenerationLoadingImage(),
//                                         errorWidget: (context, url, uri) => errorWidgetView(height: 25.px, wight: 25.px),
//                                         // height: 25.px,
//                                         // width: 25.px,
//                                         fit: BoxFit.scaleDown,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                           : Obx(() {
//                               ChatApi.isStreamingData.value;
//                               return Container(
//                                   decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(10.px))),
//                                   padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 12.px),
//                                   child: (isRealTime && utils.isValidationEmpty(ans?.trim()) && isEdit && ChatApi.isStreamingData.value)
//                                       ? Shimmer.fromColors(
//                                           baseColor: Colors.grey,
//                                           highlightColor: AppColors().darkAndWhite,
//                                           child: Text(
//                                             Languages.of(Get.context!)!.realTimeWebSearch.capitalize.toString(),
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(fontSize: 16.px, fontFamily: FontFamily.helveticaBold),
//                                           ))
//                                       : isAnimatedText
//                                           ? AnimatedTextKit(
//                                               key: ValueKey<String>(ans?.trim() ?? ""),
//                                               isRepeatingAnimation: false,
//                                               onFinished: () {
//                                                 if (scrollController != null) {
//                                                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                                                     scrollController?.jumpTo(scrollController!.position.maxScrollExtent);
//                                                   });
//                                                 }
//                                                 if (isImageScan == null && (!(isImageScan ?? true))) {
//                                                   Global.showTheReview();
//                                                 }
//                                               },
//                                               onNext: (p0, p1) {
//                                                 if (scrollController != null) {
//                                                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                                                     scrollController?.jumpTo(scrollController!.position.maxScrollExtent);
//                                                   });
//                                                 }
//                                               },
//                                               onNextBeforePause: (p0, p1) {
//                                                 printAction("onNextBeforePauseintp0 $p0");
//                                                 printAction("onNextBeforePauseboolp1 $p1");
//                                                 if (scrollController != null) {
//                                                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                                                     scrollController?.jumpTo(scrollController!.position.maxScrollExtent);
//                                                   });
//                                                 }
//                                               },
//                                               animatedTexts: [
//                                                 TyperAnimatedText(
//                                                   ans?.trim() ?? "",
//                                                   speed: const Duration(milliseconds: 10),
//                                                   textStyle: TextStyle(
//                                                     fontSize: 14.px,
//                                                     color: AppColors().darkAndWhite,
//                                                     fontFamily: FontFamily.helveticaRegular,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                               ],
//                                               onTap: () {
//                                                 if (kDebugMode) {
//                                                   debugPrint("I am executing");
//                                                 }
//                                               },
//                                             )
//                                           : RichText(
//                                               softWrap: true,
//                                               text: TextSpan(
//                                                 children: [
//                                                   // TextSpan(
//                                                   //   text: ans?.trim() ?? "",
//                                                   //   style: TextStyle(
//                                                   //     fontSize: 14.px,
//                                                   //     height: 1.4,
//                                                   //     overflow: TextOverflow.ellipsis,
//                                                   //     fontFamily: FontFamily.helveticaReg5ular,
//                                                   //     color: AppColors().darkAndWhite,
//                                                   //     backgroundColor: AppColors.yellow,
//                                                   //   ),
//                                                   // ),
//                                                   WidgetSpan(
//                                                     alignment: PlaceholderAlignment.top,
//                                                     child: CommonMarkDownText(text: ans?.trim() ?? ""),
//                                                   ),
//                                                   if (ChatApi.isStreamingData.value && isEdit)
//                                                     WidgetSpan(
//                                                       alignment: PlaceholderAlignment.middle,
//                                                       child: Padding(
//                                                         padding: const EdgeInsets.only(left: 4.0),
//                                                         // child: SvgPicture.asset(ImagePath.icImageLoading, width: 15.px, height: 15.px),
//                                                         child: Image.asset(ImagePath.loadingGif, width: 30.px, height: 30.px),
//                                                       ),
//                                                     ),
//                                                 ],
//                                               ),
//                                             ));
//                             }),
//                     ),
//             )
//           ],
//         ),
//       Obx(
//         () {
//           ChatApi.isStreamingData.value;
//           return (suggestionList != null && suggestionList!.isNotEmpty && isEdit && (!ChatApi.isStreamingData.value))
//               ? Column(
//                   children: [
//                     ListView.separated(
//                       padding: EdgeInsets.symmetric(vertical: 8.px),
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: suggestionList!.length,
//                       separatorBuilder: (context, index) {
//                         return SizedBox(height: 2.px);
//                       },
//                       itemBuilder: (context, index) {
//                         String data = suggestionList![index];
//                         return GestureDetector(
//                           onTap: () {
//                             if (suggestionOnTap != null) {
//                               suggestionOnTap!(data);
//                             }
//                           },
//                           child: CommonContainer(
//                             isBorder: false,
//                             color: AppColors().ansColor,
//                             // border: Border.all(color: AppColors().ansColor),
//                             padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 12.px),
//                             child: AppText(
//                               data,
//                               fontFamily: FontFamily.helveticaRegular,
//                               fontSize: 14.px,
//                               color: AppColors().darkAndWhite,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     SizedBox(height: 4.px),
//                     AppText(Languages.of(Get.context!)!.doYouWantToKeepSeeing, fontSize: 12.px),
//                     SizedBox(height: 5.px),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: CommonContainer(
//                             color: AppColors().ansColor,
//                             alignment: Alignment.center,
//                             radius: 10.px,
//                             padding: EdgeInsets.symmetric(vertical: 5.px),
//                             child: AppText(
//                               Languages.of(Get.context!)!.noHideThem,
//                               fontSize: 14.px,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.px),
//                         Expanded(
//                           child: CommonContainer(
//                             radius: 10.px,
//                             color: AppColors().ansColor,
//                             alignment: Alignment.center,
//                             padding: EdgeInsets.symmetric(vertical: 5.px),
//                             child: AppText(
//                               Languages.of(Get.context!)!.yesKeepThem,
//                               color: AppColors.primary,
//                               fontSize: 14.px,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ).paddingOnly(left: 25.px + 8.px)
//               : const SizedBox();
//         },
//       ),
//     ]);
//   }
// }
//
// /*
// chatQuestionAnsView({
//   ScrollController? scrollController,
//   String? question,
//   String? questionIcon,
//   RxList<String>? suggestionList,
//   Function(String data)? suggestionOnTap,
//   String? questionImage,
//   String? ansImage,
//   String? ans,
//   bool isEdit = false,
//   String? ansIcon,
//   bool? isUpgrade,
//   bool isBorder = true,
//   bool isAnimatedText = false,
//   bool isRealTime = false,
//   bool? isImageScan = false,
//   Function(LongPressStartDetails)? onTap,
//   Function()? onTapAns,
//   Function(String)? onTapEdit,
//   Function()? regenerateResponseOnTap,
// }) {
//   if (isUpgrade ?? false || suggestionList != null) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       scrollController?.jumpTo(scrollController.position.maxScrollExtent);
//     });
//   }
//
//   return Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
//     if (!utils.isValidationEmpty(question))
//       Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           (utils.isValidationEmpty(questionIcon))
//               ? (!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) && getStorageData.readString(getStorageData.profile).toString().compareTo("https//aichatsy.com") == 1)
//               ? ClipOval(
//             child: CachedNetworkImage(
//               imageUrl: getStorageData.readString(getStorageData.profile).toString(),
//               progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
//               errorWidget: (context, url, uri) => errorWidgetView(height: 32.px, wight: 32.px),
//               height: 25.px,
//               width: 25.px,
//               fit: BoxFit.cover,
//             ),
//           )
//               : Image.asset(
//             (!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) ? getStorageData.readString(getStorageData.profile) : ImagePath.user4),
//             height: 25.px,
//           )
//               : (questionIcon!.compareTo("https//aichatsy.com") == 1)
//               ? ClipOval(
//             child: CachedNetworkImage(
//               imageUrl: questionIcon,
//               progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
//               errorWidget: (context, url, uri) => errorWidgetView(height: 32.px, wight: 32.px),
//               height: 25.px,
//               width: 25.px,
//               fit: BoxFit.cover,
//             ),
//           )
//               : Image.asset(
//             questionIcon,
//             height: 25.px,
//           ),
//           SizedBox(width: 8.px),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (!utils.isValidationEmpty(questionImage))
//                   ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(12.px)),
//                     child: (questionImage!.contains("https://aichatsy.com"))
//                         ? CachedNetworkImage(
//                       imageUrl: questionImage,
//                       progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(borderRadius: 12.px),
//                       errorWidget: (context, url, uri) => errorWidgetView(height: 32.px, wight: 32.px),
//                       width: 150.px,
//                       height: 150.px,
//                       fit: BoxFit.cover,
//                     )
//                         : Image.file(
//                       File(questionImage),
//                       width: 150.px,
//                       height: 150.px,
//                       fit: BoxFit.cover,
//                     ),
//                   ).paddingOnly(bottom: 5.px),
//                 if (!utils.isValidationEmpty(question))
//                   Stack(
//                     alignment: Alignment.bottomLeft,
//                     children: [
//                       GestureDetector(
//                         onLongPressStart: onTap ??
//                                 (value) {
//                               FocusManager.instance.primaryFocus?.unfocus();
//
//                               Navigator.of(Get.context!)
//                                   .push(
//                                 PageRouteBuilder(
//                                     pageBuilder: (context, _, __) => NewChatHelper(
//                                       text: question ?? "",
//                                       isQuestion: true,
//                                       isEdit: isEdit,
//                                       imageView: ((!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) && getStorageData.readString(getStorageData.profile).toString().compareTo("https//aichatsy.com") == 1)
//                                           ? ClipOval(
//                                         child: CachedNetworkImage(
//                                           imageUrl: getStorageData.readString(getStorageData.profile).toString(),
//                                           progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
//                                           errorWidget: (context, url, uri) => errorWidgetView(height: 32.px, wight: 32.px),
//                                           height: 25.px,
//                                           width: 25.px,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       )
//                                           : Image.asset(
//                                         questionIcon ?? (!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) ? getStorageData.readString(getStorageData.profile) : ImagePath.user4),
//                                         height: 25.px,
//                                       )),
//                                     ),
//                                     opaque: false),
//                               )
//                                   .then(
//                                     (value) {
//                                   if (value != null) {
//                                     if (value[HttpUtil.type] == Languages.of(Get.context!)!.edit) {
//                                       if (onTapEdit != null) {
//                                         onTapEdit(question?.trim() ?? '');
//                                       }
//                                     } else if (value[HttpUtil.type] == Languages.of(Get.context!)!.readLoud) {
//                                       showDialog(
//                                         barrierDismissible: false,
//                                         context: Get.context!,
//                                         builder: (context) {
//                                           return AlertDialog(
//                                             backgroundColor: Colors.transparent,
//                                             alignment: Alignment.bottomCenter,
//                                             content: TextToSpeechView(text: (question ?? "").obs),
//                                           );
//                                         },
//                                       );
//                                     }
//                                   }
//                                 },
//                               );
//                             },
//                         child: Container(
//                           // width: double.infinity,
//                           margin: EdgeInsets.only(left: 6.px),
//                           decoration: BoxDecoration(color: AppColors.question, borderRadius: BorderRadius.all(Radius.circular(10.px))),
//                           padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 12.px),
//                           child: AppText(
//                             question?.trim() ?? '',
//                             fontSize: 14.px,
//                             color: AppColors.white,
//                           ),
//                         ),
//                       ),
//                       SvgPicture.asset(
//                         ImagePath.arrowChat,
//                         width: 12.px,
//                         height: 12.px,
//                       )
//                     ],
//                   ),
//               ],
//             ),
//           )
//         ],
//       ).marginOnly(bottom: 8.px, top: 8.px),
//     if ((!utils.isValidationEmpty(ans)) || (!utils.isValidationEmpty(ansImage)) || isUpgrade != null || isImageScan != null)
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           (isUpgrade == null && isImageScan != null && isImageScan)
//               ? Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 height: 20.px,
//                 width: 20.px,
//                 child: const CircularProgressIndicator(
//                   color: AppColors.primary,
//                   strokeWidth: 2,
//                 ),
//               ),
//               SvgPicture.asset(
//                 ImagePath.icImageLoading,
//                 width: 15.px,
//                 height: 15.px,
//               ),
//               // Container(
//               //   height: 12.px,
//               //   width: 12.px,
//               //   decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
//               // )
//             ],
//           )
//               : Container(
//               height: 25.px,
//               width: 25.px,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: isBorder ? Border.all(color: AppColors().darkAndWhite.changeOpacity(0.05)) : null,
//               ),
//               child: ansIcon?.contains("https://aichatsy.com") ?? false
//                   ? ClipOval(
//                 child: CachedNetworkImage(
//                   imageUrl: ansIcon ?? "",
//                   progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
//                   errorWidget: (context, url, uri) => errorWidgetView(height: 25.px, wight: 25.px),
//                   height: 25.px,
//                   width: 25.px,
//                   fit: BoxFit.cover,
//                 ),
//               )
//                   : (ansIcon != null)
//                   ? ClipOval(child: (ansIcon.contains(".svg")) ? SvgPicture.asset(ansIcon, height: isBorder ? 13.px : 23.px) : Image.asset(ansIcon, height: isBorder ? 18.px : 30.px))
//                   : Image.asset(((isLight) ? ImagePath.darkLogo : ImagePath.logo), height: isBorder ? 13.px : 23.px)),
//           SizedBox(width: 8.px),
//           Flexible(
//             child: (isUpgrade != null && isUpgrade)
//                 ? Column(
//               children: [
//                 AnimatedTextKit(
//                   isRepeatingAnimation: false,
//                   onFinished: () {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       scrollController?.jumpTo(scrollController.position.maxScrollExtent);
//                     });
//                     Global.isVibrate = false;
//                     Global.showTheReview();
//                   },
//                   onNext: (p0, p1) {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       scrollController?.jumpTo(scrollController.position.maxScrollExtent);
//                     });
//                     printAction("onNextintp0 $p0 ");
//                     printAction("onNextboolp1 $p1 ");
//                   },
//                   onNextBeforePause: (p0, p1) {
//                     printAction("onNextBeforePauseintp0 $p0 ");
//                     printAction("onNextBeforePauseboolp1 $p1 ");
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       scrollController?.jumpTo(scrollController.position.maxScrollExtent);
//                     });
//                   },
//                   animatedTexts: [
//                     TyperAnimatedText(
//                       Languages.of(Get.context!)!.oopsYouReachedYourDailyMessaging,
//                       speed: const Duration(milliseconds: 10),
//                       textStyle: TextStyle(
//                         fontSize: 14.px,
//                         color: AppColors().darkAndWhite,
//                         fontFamily: FontFamily.helveticaRegular,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                   onTap: () {
//                     if (kDebugMode) {
//                       debugPrint("I am executing");
//                     }
//                   },
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // if (Global.isSubscription.value != "1") {
//                     Get.put(ChatGptController()).goToPurchasePage();
//                     // } else {
//                     //   Get.delete<PurchaseController>();
//                     //   Get.toNamed(Routes.PURCHASE)!.then((value) {
//                     //     if (value != null && value == "plan_purchase") {
//                     //       // controller.getHomeAPI();
//                     //     }
//                     //   });
//                     // }
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.only(top: 10.px),
//                     padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 10.w),
//                     decoration: BoxDecoration(border: Border.all(color: AppColors().darkAndWhite.changeOpacity(0.04)), borderRadius: BorderRadius.circular(25.px), color: AppColors().bgColor),
//                     child: RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: Languages.of(Get.context!)!.upgradeToPRO,
//                             style: TextStyle(
//                               fontSize: 16.px,
//                               color: AppColors().darkAndWhite,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           TextSpan(
//                             text: Languages.of(Get.context!)!.pro,
//                             style: TextStyle(
//                               fontSize: 18.px,
//                               color: AppColors.primary,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//                 : GestureDetector(
//               onTap: (ansImage == ImagePath.icImageLoading) ? () {} : onTapAns,
//               onLongPressStart: (onTapAns != null || (isImageScan != null && isImageScan))
//                   ? (value) {}
//                   : (value) {
//                 FocusManager.instance.primaryFocus?.unfocus();
//
//                 Navigator.of(Get.context!)
//                     .push(PageRouteBuilder(
//                     pageBuilder: (context, _, __) => NewChatHelper(
//                       text: ans ?? "",
//                       isQuestion: false,
//                       isEdit: isEdit,
//                       imageView: ansIcon?.contains("https://aichatsy.com") ?? false
//                           ? ClipOval(
//                         child: CachedNetworkImage(
//                           imageUrl: ansIcon ?? "",
//                           progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
//                           errorWidget: (context, url, uri) => errorWidgetView(height: 25.px, wight: 25.px),
//                           height: 25.px,
//                           width: 25.px,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                           : (ansIcon != null)
//                           ? ClipOval(child: (ansIcon.contains(".svg")) ? SvgPicture.asset(ansIcon, height: isBorder ? 13.px : 23.px) : Image.asset(ansIcon, height: isBorder ? 18.px : 30.px))
//                           : Image.asset(((isLight) ? ImagePath.darkLogo : ImagePath.logo), height: isBorder ? 13.px : 23.px),
//                     ),
//                     opaque: false))
//                     .then(
//                       (value) {
//                     if (value != null) {
//                       if (value[HttpUtil.type] == Languages.of(Get.context!)!.edit) {
//                         ChatItem askData = value[HttpUtil.data];
//                         Utils().showToast(message: askData.question.toString());
//                       } else if (value[HttpUtil.type] == Languages.of(Get.context!)!.readLoud) {
//                         showDialog(
//                           barrierDismissible: false,
//                           context: Get.context!,
//                           builder: (context) {
//                             return AlertDialog(
//                               backgroundColor: Colors.transparent,
//                               alignment: Alignment.bottomCenter,
//                               content: TextToSpeechView(text: (ans ?? "").obs),
//                             );
//                           },
//                         );
//                       } else if (value[HttpUtil.type] == Languages.of(Get.context!)!.regenerateResponse) {
//                         if (regenerateResponseOnTap != null) {
//                           regenerateResponseOnTap();
//                         }
//                       }
//                     }
//                   },
//                 );
//               },
//               child: !utils.isValidationEmpty(ansImage)
//                   ? (ansImage == ImagePath.icImageLoading)
//                   ? Container(
//                 // width: double.infinity,
//                 // height: Get.size.width / 1.3,
//                 decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(20.px))),
//                 padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 8.px),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(17.px),
//                   child: imageGenerationLoadingImage(),
//                 ),
//               )
//
//               // Shimmer.fromColors(
//               //     baseColor: Colors.grey,
//               //     highlightColor: AppColors().darkAndWhite,
//               //     child: Text(
//               //       'Creating Image',
//               //       textAlign: TextAlign.center,
//               //       style: TextStyle(fontSize: 16.px, fontFamily: FontFamily.helveticaBold),
//               //     ))
//                   : Hero(
//                 tag: ansImage ?? "",
//                 child: Container(
//                   // width: double.infinity,
//                   // height: Get.size.width / 1.3,
//                   decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(20.px))),
//                   padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 8.px),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(17.px),
//                     child: CachedNetworkImage(
//                       imageUrl: ansImage ?? "",
//                       progressIndicatorBuilder: (context, url, progress) => imageGenerationLoadingImage(),
//                       errorWidget: (context, url, uri) => errorWidgetView(height: 25.px, wight: 25.px),
//                       // height: 25.px,
//                       // width: 25.px,
//                       fit: BoxFit.scaleDown,
//                     ),
//                   ),
//                 ),
//               )
//                   : Obx(() {
//                 ChatApi.isStreamingData.value;
//                 return Container(
//                     decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(10.px))),
//                     padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 12.px),
//                     child: (isRealTime && utils.isValidationEmpty(ans?.trim()) && isEdit && ChatApi.isStreamingData.value)
//                         ? Shimmer.fromColors(
//                         baseColor: Colors.grey,
//                         highlightColor: AppColors().darkAndWhite,
//                         child: Text(
//                           Languages.of(Get.context!)!.realTimeWebSearch.capitalize.toString(),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 16.px, fontFamily: FontFamily.helveticaBold),
//                         ))
//                         : isAnimatedText
//                         ? AnimatedTextKit(
//                       key: ValueKey<String>(ans?.trim() ?? ""),
//                       isRepeatingAnimation: false,
//                       onFinished: () {
//                         WidgetsBinding.instance.addPostFrameCallback((_) {
//                           scrollController?.jumpTo(scrollController.position.maxScrollExtent);
//                         });
//                         if (isImageScan == null && (!(isImageScan ?? true))) {
//                           Global.showTheReview();
//                         }
//                       },
//                       onNext: (p0, p1) {
//                         WidgetsBinding.instance.addPostFrameCallback((_) {
//                           scrollController?.jumpTo(scrollController.position.maxScrollExtent);
//                         });
//                       },
//                       onNextBeforePause: (p0, p1) {
//                         printAction("onNextBeforePauseintp0 $p0");
//                         printAction("onNextBeforePauseboolp1 $p1");
//                         WidgetsBinding.instance.addPostFrameCallback((_) {
//                           scrollController?.jumpTo(scrollController.position.maxScrollExtent);
//                         });
//                       },
//                       animatedTexts: [
//                         TyperAnimatedText(
//                           ans?.trim() ?? "",
//                           speed: const Duration(milliseconds: 10),
//                           textStyle: TextStyle(
//                             fontSize: 14.px,
//                             color: AppColors().darkAndWhite,
//                             fontFamily: FontFamily.helveticaRegular,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                       onTap: () {
//                         if (kDebugMode) {
//                           debugPrint("I am executing");
//                         }
//                       },
//                     )
//                         : RichText(
//                       softWrap: true,
//                       text: TextSpan(
//                         children: [
//                           // TextSpan(
//                           //   text: ans?.trim() ?? "",
//                           //   style: TextStyle(
//                           //     fontSize: 14.px,
//                           //     height: 1.4,
//                           //     overflow: TextOverflow.ellipsis,
//                           //     fontFamily: FontFamily.helveticaReg5ular,
//                           //     color: AppColors().darkAndWhite,
//                           //     backgroundColor: AppColors.yellow,
//                           //   ),
//                           // ),
//                           WidgetSpan(
//                             alignment: PlaceholderAlignment.top,
//                             child: CommonMarkDownText(text: ans?.trim() ?? ""),
//                           ),
//                           if (ChatApi.isStreamingData.value && isEdit)
//                             WidgetSpan(
//                               alignment: PlaceholderAlignment.middle,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 4.0),
//                                 // child: SvgPicture.asset(ImagePath.icImageLoading, width: 15.px, height: 15.px),
//                                 child: Image.asset(ImagePath.loadingGif, width: 30.px, height: 30.px),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ));
//               }),
//             ),
//           )
//         ],
//       ),
//     Obx(
//           () {
//         ChatApi.isStreamingData.value;
//         return (suggestionList != null && suggestionList.isNotEmpty && isEdit && (!ChatApi.isStreamingData.value))
//             ? Column(
//           children: [
//             ListView.separated(
//               padding: EdgeInsets.symmetric(vertical: 8.px),
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: suggestionList.length,
//               separatorBuilder: (context, index) {
//                 return SizedBox(height: 2.px);
//               },
//               itemBuilder: (context, index) {
//                 String data = suggestionList[index];
//                 return GestureDetector(
//                   onTap: () {
//                     if (suggestionOnTap != null) {
//                       suggestionOnTap(data);
//                     }
//                   },
//                   child: CommonContainer(
//                     isBorder: false,
//                     color: AppColors().ansColor,
//                     // border: Border.all(color: AppColors().ansColor),
//                     padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 12.px),
//                     child: AppText(
//                       data,
//                       fontFamily: FontFamily.helveticaRegular,
//                       fontSize: 14.px,
//                       color: AppColors().darkAndWhite,
//                     ),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 4.px),
//             AppText(Languages.of(Get.context!)!.doYouWantToKeepSeeing, fontSize: 12.px),
//             SizedBox(height: 5.px),
//             Row(
//               children: [
//                 Expanded(
//                   child: CommonContainer(
//                     color: AppColors().ansColor,
//                     alignment: Alignment.center,
//                     radius: 10.px,
//                     padding: EdgeInsets.symmetric(vertical: 5.px),
//                     child: AppText(
//                       Languages.of(Get.context!)!.noHideThem,
//                       fontSize: 14.px,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10.px),
//                 Expanded(
//                   child: CommonContainer(
//                     radius: 10.px,
//                     color: AppColors().ansColor,
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(vertical: 5.px),
//                     child: AppText(
//                       Languages.of(Get.context!)!.yesKeepThem,
//                       color: AppColors.primary,
//                       fontSize: 14.px,
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ).paddingOnly(left: 25.px + 8.px)
//             : const SizedBox();
//       },
//     ),
//   ]);
// }*/
