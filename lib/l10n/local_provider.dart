import 'package:flutter/material.dart';

import 'all_locales.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('ru');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!AllLocales.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}
