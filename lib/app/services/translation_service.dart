import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../repositories/setting_repository.dart';
import 'settings_service.dart';

class TranslationService extends GetxService {
  final translations = Map<String, Map<String, String>>().obs;
  static List<String> languages = [];

  late SettingRepository _settingsRepo;
  late GetStorage _box;

  TranslationService() {
    _settingsRepo = new SettingRepository();
    _box = new GetStorage();
  }

  // initialize the translation service by loading the assets/locales folder
  // the assets/locales folder must contains file for each language that named
  // with the code of language concatenate with the country code
  // for example (en_US.json)
  Future<TranslationService> init() async {
    languages = await _settingsRepo.getSupportedLocales();
    
    // Ensure Arabic is set as default for first-time users
    String? _locale = _box.read<String>('language');
    if (_locale == null || _locale.isEmpty) {
      await _box.write('language', 'ar');
    }
    
    // Load translations after setting the correct language
    await loadTranslation();
    
    return this;
  }

  Future<void> loadTranslation({locale}) async {
    locale = locale ?? getLocale().languageCode;
    Get.log('Loading translations for locale: $locale');
    Map<String, String> _translations = await _settingsRepo.getTranslations(locale);
    Get.addTranslations({locale: _translations});
    Get.log('Translations loaded: ${_translations.length} keys');
    
    // Update GetX locale to ensure the app uses the correct language
    if (locale.contains('_')) {
      Get.updateLocale(Locale(locale.split('_').elementAt(0), locale.split('_').elementAt(1)));
    } else {
      Get.updateLocale(Locale(locale));
    }
    Get.log('GetX locale updated to: $locale');
  }

  Locale getLocale() {
    String? _locale = _box.read<String>('language');
    Get.log('Stored language: $_locale');
    if (_locale == null || _locale.isEmpty) {
      _locale = Get.find<SettingsService>().setting.value.mobileLanguage;
      Get.log('Backend mobile language: $_locale');
    }
    String finalLocale = _locale ?? 'ar';
    Get.log('Final locale: $finalLocale');
    return fromStringToLocale(finalLocale);
  }

  // get list of supported local in the application
  List<Locale> supportedLocales() {
    return TranslationService.languages.map((_locale) {
      return fromStringToLocale(_locale);
    }).toList();
  }

  // Convert string code to local object
  Locale fromStringToLocale(String _locale) {
    if (_locale.contains('_')) {
      // en_US
      return Locale(_locale.split('_').elementAt(0), _locale.split('_').elementAt(1));
    } else {
      // en
      return Locale(_locale);
    }
  }
}
