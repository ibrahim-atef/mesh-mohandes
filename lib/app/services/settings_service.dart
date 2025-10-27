import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/ui.dart';
import '../models/address_model.dart';
import '../models/setting_model.dart';
import '../repositories/setting_repository.dart';
import 'auth_service.dart';

class SettingsService extends GetxService {
  final setting = Setting().obs;
  final address = Address().obs;
  late GetStorage _box;

  late SettingRepository _settingsRepo;

  SettingsService() {
    _settingsRepo = new SettingRepository();
    _box = new GetStorage();
  }

  Future<SettingsService> init() async {
    address.listen((Address _address) {
      _box.write('current_address', _address.toJson());
    });
    setting.value = await _settingsRepo.get();
    setting.value.modules = await _settingsRepo.getModules();
    await getAddress();
    return this;
  }

  // Custom color override
  Color getCustomMainColor() {
    return Ui.parseColor("#0046FF"); // Override with custom blue color
  }

  Color getCustomSecondColor() {
    return Ui.parseColor("#0046FF"); // Override with custom blue color
  }

  Color getCustomAccentColor() {
    return Ui.parseColor("#0046FF"); // Override with custom blue color
  }

  ThemeData getLightTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        dividerColor: getCustomAccentColor().withOpacity(0.1),
        focusColor: getCustomAccentColor(),
        hintColor: getCustomSecondColor(),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: getCustomMainColor()),
        ),
        colorScheme: ColorScheme.light(
          primary: getCustomMainColor(),
          secondary: getCustomMainColor(),
        ),
        textTheme: GoogleFonts.getTextTheme(
          _getLocale().startsWith('ar') ? 'Cairo' : 'Poppins',
          TextTheme(
            titleLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: getCustomMainColor(), height: 1.3),
            headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: getCustomSecondColor(), height: 1.3),
            headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: getCustomSecondColor(), height: 1.3),
            displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: getCustomSecondColor(), height: 1.3),
            displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: getCustomMainColor(), height: 1.4),
            displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: getCustomSecondColor(), height: 1.4),
            titleSmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: getCustomSecondColor(), height: 1.2),
            titleMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, color: getCustomMainColor(), height: 1.2),
            bodyMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: getCustomSecondColor(), height: 1.2),
            bodyLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: getCustomSecondColor(), height: 1.2),
            bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: getCustomAccentColor(), height: 1.2),
          ),
        ));
  }

  ThemeData getDarkTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: Color(0xFF252525),
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0),
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        brightness: Brightness.dark,
        dividerColor: getCustomAccentColor().withOpacity(0.1),
        focusColor: getCustomAccentColor(),
        hintColor: getCustomSecondColor(),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: getCustomMainColor()),
        ),
        colorScheme: ColorScheme.dark(
          primary: getCustomMainColor(),
          secondary: getCustomMainColor(),
        ),
        textTheme: GoogleFonts.getTextTheme(
            _getLocale().startsWith('ar') ? 'Cairo' : 'Poppins',
            TextTheme(
              titleLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: getCustomMainColor(), height: 1.3),
              headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: getCustomSecondColor(), height: 1.3),
              headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: getCustomSecondColor(), height: 1.3),
              displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: getCustomSecondColor(), height: 1.3),
              displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: getCustomMainColor(), height: 1.4),
              displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: getCustomSecondColor(), height: 1.4),
              titleSmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: getCustomSecondColor(), height: 1.2),
              titleMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, color: getCustomMainColor(), height: 1.2),
              bodyMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: getCustomSecondColor(), height: 1.2),
              bodyLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: getCustomSecondColor(), height: 1.2),
              bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: getCustomAccentColor(), height: 1.2),
            )));
  }

  ThemeData getWebLightTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        dividerColor: getCustomAccentColor().withOpacity(0.1),
        focusColor: getCustomAccentColor(),
        hintColor: getCustomSecondColor(),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: getCustomMainColor()),
        ),
        colorScheme: ColorScheme.light(
          primary: getCustomMainColor(),
          secondary: getCustomMainColor(),
        ),
        textTheme: GoogleFonts.getTextTheme(
          _getLocale().toString().startsWith('ar') ? 'Cairo' : 'Poppins',
          TextTheme(
            titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: getCustomMainColor(), height: 1.3),
            headlineSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: getCustomSecondColor(), height: 1.3),
            headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: getCustomSecondColor(), height: 1.3),
            displaySmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: getCustomSecondColor(), height: 1.3),
            displayMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: getCustomMainColor(), height: 1.4),
            displayLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w300, color: getCustomSecondColor(), height: 1.4),
            titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: getCustomSecondColor(), height: 1.2),
            titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: getCustomMainColor(), height: 1.2),
            bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: getCustomSecondColor(), height: 1.2),
            bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: getCustomSecondColor(), height: 1.2),
            bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: getCustomAccentColor(), height: 1.2),
          ),
        ));
  }

  ThemeData getWebDarkTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: Color(0xFF252525),
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0),
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        brightness: Brightness.dark,
        dividerColor: getCustomAccentColor().withOpacity(0.1),
        focusColor: getCustomAccentColor(),
        hintColor: getCustomSecondColor(),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: getCustomMainColor()),
        ),
        colorScheme: ColorScheme.dark(
          primary: getCustomMainColor(),
          secondary: getCustomMainColor(),
        ),
        textTheme: GoogleFonts.getTextTheme(
            _getLocale().toString().startsWith('ar') ? 'Cairo' : 'Poppins',
            TextTheme(
              titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: getCustomMainColor(), height: 1.3),
              headlineSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: getCustomSecondColor(), height: 1.3),
              headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: getCustomSecondColor(), height: 1.3),
              displaySmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: getCustomSecondColor(), height: 1.3),
              displayMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: getCustomMainColor(), height: 1.4),
              displayLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w300, color: getCustomSecondColor(), height: 1.4),
              titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: getCustomSecondColor(), height: 1.2),
              titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: getCustomMainColor(), height: 1.2),
              bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: getCustomSecondColor(), height: 1.2),
              bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: getCustomSecondColor(), height: 1.2),
              bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: getCustomAccentColor(), height: 1.2),
            )));
  }

  String _getLocale() {
    String _locale = GetStorage().read<String>('language') ?? '';
    if (_locale.isEmpty) {
      _locale = setting.value.mobileLanguage ?? 'ar';
    }
    return _locale;
  }

  ThemeMode getThemeMode() {
    String? _themeMode = GetStorage().read<String>('theme_mode');
    switch (_themeMode) {
      case 'ThemeMode.light':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.white),
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        if (setting.value.defaultTheme == "dark") {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: Colors.black87),
          );
          return ThemeMode.dark;
        } else {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.white),
          );
          return ThemeMode.light;
        }
    }
  }

  Future getAddress() async {
    try {
      if (_box.hasData('current_address') && !address.value.isUnknown()) {
        address.value = Address.fromJson(await _box.read('current_address'));
      } else if (Get.find<AuthService>().isAuth) {
        List<Address> _addresses = await _settingsRepo.getAddresses();
        if (_addresses.isNotEmpty) {
          address.value = _addresses.firstWhere((_address) => _address.isDefault, orElse: () {
            return _addresses.first;
          });
        }
      }
    } catch (e) {
      Get.log(e.toString());
    }
  }

  bool isModuleActivated(String moduleName) {
    return setting.value.modules?.contains(moduleName) ?? false;
  }
}
