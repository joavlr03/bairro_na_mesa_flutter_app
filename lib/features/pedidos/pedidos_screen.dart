import 'package:flutter/material.dart';

import '../../core/utils/formatadores.dart';
import '../../core/widgets/cabecalho_tela.dart';
import '../../models/pedido.dart';

/// Pedidos feitos nesta sessão (sem login, a lista vive no HomeShell).
class PedidosScreen extends StatelessWidget {
  const PedidosScreen({
    super.key,
    required this.pedidos,
    required this.onAbrirPedido,
  });

  final List<Pedido> pedidos;
  final ValueChanged<Pedido> onAbrirPedido;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Column(
      children: [
        const CabecalhoTela(titulo: 'Meus pedidos'),
        Expanded(
          child: pedidos.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Você ainda não fez nenhum pedido.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: pedidos.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final p = pedidos[i];
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => onAbrirPedido(p),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.codigo,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    if (p.praca != null)
                                      Text('${p.praca} · ${p.quando}'),
                                    Text(
                                      '${p.statusLegivel} · ${formatarMoeda(p.total)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: cores.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.qr_code_2_rounded),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
