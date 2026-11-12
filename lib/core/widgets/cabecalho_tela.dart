import 'package:flutter/material.dart';

/// Faixa de cor com título (Bricolage) e subtítulo, presente em todas as telas.
/// [cor] padrão = verde-horta (Feira na Praça); o Mutirão passa a terra-texto.
/// Com [onVoltar] mostra a seta de voltar à esquerda.
class CabecalhoTela extends StatelessWidget {
  const CabecalhoTela({
    super.key,
    required this.titulo,
    this.subtitulo,
    this.onVoltar,
    this.cor,
  });

  final String titulo;
  final String? subtitulo;
  final VoidCallback? onVoltar;
  final Color? cor;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final fundo = cor ?? tema.colorScheme.primary;
    final texto = tema.colorScheme.onPrimary; // creme sobre verde/terra
    return Container(
      width: double.infinity,
      color: fundo,
      padding: EdgeInsets.fromLTRB(
        onVoltar == null ? 16 : 8,
        MediaQuery.paddingOf(context).top + 16,
        16,
        16,
      ),
      child: Row(
        children: [
          if (onVoltar != null)
            IconButton(
              onPressed: onVoltar,
              tooltip: 'Voltar',
              icon: Icon(Icons.chevron_left_rounded, color: texto),
              iconSize: 32,
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: tema.textTheme.headlineSmall?.copyWith(color: texto),
                ),
                if (subtitulo != null)
                  Text(
                    subtitulo!,
                    style: tema.textTheme.bodyMedium?.copyWith(color: texto),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
