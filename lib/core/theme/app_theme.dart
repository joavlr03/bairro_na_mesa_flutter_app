import 'package:flutter/material.dart';
import 'app_tokens.dart';

/// Tema do Bairro na Mesa. Use: MaterialApp(theme: AppTheme.claro, darkTheme: AppTheme.escuro)
class AppTheme {
  static const _display = 'BricolageGrotesque';
  static const _texto = 'AtkinsonHyperlegible';

  static ThemeData get claro => _build(AppColors.claro, Brightness.light);
  static ThemeData get escuro => _build(AppColors.escuro, Brightness.dark);

  static ThemeData _build(AppColors c, Brightness b) {
    final scheme = ColorScheme(
      brightness: b,
      primary: c.verdeHorta,
      onPrimary: c.creme100,
      primaryContainer: c.verdeBroto,
      onPrimaryContainer: c.tinta,
      secondary: c.terraTexto,
      onSecondary: c.creme200,
      tertiary: c.milho,
      onTertiary: AppColors.claro.tinta,
      tertiaryContainer: c.milhoClaro,
      onTertiaryContainer: c.tinta,
      error: c.erro,
      onError: c.creme200,
      surface: c.creme100,
      onSurface: c.tinta,
      onSurfaceVariant: c.tintaSuave,
      surfaceContainerLowest: c.creme200,
      surfaceContainer: c.creme200,
      surfaceContainerHighest: c.creme300,
      outline: c.linhaCampo,
      outlineVariant: c.linha,
    );

    final text = TextTheme(
      displaySmall: TextStyle(
        fontFamily: _display,
        fontSize: 48,
        height: 52 / 48,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.96,
        color: c.tinta,
      ),
      headlineMedium: TextStyle(
        fontFamily: _display,
        fontSize: 34,
        height: 40 / 34,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: c.tinta,
      ),
      headlineSmall: TextStyle(
        fontFamily: _display,
        fontSize: 26,
        height: 32 / 26,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.26,
        color: c.tinta,
      ),
      titleLarge: TextStyle(
        fontFamily: _display,
        fontSize: 21,
        height: 28 / 21,
        fontWeight: FontWeight.w700,
        color: c.tinta,
      ),
      bodyLarge: TextStyle(
        fontFamily: _texto,
        fontSize: 19,
        height: 28 / 19,
        color: c.tinta,
      ),
      bodyMedium: TextStyle(
        fontFamily: _texto,
        fontSize: 17,
        height: 26 / 17,
        color: c.tinta,
      ),
      labelLarge: TextStyle(
        fontFamily: _texto,
        fontSize: 16,
        height: 20 / 16,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: TextStyle(
        fontFamily: _texto,
        fontSize: 14,
        height: 20 / 14,
        color: c.tintaSuave,
      ),
    );

    const pill = StadiumBorder();
    const minSize = Size(64, kAlvoToque);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.creme100,
      fontFamily: _texto,
      textTheme: text,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: minSize,
          shape: pill,
          textStyle: text.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.espaco6),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: minSize,
          shape: pill,
          textStyle: text.labelLarge,
          foregroundColor: c.verdeHorta,
          side: BorderSide(color: c.verdeHorta, width: 2),
        ),
      ),
      cardTheme: CardThemeData(
        color: c.creme200,
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.raioM),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.verdeBroto,
        labelStyle: text.labelLarge?.copyWith(color: c.tinta),
        shape: const StadiumBorder(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.creme200,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.espaco4,
          vertical: AppSpacing.espaco3,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.raioP),
          borderSide: BorderSide(color: c.linhaCampo),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.raioP),
          borderSide: BorderSide(color: c.linhaCampo),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.raioP),
          borderSide: BorderSide(color: c.foco, width: 2),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.verdeHortaForte,
          minimumSize: const Size(64, kAlvoToque),
          textStyle: text.labelLarge,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.creme200,
        indicatorColor: c.verdeBroto,
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => text.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: s.contains(WidgetState.selected)
                ? c.verdeHortaForte
                : c.tintaSuave,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            color: s.contains(WidgetState.selected)
                ? c.verdeHortaForte
                : c.tintaSuave,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: c.creme100,
        foregroundColor: c.tinta,
        elevation: 0,
        titleTextStyle: text.titleLarge,
      ),
      dividerTheme: DividerThemeData(color: c.linha, thickness: 1),
    );
  }
}
