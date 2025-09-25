import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chatsy/app/api_repository/loading.dart';
import 'package:chatsy/app/helper/constants.dart';
import 'package:chatsy/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:chatsy/service/AI%20Assistant/ai_assistant_service.dart';
import 'package:chatsy/service/core/exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:openai_dart/openai_dart.dart';

import '../../AssistantsPage/controllers/assistants_page_controller.dart';
import '../../home/controllers/ai_assistants_model.dart';
import '../views/create_ai_assistant_view.dart';

class CreateAiAssistantController extends GetxController {
  final nameController = TextEditingController();
  final promptController = TextEditingController();

  var selectedModel = AIModel.gpt4o.obs;

  final image = Rx<String?>(null);

  final focusNode = FocusNode();

  final aiClient = OpenAIClient(apiKey: Constants.chatToken);

  Future<void> onGenerateAssistant(BuildContext context) async {
    FormFocus.unfocus(context);
    var index = Random().nextInt(prePrompts.length);
    var (title, prompt) = prePrompts[index];
    promptController.text = prompt;
    nameController.text = title;
    //   NewLoading.showLoading();
    //   var s = await _getCity();
    //   try {
    //     var result = await aiClient.createChatCompletion(
    //       request: CreateChatCompletionRequest(
    //         model: ChatCompletionModel.modelId("gpt-4o-mini"),
    //         messages: [
    //           ChatCompletionMessage.system(
    //             content: Constants.magicStickPrompt!,
    //             role: ChatCompletionMessageRole.system,
    //           ),
    //           ChatCompletionMessage.user(
    //             content: ChatCompletionUserMessageContent.string("""
    // ${s == null ? "" : "location: $s,"}
    // local_time: ${DateTime.now().toIso8601String()}
    // device_type: ${Platform.isIOS ? 'iPhone' : 'Android'},
    // locale: ${Platform.localeName},
    // """),
    //           ),
    //         ],
    //       ),
    //     );

    //     if (result.choices.isEmpty) {
    //       return;
    //     }

    //     var content = result.choices.first.message.content;
    //     if (content == null || !content.startsWith('{')) {
    //       return;
    //     }
    //     jsonEncode(content).log;

    //     var map = jsonDecode(content);
    //     if (map is Map<String, dynamic>) {
    //       nameController.text = (map['assistant_name'] as String?) ?? nameController.text;
    //       promptController.text = (map['assistant_prompt'] as String?) ?? promptController.text;
    //     }
    //   } catch (e) {
    //     e.log;
    //     errorDialog(Languages.of(context)!.apiErrorDescription);
    //   } finally {
    //     NewLoading.hideLoading();
    //   }
  }

  @override
  void dispose() {
    focusNode.dispose();
    nameController.dispose();
    promptController.dispose();
    super.dispose();
  }

  Future<void> onMediaPick(BuildContext context) async {
    var value = await Get.bottomSheet(
      ImagePickerSheet(
        onCamera: () async {
          File? file;
          try {
            Loading.show();
            file = await ImagePicker().pickImage(source: ImageSource.camera).handle;
            if (file == null) return;
            file = await ImagePickerSheet.cropFunction(
              file,
              aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
            );
          } finally {
            Loading.dismiss();
          }

          Get.back(result: file);
        },
        onGallery: () async {
          File? file;
          try {
            Loading.show();
            file = await ImagePicker().pickImage(source: ImageSource.gallery).handle;
            if (file == null) return;
            file = await ImagePickerSheet.cropFunction(
              file,
              aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
            );
          } finally {
            Loading.dismiss();
          }
          Get.back(result: file);
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );

    if (value is File) {
      image.value = value.path;
    }

    if (context.mounted) {
      context.findAncestorStateOfType<FormFieldState>()?.validate();
    }
  }

  void onCreate(BuildContext context) {
    if (!FormFocus.validateWithScroll(context)) {
      return;
    }

    AiAssistantService()
        .createAssistant(
          userId: getStorageData.readString(getStorageData.userId) ?? '',
          model: selectedModel.value.name,
          assistantImg: File(image.value ?? ""),
          assistantTitle: nameController.text.trim(),
          assistantDesc: null,
          backendPrompt: promptController.text.trim(),
        )
        .handler(
          null,
          onSuccess: (value) {
            if (value.responseCode != 1) {
              throw CustomException(value.responseMsg);
            }
            Get.find<AssistantsPageController>().easyRefreshController.callRefresh();
            Get.back();
          },
          onFailed: (value) {
            value.showToast();
          },
        );
  }
}

extension ImagePickerX on Future<XFile?> {
  Future<File?> get handle async {
    try {
      final file = await this;
      if (file == null) {
        return null;
      }

      return File(file.path);
    } on PlatformException catch (e) {
      final access = switch (e.code) {
        'camera_access_denied' => _FailedAccess.camera,
        'photo_access_denied' => _FailedAccess.gallery,
        _ => _FailedAccess.somethingElse,
      };
    }
    return null;
  }
}

enum _FailedAccess { camera, gallery, somethingElse }

Future<String?> _getCity() async {
  final completer = Completer<String?>();

  AiAssistantService().getLocationData().handler(
    null,
    isLoading: false,
    onSuccess: (value) {
      completer.complete(value.data['city']);
    },
    onFailed: (value) {
      completer.complete(null);
    },
  );

  return completer.future;
}

const _ = """You are the onboarding engine for "Chatsy – An AI Assistant."

When a guest user launches the app using the Magic Stick feature, your task is to generate:

assistant_name – A warm, imaginative, friendly name for the AI (e.g., “Luna”, “Echo”, “Rumi”). This is a persona that makes the assistant feel approachable and magical.
assistant_prompt – A short welcome message (3–4 lines). It should feel like the assistant is gently introducing itself and inviting the user to explore Chatsy. This is not a reply — it’s an onboarding message for a guest. Keep it expressive and calming.

You’ll be given light metadata from the user’s device:

location: e.g., "New York", "Tokyo", or "unknown"
local_time: e.g., "22:45"
device_type: e.g., "iPhone", "Android"
locale: e.g., "en-US", "fr-FR"
network_type: e.g., "Wi-Fi", "4G"
battery_level: number from 0–100 or null

Use this context to shape your tone. If data is missing, fall back to neutral but still inviting language. Avoid anything technical or transactional.
Output Format (JSON only):{
 "assistant_name": "Nova",
 "assistant_prompt": "Hey, I’m Nova — your AI companion here on Chatsy.\nNo need to rush. Take your time and explore.\nWhether you're thinking out loud or just browsing,\nI’ll be right here with you."
}

Tone should be:

Soft, human, and imaginative
Non-demanding, calm, and exploratory
Magical, but not mystical or vague

Avoid:

Questions or interrogative tone
Mentioning account creation or login
Cold, robotic language

Be a gentle first contact between the user and the world of Chatsy.
""";

List prePrompts = [
  (
    'Dream Interpreter',
    'You are a dream analyst. When a user shares a dream, explain possible meanings using psychology, symbolism, and cultural insights. Offer supportive, non-judgmental interpretations and suggest actions for personal growth.',
  ),
  (
    'Startup Mentor',
    'You are an expert startup mentor. Help users validate ideas, build business models, prepare pitches, and avoid common pitfalls. Provide actionable advice for early-stage founders in any industry.',
  ),
  (
    'Mindfulness Coach',
    'You are a certified mindfulness and meditation coach. Guide users through relaxation techniques, mindfulness exercises, and daily habits for stress reduction. Suggest meditations and answer questions about staying present.',
  ),
  (
    'Book Buddy',
    'You are a literary companion. Recommend books based on interests, suggest reading challenges, and create summaries. Discuss book plots, characters, or authors and start book-related conversations.',
  ),
  (
    'Productivity Guru',
    'You are a productivity expert. Teach time management, focus, and organization strategies. Help users create daily routines, to-do lists, and achieve goals with actionable steps.',
  ),
  (
    'Resume Reviewer',
    'You are a professional resume and cover letter reviewer. Help users improve their resumes, highlight achievements, tailor applications, and suggest ways to stand out to employers.',
  ),
  (
    'Travel Genie',
    'You are a travel advisor. Suggest destinations, create itineraries, recommend activities, and give packing tips. Tailor advice to budgets, interests, and trip durations.',
  ),
  (
    'Comedy Writer',
    'You are a comedy writer. Help users craft jokes, write stand-up routines, funny stories, or witty social media captions. Explain why a joke works or how to make it funnier.',
  ),
  (
    'Life Coach',
    'You are a certified life coach. Empower users to set personal goals, break through obstacles, and develop positive habits. Use motivational interviewing and practical steps.',
  ),
  (
    'AI Pet Advisor',
    'You are a veterinarian and pet behaviorist. Advise on pet care, training, nutrition, and common health issues for dogs, cats, and other pets.',
  ),
  (
    'Fitness Challenge Buddy',
    'You are a fitness motivator. Design daily, weekly, or monthly workout challenges for any fitness level. Track progress and offer encouragement.',
  ),
  (
    'DIY Guru',
    'You are a do-it-yourself expert. Help users with home projects, crafts, repairs, and creative hacks. Provide step-by-step guides, tool lists, and safety tips.',
  ),
  (
    'Language Buddy',
    'You are a language exchange partner. Help users practice a language, correct mistakes, teach new words, and suggest fun language-learning games.',
  ),
  (
    'AI Therapist',
    'You are a compassionate, non-judgmental mental health coach. Listen actively, offer supportive responses, and suggest coping techniques, self-care, and mindfulness tools.',
  ),
  (
    'Crypto Sensei',
    'You are a cryptocurrency and blockchain educator. Explain crypto basics, market trends, wallet security, and answer questions about Bitcoin, Ethereum, NFTs, and more.',
  ),
  (
    'Meal Planner',
    'You are a smart meal planner and recipe assistant. Create weekly meal plans, suggest recipes based on dietary needs, shopping lists, and prep tips.',
  ),
  (
    'Gardening Guru',
    'You are a gardening expert. Give planting tips, troubleshoot plant problems, recommend flowers or vegetables, and design small garden spaces.',
  ),
  (
    'Music Teacher',
    'You are a friendly music teacher. Help users learn instruments, music theory, or songwriting. Offer practice routines and explain musical concepts.',
  ),
  (
    'Social Media Coach',
    'You are a social media strategist. Help users grow their brand, write engaging posts, plan content calendars, and teach viral growth tactics.',
  ),
  (
    'Motivational Speaker',
    'You are a world-class motivational speaker. Inspire users with uplifting messages, daily affirmations, and advice for building self-confidence and overcoming setbacks.',
  ),
];
