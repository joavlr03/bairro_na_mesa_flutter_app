import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/utils/formatadores.dart';
import '../../core/widgets/cabecalho_tela.dart';
import '../../models/pedido.dart';

class RetiradaScreen extends StatelessWidget {
  const RetiradaScreen({
    super.key,
    required this.pedido,
    required this.onVerMutirao,
  });

  final Pedido pedido;
  final VoidCallback onVerMutirao;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CabecalhoTela(
        titulo: 'Retirada do pedido',
        subtitulo: 'Mostre este código na barraca',
        onVoltar: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: cores.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            pedido.statusLegivel,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: cores.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        QrImageView(
                          data: pedido.codigo,
                          size: 220,
                          semanticsLabel: 'QR code do pedido ${pedido.codigo}',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pedido.codigo,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(letterSpacing: 3),
                        ),
                        const SizedBox(height: 16),
                        if (pedido.praca != null) _Info('Onde', pedido.praca!),
                        if (pedido.quando != null)
                          _Info('Quando', pedido.quando!),
                        _Info(
                          'Total a pagar',
                          formatarMoeda(pedido.total),
                          cor: cores.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onVerMutirao();
                  },
                  child: const Text('Ver atendimentos do mutirão'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info(this.rotulo, this.valor, {this.cor});

  final String rotulo;
  final String valor;
  final Color? cor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(rotulo, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(
            valor,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: cor,
            ),
          ),
        ],
      ),
    );
  }
}
