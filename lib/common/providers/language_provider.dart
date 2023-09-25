import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _currentLocale;
  String? language;

  LanguageProvider() {}

  getLanguage() async {
    if (await locator.get<LocalRepo>().getLanguage() == null) {
      print(
          '*******************************************************************************************');
      print('GETTING LANGUAGE');
      print(
          '*******************************************************************************************');
      language = 'en';
      _currentLocale = Locale(language!);
      notifyListeners();
    } else {
      language = await locator.get<LocalRepo>().getLanguage();
      _currentLocale = Locale(language!);
      notifyListeners();
    }
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
