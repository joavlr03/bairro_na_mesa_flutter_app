import 'package:flutter/material.dart';

/// `AppBar` do app: título (Bricolage) e subtítulo sobre a cor da marca.
/// [cor] padrão = verde-horta (Feira na Praça); o Mutirão passa a terra-texto.
/// Com [onVoltar] mostra a seta de voltar. Serve como `Scaffold.appBar` nas
/// telas de detalhe e dentro de uma `Column` nas abas do HomeShell.
class CabecalhoTela extends StatelessWidget implements PreferredSizeWidget {
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

  static const _altura = 80.0;

  @override
  Size get preferredSize => const Size.fromHeight(_altura);

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final texto = tema.colorScheme.onPrimary; // creme sobre verde/terra
    return AppBar(
      backgroundColor: cor ?? tema.colorScheme.primary,
      foregroundColor: texto,
      toolbarHeight: _altura,
      automaticallyImplyLeading: false,
      titleSpacing: onVoltar == null ? 16 : 0,
      leading: onVoltar == null
          ? null
          : IconButton(
              onPressed: onVoltar,
              tooltip: 'Voltar',
              icon: const Icon(Icons.chevron_left_rounded),
              iconSize: 32,
            ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
    );
  }
}
