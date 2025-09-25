import 'package:flutter/material.dart';

import '../helper/utils.dart';
import 'language_en.dart';
import 'language_es.dart';
import 'language_fr.dart';
import 'language_hin.dart';
import 'language_por.dart';
import 'local_language.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [Utils.languageCodeEn, Utils.languageCodeEs, Utils.languageCodeHin, Utils.languageCodeFr, Utils.languageCodePor].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case Utils.languageCodeEn:
        return LanguageEn();
      case Utils.languageCodeEs:
        return LanguageEs();
      case Utils.languageCodeHin:
        return LanguageHin();
      case Utils.languageCodeFr:
        return LanguageFr();
      case Utils.languageCodePor:
        return LanguagePor();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
