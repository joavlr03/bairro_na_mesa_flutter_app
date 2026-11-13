import 'package:bairro_na_mesa/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _abrirApp(WidgetTester tester) async {
  await tester.pumpWidget(const BairroNaMesaApp());
  await tester.pump(const Duration(seconds: 3)); // fim da Splash
  await tester.pumpAndSettle();
}

Future<void> _irAteUltimaPagina(WidgetTester tester) async {
  for (var i = 0; i < 2; i++) {
    await tester.tap(find.text('Avançar'));
    await tester.pumpAndSettle();
  }
}

Future<bool?> _preferenciaSalva() async =>
    (await SharedPreferences.getInstance()).getBool('skipOnboarding');

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
    await _abrirApp(tester);
    expect(find.text('Feiras perto de você'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('Começar com a opção desmarcada não salva a preferência', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await _abrirApp(tester);
    await _irAteUltimaPagina(tester);
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();
    expect(find.text('Feiras perto de você'), findsOneWidget);
    expect(await _preferenciaSalva(), isNull);
  });

  testWidgets(
    'Começar com "Não mostrar novamente" marcado salva a preferência',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      await _abrirApp(tester);
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      await _irAteUltimaPagina(tester);
      await tester.tap(find.text('Começar'));
      await tester.pumpAndSettle();
      expect(find.text('Feiras perto de você'), findsOneWidget);
      expect(await _preferenciaSalva(), isTrue);
    },
  );
}
