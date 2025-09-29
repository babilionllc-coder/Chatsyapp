import 'package:shared_preferences/shared_preferences.dart';

import '../helper/all_imports.dart';

const String prefSelectedLanguageCode = "select_language";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(prefSelectedLanguageCode, languageCode);
  Utils.languageCodeDefault = languageCode;

  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  /* var split = Platform.localeName.logNamed("Platform.localeName").split('_');
  if (split.isNotEmpty) {
    split.first;
    prefs.setString(prefSelectedLanguageCode, split.first);
  } */
  String languageCode = prefs.getString(prefSelectedLanguageCode) ?? Utils.languageCodeDefault;
  Utils.languageCodeDefault = languageCode;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty ? Locale(languageCode, '') : Locale(Utils.languageCodeDefault, '');
}

Future<void> changeLanguage(BuildContext context, String selectedLanguageCode) async {
  Locale locale = await setLocale(selectedLanguageCode);
  debugPrint("-=-=-=-=locale");
  Get.updateLocale(locale);
}
