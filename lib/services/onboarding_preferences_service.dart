import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPreferencesService {
  static const _chave = 'skipOnboarding';

  Future<bool> devePularOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_chave) ?? false;
  }

  Future<void> salvarPularOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_chave, true);
  }
}
