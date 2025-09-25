import 'dart:io';

import 'package:chatsy/extension.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'all_imports.dart';
import 'image_path.dart';

/// <<< To get commons function --------- >>>
class Utils {
  static const String languageCodeEn = 'en';
  static const String languageCodeEs = 'es';
  static const String languageCodeHin = 'hi';
  static const String languageCodeFr = 'fr';
  static const String languageCodePor = 'pt';
  static String languageCodeDefault = languageCodeEn;

  /// <<< To create dark status bar --------- >>>
  static void darkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: (Platform.isAndroid) ? Brightness.dark : Brightness.light,
        statusBarBrightness: (Platform.isAndroid) ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  bool isValidYouTubeUrl(String url) {
    final RegExp youtubeUrlRegex = RegExp(
      r'^(https?\:\/\/)?(www\.youtube\.com|youtube\.com|youtu\.be)\/(watch\?v=|embed\/|v\/|shorts\/|user\/\w+\/\w+\/\w+\/|playlist\?list=|.+\?v=|.+\?list=)?[a-zA-Z0-9_-]{11}.*$',
      caseSensitive: false,
    );
    return youtubeUrlRegex.hasMatch(url);
  }

  String? getYouTubeVideoId(String url) {
    Uri uri = Uri.parse(url);
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'shorts') {
      return uri.pathSegments[1];
    }

    final RegExp regExp = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );
    final Match? match = regExp.firstMatch(url);
    return match?.group(1);
  }

  String todayDate() {
    return utils.changeDateFormat(
      date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      outputFormat: "dd-MMM-yyyy",
    );
  }

  String getDateLabel(String dateString, String outputFormat) {
    try {
      if (!isValidationEmpty(dateString)) {
        DateTime dateTime = DateTime.parse(dateString).toLocal();
        String formattedDate = DateFormat(outputFormat).format(dateTime);
        return formattedDate;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  void urlLaunch(Uri url) async {
    printAction("urlLaunchurlLaunch");
    // if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  /// <<< To create light status bar --------- >>>
  static void lightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        systemNavigationBarColor: AppColors.white,
        statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light, // status bar color
        statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
      ),
    );
  }

  /// <<< To choose screens portrait --------- >>>
  static void screenPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// <<< To get device type --------- >>>
  String getDeviceType() {
    if (Platform.isAndroid) {
      return 'Android';
    } else {
      return 'iOS';
    }
  }

  /// <<< To check email valid or not --------- >>>
  bool emailValidator(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(email)) {
      return true;
    }
    return false;
  }

  /// <<< To check phone valid or not --------- >>>
  bool phoneValidator(String contact) {
    String p = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }
    return false;
  }

  /// <<< To check password valid or not --------- >>>
  bool passwordValidator(String contact) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }
    return false;
  }

  /// <<< To check data, string, list, object are empty or not --------- >>>
  bool isValidationEmpty(String? val) {
    if (val == null || val.isEmpty || val == "null" || val == "" || val == "NULL") {
      return true;
    } else {
      return false;
    }
  }

  /// <<< To show snackBar massage  --------- >>>
  void showSnackBar({
    required BuildContext context,
    required String message,
    int? statusCode,
    bool? isOk = false,
  }) {
    Future<void>.delayed(Duration.zero, () {
      Get.snackbar(
        "",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: isOk! ? Colors.green.shade600 : Colors.red.shade600,
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        padding: const EdgeInsets.only(bottom: 15, top: 10, left: 15, right: 15),
        titleText: Container(),
      );
    });
  }

  /// <<< To show toast massage  --------- >>>
  void showToast({String? message}) {
    if (message != null)
      Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        webShowClose: GetPlatform.isIOS,
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColors.white,
        backgroundColor: Colors.black,
      );
  }

  /// <<< To show Custom toast massage  --------- >>>

  void showCustomToast({required String message}) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,

      elevation: 0,

      content: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(bottom: 50),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7.px),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.changeOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                ImagePath.icRight,
                width: 20.px,
                height: 20.px,
              ).marginOnly(right: 10.px),
              AppText(message, fontSize: 12.px, color: AppColors.black),
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
      //   behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  /// <<< To transfer string to Md5 --------- >>>
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  /// <<<--- Time Picker ------------------------->>>
  Future<TimeOfDay> selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: selectedTime);

    if (picked != null && picked != selectedTime) {
      printCancel("---picked-time-->$picked");
      selectedTime = picked;
      return picked;
    }
    return selectedTime;
  }

  /// <<< hide keyboard --------- >>>
  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// <<< To using country code get his emoji --------- >>>
  String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  /// <<< To transfer time to milliSeconds --------- >>>
  static transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String strTime = '';
    if (hoursStr == '00' || hoursStr == '0') {
      strTime = '$minutesStr:$secondsStr';
    } else {
      strTime = '$hoursStr:$minutesStr:$secondsStr';
    }
    return strTime;
  }

  /// <<< To get current time --------- >>>
  String currentTime() {
    String month = DateFormat.M().format(DateTime.now().toUtc());
    String day = DateFormat.d().format(DateTime.now().toUtc());
    String time = DateFormat.Hm().format(DateTime.now().toUtc());
    String timeDate =
        '${DateFormat.y().format(DateTime.now().toUtc())}-${month.length == 1 ? '0$month' : month}-${day.length == 1 ? '0$day' : day} $time';
    return timeDate;
  }

  /// <<< To get current date --------- >>>
  String currentDate(String outputFormat) {
    var now = DateTime.now().toUtc();
    var formatter = DateFormat(outputFormat);
    String formattedDate = formatter.format(now);

    return formattedDate;
  }

  // /// <<< To launch url --------- >>>
  // void urlLaunch(Uri url) async {
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   }
  // }

  List<String> fillSlots() {
    List<String> list = [];
    for (int i = 1; i <= 100; i++) {
      list.add("$i");
    }
    return list;
  }

  // Future<String> getFileNameWithExtension(File file) async {
  //   if (await file.exists()) {
  //     return path.basename(file.path);
  //   } else {
  //     return "";
  //   }
  // }

  /// <<< To change date formant --------- >>>
  String changeDateFormat({DateTime? date, String? outputFormat}) {
    if (date != null) {
      DateFormat formatter = DateFormat(outputFormat);
      String formatted = formatter.format(date);
      return formatted;
    }
    return '';
  }

  /// check image file Corrupted or not --------- >>>

  Future<bool> isImageCorrupted(String path) async {
    try {
      final file = File(path);
      if (!await file.exists()) return true;
      Uint8List imageBytes = await file.readAsBytes();
      await decodeImageFromList(imageBytes);
      return false;
    } catch (e) {
      return true;
    }
  }

  Future<bool> isPdfCorrupted(String path) async {
    try {
      final file = File(path);

      if (!await file.exists()) {
        return true;
      }
      final List<int> firstBytes = await file.openRead(0, 5).first;

      String header = String.fromCharCodes(firstBytes);
      if (!header.startsWith('%PDF-')) {
        return true; // Invalid PDF header
      }
      int length = await file.length();
      final List<int> lastBytes = await file.openRead(length - 7, length).first;

      String footer = String.fromCharCodes(lastBytes);
      if (!footer.contains('%%EOF')) {
        return true;
      }

      return false;
    } catch (e) {
      return true;
    }
  }

  bool isValidDate(String input) {
    try {
      final date = DateTime.parse(input);
      final originalFormatString = toOriginalFormatString(date);
      return input == originalFormatString;
    } catch (e) {
      return false;
    }
  }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y$m$d";
  }

  /// Time Ago Since Date --------- >>>
  String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime dateUtc = DateTime.parse(dateString);
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc.toString(), true);
    DateTime date = dateTime.toLocal();
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return (numericDates)
          ? '${(difference.inDays / 365).floor()} Y'
          : '${(difference.inDays / 365).floor()} Years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 Y' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} M';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 M' : 'Last Month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return (numericDates)
          ? '${(difference.inDays / 7).floor()} w'
          : '${(difference.inDays / 7).floor()} Weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 w' : 'Last week';
    } else if (difference.inDays >= 2) {
      return (numericDates) ? '${difference.inDays} d' : '${difference.inDays} Days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 d' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} h';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 h' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} min';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 min' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} sec';
    } else {
      return 'now';
    }
  }

  String formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int hours = minutes ~/ 60;
    final int remainingSeconds = seconds % 60;
    final int remainingMinutes = minutes % 60;

    if (hours > 0) {
      return '${_formatNumber(hours)}:${_formatNumber(remainingMinutes)}:${_formatNumber(remainingSeconds)}';
    } else {
      return '${_formatNumber(remainingMinutes)}:${_formatNumber(remainingSeconds)}';
    }
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  /// <<< To get Day Of Month Suffix --------- >>>
  String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  /// <<< To read Time stamp --------- >>>
  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('dd-yyyy,MM HH:mm a');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = '${diff.inDays}DAY AGO';
      } else {
        time = '${diff.inDays}DAYS AGO';
      }
    }

    return time;
  }

  //   Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //     ByteData data = await rootBundle.load(path);
  //     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  //     ui.FrameInfo fi = await codec.getNextFrame();
  //     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  //   }
  // }
}

/// <<< Error Massage Red color --------- >>>
void printError(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[91m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Ok Status Massage Green Color --------- >>>
void printOkStatus(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[92m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Warning Massage Yellow Color --------- >>>
void printWarning(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[93m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Action Massage Blue Color --------- >>>
void printAction(String text) {
  if (Platform.isAndroid) {
    ('\x1B[94m$text\x1B[0m').log;
  } else {
    (text).log;
  }
}

/// <<< Cancel Massage Gray Color --------- >>>
void printCancel(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[96m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Error Massage Red color --------- >>>
void printWhite(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[97m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// Color debugPrint Code --------------->>>>
/**
    debugPrint("\x1B[1m 1hello \x1B[0m");
    debugPrint("\x1B[3m 3hello \x1B[0m");
    debugPrint("\x1B[4m 4hello \x1B[0m");
    debugPrint("\x1B[7m 7hello \x1B[0m");
    debugPrint("\x1B[9m 9hello \x1B[0m");
    debugPrint("\x1B[21m 21hello \x1B[0m");
    debugPrint("\x1B[30m 30hello \x1B[0m");
    debugPrint("\x1B[31m 31hello \x1B[0m");
    debugPrint("\x1B[32m 32hello \x1B[0m");
    debugPrint("\x1B[33m 33hello \x1B[0m");
    debugPrint("\x1B[34m 34hello \x1B[0m");
    debugPrint("\x1B[35m 35hello \x1B[0m");
    debugPrint("\x1B[36m 36hello \x1B[0m");
    debugPrint("\x1B[37m 37hello \x1B[0m");
    debugPrint("\x1B[40m 40hello \x1B[0m");
    debugPrint("\x1B[41m 41hello \x1B[0m");
    debugPrint("\x1B[42m 42hello \x1B[0m");
    debugPrint("\x1B[43m 43hello \x1B[0m");
    debugPrint("\x1B[44m 44hello \x1B[0m");
    debugPrint("\x1B[45m 45hello \x1B[0m");
    debugPrint("\x1B[46m 46hello \x1B[0m");
    debugPrint("\x1B[47m 47hello \x1B[0m");
    debugPrint("\x1B[51m 51hello \x1B[0m");
    debugPrint("\x1B[52m 52hello \x1B[0m");
    debugPrint("\x1B[90m 90hello \x1B[0m");
    debugPrint("\x1B[91m 91hello \x1B[0m");
    debugPrint("\x1B[92m 92hello \x1B[0m");
    debugPrint("\x1B[93m 93hello \x1B[0m");
    debugPrint("\x1B[94m 94hello \x1B[0m");
    debugPrint("\x1B[95m 95hello \x1B[0m");
    debugPrint("\x1B[96m 96hello \x1B[0m");
    debugPrint("\x1B[97m 97hello \x1B[0m");
    debugPrint("\x1B[100m 100hello \x1B[0m");
    debugPrint("\x1B[101m 101hello \x1B[0m");
    debugPrint("\x1B[102m 102hello \x1B[0m");
    debugPrint("\x1B[103m 103hello \x1B[0m");
    debugPrint("\x1B[104m 104hello \x1B[0m");
    debugPrint("\x1B[105m 105hello \x1B[0m");
    debugPrint("\x1B[106m 106hello \x1B[0m");
    debugPrint("\x1B[107m 107hello \x1B[0m");
    debugPrint("\x1B[108m 108hello \x1B[0m");
 **/
