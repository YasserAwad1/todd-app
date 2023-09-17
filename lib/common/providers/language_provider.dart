import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _currentLocale;
  String? language;

  LanguageProvider() {
    if (language != null) {
      _currentLocale = Locale(language!);
    } else {
      _currentLocale = ui.window.locale ?? const Locale('en');
    }
  }

  getLanguage() async {
    language = await locator.get<LocalRepo>().getLanguage();
  }

  Locale get currentLocale => _currentLocale!;

  Future<void> changeLocale(String locale) async {
    _currentLocale = Locale(locale);
    await locator.get<LocalRepo>().setLanguage(locale);
    notifyListeners();
  }

  bool isArabic() {
    return _currentLocale!.languageCode == 'ar';
  }

  Locale? getCurrentLocal() {
    return _currentLocale;
  }
}
