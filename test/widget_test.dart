import 'package:flutter/material.dart';
import 'package:bairro_na_mesa/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Splash vai para o Onboarding quando não há preferência', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const BairroNaMesaApp());
    expect(find.byType(Image), findsOneWidget); // logo
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Feira perto de você'), findsOneWidget);
  });

  testWidgets('Splash vai direto para a Home com skipOnboarding = true', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'skipOnboarding': true});
    await tester.pumpWidget(const BairroNaMesaApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Feiras perto de você'), findsOneWidget);
  });
}
