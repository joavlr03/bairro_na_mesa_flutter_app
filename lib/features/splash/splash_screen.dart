import 'package:flutter/material.dart';

import '../../services/onboarding_preferences_service.dart';
import '../home/home_shell.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _prefs = OnboardingPreferencesService();

  @override
  void initState() {
    super.initState();
    _decidirDestino();
  }

  Future<void> _decidirDestino() async {
    final pular = await _prefs.devePularOnboarding();
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => pular ? const HomeShell() : const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cores.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo vertical negativo: telhado/mesa em creme, broto/"Mesa" em milho.
            Image.asset(
              'assets/images/logo-vertical-negativo.png',
              width: 220,
              semanticLabel: 'Bairro na Mesa',
            ),
            const SizedBox(height: 8),
            Text(
              'Comida boa e direitos na sua praça',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: cores.onPrimary),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: cores.tertiary,
                backgroundColor: cores.onPrimary.withAlpha(70),
                strokeWidth: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
