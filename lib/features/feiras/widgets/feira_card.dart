import 'package:flutter/material.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatadores.dart';
import '../../../models/feira.dart';

class FeiraCard extends StatelessWidget {
  const FeiraCard({super.key, required this.feira, required this.onTap});

  final Feira feira;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;
    final km = feira.distanciaKm;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.espaco4),
          child: Row(
            children: [
              if (km != null)
                Container(
                  width: 60,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: cores.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.raioP),
                  ),
                  child: Column(
                    children: [
                      Text(
                        km.toStringAsFixed(1).replaceAll('.', ','),
                        style: tema.textTheme.titleLarge?.copyWith(
                          color: cores.primary,
                        ),
                      ),
                      Text(
                        'km',
                        style: tema.textTheme.bodySmall?.copyWith(
                          color: cores.primary,
                          fontWeight: FontWeight.w700,
                        ),
                        semanticsLabel: formatarKm(km),
                      ),
                    ],
                  ),
                ),
              const SizedBox(width: AppSpacing.espaco4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(feira.praca, style: tema.textTheme.titleLarge),
                    Text(
                      feira.bairro,
                      style: tema.textTheme.bodyMedium?.copyWith(
                        color: cores.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      feira.quando,
                      style: tema.textTheme.labelLarge?.copyWith(
                        color: cores.primary,
                      ),
                    ),
                    if (feira.temMutirao) ...[
                      const SizedBox(height: 6),
                      // Mutirão se identifica pela terra-texto.
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: cores.tertiaryContainer,
                          borderRadius: BorderRadius.circular(
                            AppRadius.raioPilula,
                          ),
                        ),
                        child: Text(
                          'Tem mutirão de direitos',
                          style: tema.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cores.secondary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
