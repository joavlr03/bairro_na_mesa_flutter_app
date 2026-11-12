import 'package:flutter/material.dart';

/// Indicador do painel de impacto: rótulo, valor grande (Bricolage) e legenda.
/// [destaque] pinta o card em verde-horta (cartão largo do mockup).
class IndicadorCard extends StatelessWidget {
  const IndicadorCard({
    super.key,
    required this.rotulo,
    required this.valor,
    this.legenda,
    this.destaque = false,
  });

  final String rotulo;
  final String valor;
  final String? legenda;
  final bool destaque;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;
    final corTexto = destaque ? cores.onPrimary : cores.onSurface;
    final corValor = destaque
        ? cores.tertiary
        : cores.primary; // milho sobre verde
    return Card(
      color: destaque ? cores.primary : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rotulo,
              style: tema.textTheme.labelLarge?.copyWith(color: corTexto),
            ),
            const SizedBox(height: 4),
            Text(
              valor,
              style: tema.textTheme.headlineMedium?.copyWith(color: corValor),
            ),
            if (legenda != null)
              Text(
                legenda!,
                style: tema.textTheme.bodySmall?.copyWith(
                  color: destaque ? cores.onPrimary : cores.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
