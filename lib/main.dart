import 'dart:developer' as dev;
import 'dart:io';

import 'package:appvestor_billing_stats/appvestor_billing_stats.dart';
import 'package:camera/camera.dart';
import 'package:chatsy/Customs/buttons.dart';
import 'package:chatsy/app/Localization/local_language.dart';
import 'package:chatsy/app/api_repository/loading.dart';
import 'package:chatsy/app/common_widget/custom_text_field.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/extension.dart';
import 'package:chatsy/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gif_view/gif_view.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app/Localization/app_localizations_delegate.dart';
import 'app/helper/all_imports.dart';
import 'app/helper/image_path.dart';
import 'app/modules/splash/controllers/deep_link_service.dart';
import 'app/routes/app_pages.dart';
import 'app/common_widget/tutorial_overlay.dart';

String version = "";

Future<void> initPackageInfo() async {
  final info = await PackageInfo.fromPlatform();

  if (Platform.isAndroid) {
    version = info.buildNumber;
  } else {
    version = info.version;
  }
  printAction("==============version----------$version");
}

var cameras = <CameraDescription>[];

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class HashKeyProvider {
  static const platform = MethodChannel('com.aichatsy.app/hashKey');

  Future<String?> getHashKey() async {
    try {
      final String? hashKey = await platform.invokeMethod('getHashKey');
      return hashKey;
    } on PlatformException catch (e) {
      debugPrint("Failed to get hash key: '${e.message}'.");
      return null;
    }
  }
}

class GetAndroidDeviceID {
  static const platform = MethodChannel('com.aichatsy.app/hashKey');

  Future<String?> getDeviceId() async {
    try {
      final String? deviceToken = await platform.invokeMethod('getDeviceID');
      return deviceToken;
    } on PlatformException catch (e) {
      debugPrint("Failed to get device token: '${e.message}'.");
      return null;
    }
  }
}

bool isFlutterLocalNotificationsInitialized = false;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
}

late AndroidNotificationChannel channel;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Only enable timeline logging on non-web platforms
  if (!kIsWeb) {
    HttpClient.enableTimelineLogging = kDebugMode;
    HttpOverrides.global = MyHttpOverrides();
  }
  // Initialize Firebase
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
    }
    printAction("✅ Firebase initialized successfully");
  } catch (e) {
    printAction("❌ Firebase initialization failed: $e");
    // Continue app initialization even if Firebase fails
  }

  FlutterError.onError = (errorDetails) {
    dev.log(
      errorDetails.exceptionAsString(),
      stackTrace: errorDetails.stack,
      error: errorDetails.exception,
    );
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  Utils.screenPortrait();

  // Initialize package info and storage in parallel for faster startup
  await Future.wait([
    initPackageInfo(),
    GetStorage.init(),
  ]);
  
  // Initialize secure API keys with timeout for faster startup
  try {
    await Constants.initializeSecureKeys().timeout(Duration(seconds: 3));
    printAction("🔐 Main: Secure API keys initialized");
  } catch (e) {
    printAction("❌ Main: Error initializing secure API keys - $e");
    // Continue app initialization even if API keys fail
  }

  bool darkLight = getStorageData.readBool(getStorageData.isLight) ?? true;

  if (darkLight) {
    isLight = true;
  } else {
    isLight = false;
  }

  Utils.lightStatusBar();

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  FirebaseMessaging.instance.getToken().then((firebaseToken) async {
    printAction("Device Token : $firebaseToken");
    getStorageData.saveString(getStorageData.deviceToken, firebaseToken);
  });

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  await DeepLinkService().initDeepLinking();

  runApp(MyApp());

  printAction("==================islight----------$isLight");
  // Use modern edge-to-edge approach instead of deprecated statusBarColor
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
    ),
  );
  Loading.loadingInit();

  // Only initialize cameras on non-web platforms
  if (!kIsWeb) {
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      debugPrint("${e.code},${e.description}");
    }
  }

  // Initialize AppVestor only on non-web platforms
  if (!kIsWeb) {
    try {
      dev.log("-=-=-AppVestoreController ");
      await AppvestorBillingStats.initialize(hasBilling: true);
      await AppvestorBillingStats.setAccountId(
        acId: "a1-5d541928-0a7f-4ffa-b0e5-cff62d0cf437",
      );
      await AppvestorBillingStats.setAppId(
        apId: "b0-362dacba-ced6-4660-baa8-0f6da0a3756b",
      );
    // Explicitly set ACID to prevent InitException
    // await AppvestorBillingStats.setAcid(
    //   acid: "a1-5d541928-0a7f-4ffa-b0e5-cff62d0cf437",
    // );

      FirebaseAnalytics.instance.logEvent(name: 'appvestore_initialized');
      AppvestorBillingStats.firebaseEvents.listen((event) {
        dev.log("Appvestorbillingstats firstEvent  $event");

        final eventName = event['eventName'] as String;
        final rawPayload = event['payload'];

        // Safely cast
        final parameters =
            (rawPayload is Map) ? Map<String, Object>.from(rawPayload) : null;

        if (parameters != null) {
          FirebaseAnalytics.instance.logEvent(
            name: eventName,
            parameters: parameters,
          );
          dev.log("Appvestorbillingstats event  $event");
        }
      });
    } catch (e) {
      print('AppVestor initialization error: $e');
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, _) {
        return BuilderAny(
          builder: (context, any) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: any,
            );
          },
          any: TutorialOverlay(
            child: GetMaterialApp(
              locale: Locale(Utils.languageCodeDefault, ''),
              supportedLocales: const [
                Locale(Utils.languageCodeEn, ''),
                Locale(Utils.languageCodeEs, ''),
                Locale(Utils.languageCodeHin, ''),
                Locale(Utils.languageCodeFr, ''),
                Locale(Utils.languageCodePor, ''),
              ],
              localizationsDelegates: [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode &&
                      supportedLocale.countryCode == locale?.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(
                builder: (context, child) {
                  return NewLoading(child: child!);
                },
              ),
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              title: Constants.appName,
              themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
              theme: _themeData,
              darkTheme: _darkThemeData,
            ),
          ),
        );
      },
    );
  }
}

ThemeData get _themeData => ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.primary,
    selectionHandleColor: AppColors.primary,
    selectionColor: AppColors.primary.changeOpacity(0.2),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    systemOverlayStyle: LightSystemOverlayStyle.style,
    titleTextStyle: Helvetica(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: Colors.black,
    ),
  ),
  extensions: [
    IconButtonThemes(
      iconButtonStyle: ButtonStyle(
        iconColor: WidgetStatePropertyAll(Colors.black),
        fixedSize: WidgetStatePropertyAll(Size(40, 40)),
      ),
    ),
    TColors.light(),
    TextFieldThemes.light(),
    HelveticaStyles.light(),
    AppButtonTheme.light(),
  ],
);

ThemeData get _darkThemeData => ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.primary,
    selectionHandleColor: AppColors.primary,
    selectionColor: AppColors.primary.changeOpacity(0.2),
  ),
  scaffoldBackgroundColor: Color(0xFF222423),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF222423),
    surfaceTintColor: Color(0xFF222423),
    systemOverlayStyle: DarkSystemOverlayStyle.style,
    titleTextStyle: Helvetica(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: Colors.white,
    ),
  ),
  extensions: [
    IconButtonThemes(
      iconButtonStyle: ButtonStyle(
        iconColor: WidgetStatePropertyAll(Colors.white),
        fixedSize: WidgetStatePropertyAll(Size(40, 40)),
      ),
    ),
    TColors.dark(),
    TextFieldThemes.dark(),
    HelveticaStyles.dark(),
    AppButtonTheme.dark(),
  ],
);

class KColors {
  KColors._();
  static const Color cyanLight = Color.fromRGBO(60, 218, 211, 0.15);
  static const Color cyan = Color.fromRGBO(60, 218, 211, 1);
  static const Color bg = Color(0xFF222423);
  static const Color greyBorder = Color(0xFF222423);
  static const Color textGrey = Color.fromRGBO(185, 185, 189, 1);
  static const Color greyButton = Color.fromRGBO(185, 185, 189, .5);
}

class TColors extends ThemeExtension<TColors> {
  const TColors._({
    required this.bg,
    required this.greyBorder,
    required this.bgColor3,
    required this.borderBottomBar,
  });

  final Color bg;
  final Color greyBorder;
  final Color bgColor3;
  final Color borderBottomBar;

  TColors.light({
    this.bg = Colors.white,
    this.greyBorder = const Color.fromRGBO(0, 0, 0, 0.08),
    this.bgColor3 = const Color(0xFFFAFAFA),
    this.borderBottomBar = const Color(0xffC5C5C5),
  });
  TColors.dark({
    this.bg = KColors.bg,
    this.greyBorder = const Color.fromRGBO(255, 255, 255, 0.5),
    this.bgColor3 = const Color(0xff292B2A),
    this.borderBottomBar = const Color(0xFF333438),
  });

  static TColors of(BuildContext context) {
    return Theme.of(context).extension<TColors>()!;
  }

  @override
  ThemeExtension<TColors> copyWith() {
    return this;
  }

  @override
  ThemeExtension<TColors> lerp(
    covariant ThemeExtension<TColors>? other,
    double t,
  ) {
    if (other is TColors) {
      return TColors._(
        bg: Color.lerp(bg, other.bg, t)!,
        greyBorder: Color.lerp(greyBorder, other.greyBorder, t)!,
        bgColor3: Color.lerp(bgColor3, other.bgColor3, t)!,
        borderBottomBar: Color.lerp(borderBottomBar, other.borderBottomBar, t)!,
      );
    }
    return this;
  }
}

class IconButtonThemes extends ThemeExtension<IconButtonThemes> {
  const IconButtonThemes({required this.iconButtonStyle});

  final ButtonStyle iconButtonStyle;

  @override
  ThemeExtension<IconButtonThemes> copyWith() {
    return this;
  }

  @override
  ThemeExtension<IconButtonThemes> lerp(
    covariant ThemeExtension<IconButtonThemes>? other,
    double t,
  ) {
    if (other is IconButtonThemes) {
      return IconButtonThemes(
        iconButtonStyle:
            ButtonStyle.lerp(iconButtonStyle, other.iconButtonStyle, t)!,
      );
    }
    return this;
  }
}

class DarkSystemOverlayStyle extends AnnotatedRegion<SystemUiOverlayStyle> {
  const DarkSystemOverlayStyle({
    super.key,
    required super.child,
    required super.value,
  });

  static const style = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.light,
  );
}

class LightSystemOverlayStyle extends AnnotatedRegion<SystemUiOverlayStyle> {
  const LightSystemOverlayStyle({
    super.key,
    required super.child,
    required super.value,
  });

  static const style = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}

typedef WidgetBuilderAny<T> = Widget Function(BuildContext context, T any);

class BuilderAny<T> extends Builder {
  BuilderAny({
    super.key,
    required this.any,
    required WidgetBuilderAny<T> builder,
  }) : super(builder: (context) => builder(context, any));

  final T any;
}

class NewLoading extends ObxWidget {
  const NewLoading({super.key, required this.child});

  final Widget child;

  static final _isLoading = false.obs;

  static void showLoading() {
    _isLoading.value = true;
  }

  static void hideLoading() {
    _isLoading.value = false;
  }

  @override
  Widget build() {
    if (!_isLoading.value) {
      return child;
    }

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [IgnorePointer(child: child), Center(child: AppLoader())],
      ),
    );
  }
}

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return GifView.asset(
      ImagePath.loader,
      height: 60,
      width: 60,
      frameRate: 15, // default is 15 FPS
    );
  }
}

extension on (Object?, StackTrace) {
  (Object?, StackTrace) get log {
    dev.log($1.toString(), stackTrace: $2);
    return this;
  }
}

class AppStrings {
  AppStrings._();

  static Languages get T => Languages.of(Get.context!)!;
}
