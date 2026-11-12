import 'package:flutter/material.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatadores.dart';
import '../../../models/oferta.dart';

class ProdutoCard extends StatelessWidget {
  const ProdutoCard({
    super.key,
    required this.oferta,
    required this.quantidade,
    required this.onAdicionar,
    required this.onRemover,
  });

  final Oferta oferta;
  final int quantidade;
  final VoidCallback onAdicionar;
  final VoidCallback onRemover;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _Foto(url: oferta.fotoUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    oferta.nomeComUnidade,
                    style: tema.textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  if (oferta.produtor != null)
                    Text(oferta.produtor!, style: tema.textTheme.bodySmall),
                  // Preço em titulo-3 verde-horta, com vírgula e centavos.
                  Text(
                    formatarMoeda(oferta.preco),
                    style: tema.textTheme.titleLarge?.copyWith(
                      color: cores.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (oferta.esgotado)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: cores.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadius.raioPilula),
                ),
                child: Text('Esgotado', style: tema.textTheme.labelLarge),
              )
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.outlined(
                    onPressed: quantidade > 0 ? onRemover : null,
                    tooltip: 'Tirar um',
                    icon: const Icon(Icons.remove_rounded),
                  ),
                  SizedBox(
                    width: 28,
                    child: Text(
                      '$quantidade',
                      textAlign: TextAlign.center,
                      style: tema.textTheme.titleLarge,
                    ),
                  ),
                  IconButton.filled(
                    onPressed: quantidade < oferta.estoque ? onAdicionar : null,
                    tooltip: 'Colocar mais um',
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _Foto extends StatelessWidget {
  const _Foto({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final vazio = Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: cores.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.raioP),
      ),
      child: Text('foto', style: Theme.of(context).textTheme.bodySmall),
    );
    if (url == null) return vazio;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.raioP),
      child: Image.network(
        url!,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => vazio,
      ),
    );
  }
}
