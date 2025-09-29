import 'package:get/get.dart';

import '../helper/Global.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/OTPScreen/bindings/otp_screen_binding.dart';
import '../modules/OTPScreen/views/otp_screen_view.dart';
import '../modules/OfferScreen/bindings/offer_screen_binding.dart';
import '../modules/OfferScreen/views/offer_screen_view.dart';
import '../modules/ResetPasswordScreen/bindings/reset_password_screen_binding.dart';
import '../modules/ResetPasswordScreen/views/reset_password_screen_view.dart';
import '../modules/SpecialOfferScreen/bindings/special_offer_screen_binding.dart';
import '../modules/SpecialOfferScreen/views/special_offer_screen_view.dart';
import '../modules/TranslationPage/bindings/translation_page_binding.dart';
import '../modules/TranslationPage/views/translation_page_view.dart';
import '../modules/aboutUs/bindings/about_us_binding.dart';
import '../modules/aboutUs/views/about_us_view.dart';
import '../modules/bottom_navigation/bindings/bottom_navigation_binding.dart';
import '../modules/bottom_navigation/views/bottom_navigation_view.dart';
import '../modules/camera_custom/bindings/camera_custom_binding.dart';
import '../modules/camera_custom/views/camera_custom_view.dart';
import '../modules/chatHistory/bindings/chat_history_binding.dart';
import '../modules/chatHistory/views/chat_history_view.dart';
import '../modules/contactUs/bindings/contact_us_binding.dart';
import '../modules/contactUs/views/contact_us_view.dart';
import '../modules/create_ai_assistant/bindings/create_ai_assistant_binding.dart';
import '../modules/create_ai_assistant/views/create_ai_assistant_view.dart';
import '../modules/editProfile/bindings/edit_profile_binding.dart';
import '../modules/editProfile/views/edit_profile_view.dart';
import '../modules/forgotPasswordScreen/bindings/forgot_password_screen_binding.dart';
import '../modules/forgotPasswordScreen/views/forgot_password_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/imageGeneration/bindings/image_generation_binding.dart';
import '../modules/imageGeneration/views/image_generation_view.dart';
import '../modules/imageScan/bindings/image_scan_binding.dart';
import '../modules/imageScan/views/image_scan_view.dart';
import '../modules/imageShow/bindings/image_show_binding.dart';
import '../modules/imageShow/views/image_show_view.dart';
import '../modules/intro1Screen/bindings/intro1_screen_binding.dart';
import '../modules/intro1Screen/views/intro1_screen_view.dart';
import '../modules/intro2Screen/bindings/intro2_screen_binding.dart';
import '../modules/intro2Screen/views/intro2_screen_view.dart';
import '../modules/intro3/bindings/intro3_binding.dart';
import '../modules/intro3/views/intro3_view.dart';
import '../modules/intro7Screen/bindings/intro7_screen_binding.dart';
import '../modules/intro7Screen/views/intro7_screen_view.dart';
import '../modules/languagePage/bindings/language_page_binding.dart';
import '../modules/languagePage/views/language_page_view.dart';
import '../modules/moreScreen/bindings/more_screen_binding.dart';
import '../modules/moreScreen/views/more_screen_view.dart';
import '../modules/newChat/bindings/new_chat_binding.dart';
import '../modules/newChat/views/new_chat_view.dart';
import '../modules/notificationPermissionPage/bindings/notification_permission_page_binding.dart';
import '../modules/notificationPermissionPage/views/notification_permission_page_view.dart';
import '../modules/privacyPolicy/bindings/privacy_policy_binding.dart';
import '../modules/privacyPolicy/views/privacy_policy_view.dart';
import '../modules/promptChat/bindings/prompt_chat_binding.dart';
import '../modules/promptChat/views/prompt_chat_view.dart';
import '../modules/purchase/bindings/purchase_binding.dart';
import '../modules/purchase/views/purchase_view.dart';
import '../modules/realTimeWeb/bindings/real_time_web_binding.dart';
import '../modules/realTimeWeb/views/real_time_web_view.dart';
import '../modules/reason/bindings/reason_binding.dart';
import '../modules/reason/views/reason_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/signUpScreen/bindings/sign_up_screen_binding.dart';
import '../modules/signUpScreen/views/sign_up_screen_view.dart';
import '../modules/socialScreen/bindings/social_screen_binding.dart';
import '../modules/socialScreen/views/social_screen_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/summarizeDocument/bindings/summarize_document_binding.dart';
import '../modules/summarizeDocument/views/summarize_document_view.dart';
import '../modules/summarizeWebsite/bindings/summarize_website_binding.dart';
import '../modules/summarizeWebsite/views/summarize_website_view.dart';
import '../modules/templatePage/bindings/template_page_binding.dart';
import '../modules/templatePage/views/template_page_view.dart';
import '../modules/termsPage/bindings/terms_page_binding.dart';
import '../modules/termsPage/views/terms_page_view.dart';
import '../modules/themePage/bindings/theme_page_binding.dart';
import '../modules/themePage/views/theme_page_view.dart';
import '../modules/translate/bindings/translate_binding.dart';
import '../modules/translate/views/translate_view.dart';
import '../modules/userProfile/bindings/user_profile_binding.dart';
import '../modules/userProfile/views/user_profile_view.dart';
import '../modules/voicePage/bindings/voice_page_binding.dart';
import '../modules/voicePage/views/voice_page_view.dart';
import '../modules/whatsNew/bindings/whats_new_binding.dart';
import '../modules/whatsNew/views/whats_new_view.dart';
import '../modules/youtubeSummary/bindings/youtube_summary_binding.dart';
import '../modules/youtubeSummary/views/youtube_summary_view.dart';
import '../modules/deepSeekCoder/bindings/deepseek_coder_binding.dart';
import '../modules/deepSeekCoder/views/deepseek_coder_view.dart';
import '../modules/deepSeekMath/bindings/deepseek_math_binding.dart';
import '../modules/deepSeekMath/views/deepseek_math_view.dart';
import '../modules/deepSeekReasoning/bindings/deepseek_reasoning_binding.dart';
import '../modules/deepSeekReasoning/views/deepseek_reasoning_view.dart';
import '../modules/aiAgent/bindings/ai_agent_binding.dart';
import '../modules/aiAgent/views/ai_agent_view.dart';
import '../modules/deploymentAI/bindings/deployment_ai_binding.dart';
import '../modules/deploymentAI/views/deployment_ai_view.dart';
import '../modules/qaAgent/bindings/qa_agent_binding.dart';
import '../modules/qaAgent/views/qa_agent_view.dart';
import '../modules/codeReviewAgent/bindings/code_review_agent_binding.dart';
import '../modules/codeReviewAgent/views/code_review_agent_view.dart';
import '../modules/tutorial/bindings/tutorial_binding.dart';
import '../modules/tutorial/views/tutorial_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: '/event',
      page: () {
        Global.event = true;
        return const SplashView();
      },
      binding: SplashBinding(),
    ),
    GetPage(name: _Paths.HOME, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(name: _Paths.SPLASH, page: () => const SplashView(), binding: SplashBinding()),
    GetPage(
      name: _Paths.INTRO1_SCREEN,
      page: () => const Intro1ScreenView(),
      binding: Intro1ScreenBinding(),
    ),
    GetPage(
      name: _Paths.INTRO2_SCREEN,
      page: () => const Intro2ScreenView(),
      binding: Intro2ScreenBinding(),
    ),
    GetPage(
      name: _Paths.INTRO7_SCREEN,
      page: () => const Intro7ScreenView(),
      binding: Intro7ScreenBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION,
      page: () => BottomNavigationView(),
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_PAGE,
      page: () => const TermsPageView(),
      binding: TermsPageBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASE,
      page: () => const PurchaseView(),
      binding: PurchaseBinding(),
      fullscreenDialog: true,
      popGesture: false,
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(name: _Paths.WHATS_NEW, page: () => const WhatsNewView(), binding: WhatsNewBinding()),
    GetPage(
      name: _Paths.LANGUAGE_PAGE,
      page: () => const LanguagePageView(),
      binding: LanguagePageBinding(),
    ),
    GetPage(name: _Paths.ABOUT_US, page: () => const AboutUsView(), binding: AboutUsBinding()),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(name: _Paths.NEW_CHAT, page: () => const NewChatView(), binding: NewChatBinding()),
    GetPage(
      name: _Paths.CAMERA_CUSTOM,
      page: () => const CameraCustomView(),
      binding: CameraCustomBinding(),
    ),
    GetPage(
      name: _Paths.SUMMARIZE_DOCUMENT,
      page: () => const SummarizeDocumentView(),
      binding: SummarizeDocumentBinding(),
    ),
    GetPage(
      name: _Paths.SUMMARIZE_WEBSITE,
      page: () => const SummarizeWebsiteView(),
      binding: SummarizeWebsiteBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_SCAN,
      page: () => const ImageScanView(),
      binding: ImageScanBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_GENERATION,
      page: () => const ImageGenerationView(),
      binding: ImageGenerationBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_SHOW,
      page: () => const ImageShowView(),
      binding: ImageShowBinding(),
    ),
    GetPage(
      name: _Paths.TEMPLATE_PAGE,
      page: () => const TemplatePageView(),
      binding: TemplatePageBinding(),
    ),
    GetPage(
      name: _Paths.PROMPT_CHAT,
      page: () => const PromptChatView(),
      binding: PromptChatBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_HISTORY,
      page: () => const ChatHistoryView(),
      binding: ChatHistoryBinding(),
    ),
    GetPage(
      name: _Paths.YOUTUBE_SUMMARY,
      page: () => const YoutubeSummaryView(),
      binding: YoutubeSummaryBinding(),
    ),
    GetPage(
      name: _Paths.REAL_TIME_WEB,
      page: () => const RealTimeWebView(),
      binding: RealTimeWebBinding(),
    ),
    GetPage(
      name: _Paths.TRANSLATION_PAGE,
      page: () => const TranslationPageView(),
      binding: TranslationPageBinding(),
    ),
    GetPage(name: _Paths.TRANSLATE, page: () => const TranslateView(), binding: TranslateBinding()),
    GetPage(name: _Paths.LOGIN, page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: _Paths.INTRO3, page: () => const Intro3View(), binding: Intro3Binding()),
    GetPage(name: _Paths.REASON, page: () => const ReasonView(), binding: ReasonBinding()),
    GetPage(
      name: _Paths.MORE_SCREEN,
      page: () => const MoreScreenView(),
      binding: MoreScreenBinding(),
    ),
    GetPage(
      name: _Paths.SPECIAL_OFFER_SCREEN,
      page: () => const SpecialOfferScreenView(),
      binding: SpecialOfferScreenBinding(),
      fullscreenDialog: true,
      popGesture: false,
    ),
    GetPage(
      name: _Paths.OFFER_SCREEN,
      page: () => const OfferScreenView(),
      binding: OfferScreenBinding(),
      fullscreenDialog: true,
      popGesture: false,
    ),
    GetPage(
      name: _Paths.NOTIFICATION_PERMISSION_PAGE,
      page: () => const NotificationPermissionPageView(),
      binding: NotificationPermissionPageBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(name: _Paths.SETTING, page: () => const SettingsView(), binding: SettingsBinding()),
    GetPage(
      name: _Paths.THEME_PAGE,
      page: () => const ThemePageView(),
      binding: ThemePageBinding(),
    ),
    GetPage(
      name: _Paths.VOICE_PAGE,
      page: () => const VoicePageView(),
      binding: VoicePageBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_SCREEN,
      page: () => const SignUpScreenView(),
      binding: SignUpScreenBinding(),
    ),
    GetPage(
      name: _Paths.O_T_P_SCREEN,
      page: () => const OTPScreenView(),
      binding: OTPScreenBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD_SCREEN,
      page: () => const ResetPasswordScreenView(),
      binding: ResetPasswordScreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_SCREEN,
      page: () => const ForgotPasswordScreenView(),
      binding: ForgotPasswordScreenBinding(),
    ),
    GetPage(
      name: _Paths.SOCIAL_SCREEN,
      page: () => const SocialScreenView(),
      binding: SocialScreenBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_AI_ASSISTANT,
      page: () => const CreateAiAssistantView(),
      binding: CreateAiAssistantBinding(),
    ),
    GetPage(
      name: _Paths.AI_AGENT,
      page: () => const AiAgentView(),
      binding: AiAgentBinding(),
    ),
    GetPage(
      name: _Paths.DEPLOYMENT_AI,
      page: () => const DeploymentAiView(),
      binding: DeploymentAiBinding(),
    ),
    GetPage(
      name: _Paths.QA_AGENT,
      page: () => const QaAgentView(),
      binding: QaAgentBinding(),
    ),
    GetPage(
      name: _Paths.TUTORIAL,
      page: () => const TutorialView(),
      binding: TutorialBinding(),
    ),
    GetPage(
      name: _Paths.CODE_REVIEW_AGENT,
      page: () => const CodeReviewAgentView(),
      binding: CodeReviewAgentBinding(),
    ),
  ];
}
