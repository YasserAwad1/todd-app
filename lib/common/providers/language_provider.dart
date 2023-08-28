import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _currentLocale;

  LanguageProvider() {
    _currentLocale = ui.window.locale ?? const Locale('en');
  }

  Locale get currentLocale => _currentLocale!;

  void changeLocale(String locale) {
    _currentLocale = Locale(locale);
    notifyListeners();
  }

  bool isArabic() {
    return _currentLocale!.languageCode == 'ar';
  }
}
