import 'package:flutter/material.dart';

enum LoadStatus { initial, loading, success, error }

/// Exibe loading, erro (com retry) ou vazio; no sucesso com dados mostra [builder].
class EstadoView extends StatelessWidget {
  const EstadoView({
    super.key,
    required this.status,
    required this.builder,
    this.onRetry,
    this.erro,
    this.vazio = false,
    this.mensagemVazio = 'Nada por aqui ainda.',
  });

  final LoadStatus status;
  final WidgetBuilder builder;
  final VoidCallback? onRetry;
  final String? erro;
  final bool vazio;
  final String mensagemVazio;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case LoadStatus.initial:
        return const _Carregando('Preparando…');
      case LoadStatus.loading:
        return const _Carregando('Carregando…');
      case LoadStatus.error:
        return _Mensagem(
          icone: Icons.wifi_off,
          texto: erro ?? 'Não foi possível carregar.',
          onRetry: onRetry,
        );
      case LoadStatus.success:
        if (vazio) {
          return _Mensagem(icone: Icons.inbox_outlined, texto: mensagemVazio);
        }
        return builder(context);
    }
  }
}

class _Carregando extends StatelessWidget {
  const _Carregando(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 12),
          Text(texto),
        ],
      ),
    );
  }
}

class _Mensagem extends StatelessWidget {
  const _Mensagem({required this.icone, required this.texto, this.onRetry});

  final IconData icone;
  final String texto;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 48),
            const SizedBox(height: 12),
            Text(texto, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Tentar de novo'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
