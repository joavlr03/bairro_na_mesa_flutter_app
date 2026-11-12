import 'package:flutter/material.dart';

import '../../models/cesta.dart';
import '../../models/feira.dart';
import '../../models/pedido.dart';
import '../catalogo/catalogo_screen.dart';
import '../cesta/cesta_screen.dart';
import '../feiras/feiras_screen.dart';
import '../impacto/impacto_screen.dart';
import '../mutirao/mutirao_screen.dart';
import '../pedidos/pedidos_screen.dart';
import '../pedidos/retirada_screen.dart';

/// Shell com as 5 abas. É dono do estado compartilhado (cesta, pedidos da
/// sessão e última feira aberta); as abas recebem tudo por parâmetro e
/// pedem mudanças por callback, sempre dentro de setState aqui.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  static const _abaCesta = 1;
  static const _abaPedidos = 2;
  static const _abaMutirao = 3;

  int _aba = 0;
  final _cesta = Cesta();
  final List<Pedido> _pedidos = [];
  Feira? _feiraAtual;

  void _abrirCatalogo(Feira feira) {
    setState(() => _feiraAtual = feira);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CatalogoScreen(
          feira: feira,
          cesta: _cesta,
          onAdicionar: (o) => setState(() => _cesta.adicionar(feira, o)),
          onRemover: (o) => setState(() => _cesta.remover(o)),
          onVerCesta: () => setState(() => _aba = _abaCesta),
        ),
      ),
    );
  }

  void _pedidoConfirmado(Pedido pedido) {
    setState(() {
      _pedidos.insert(0, pedido);
      _cesta.limpar();
      _aba = _abaPedidos;
    });
  }

  void _abrirPedido(Pedido pedido) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RetiradaScreen(
          pedido: pedido,
          onVerMutirao: () => setState(() => _aba = _abaMutirao),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack mantém o estado de cada aba (evita refazer requisições).
      body: IndexedStack(
        index: _aba,
        children: [
          FeirasScreen(onAbrirFeira: _abrirCatalogo),
          CestaScreen(cesta: _cesta, onPedidoConfirmado: _pedidoConfirmado),
          PedidosScreen(pedidos: _pedidos, onAbrirPedido: _abrirPedido),
          MutiraoScreen(feira: _feiraAtual),
          const ImpactoScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _aba,
        onDestinationSelected: (i) => setState(() => _aba = i),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.storefront_rounded),
            label: 'Feiras',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: _cesta.totalItens > 0,
              label: Text('${_cesta.totalItens}'),
              child: const Icon(Icons.shopping_basket_rounded),
            ),
            label: 'Cesta',
          ),
          const NavigationDestination(
            icon: Icon(Icons.qr_code_2_rounded),
            label: 'Pedidos',
          ),
          const NavigationDestination(
            icon: Icon(Icons.volunteer_activism_rounded),
            label: 'Mutirão',
          ),
          const NavigationDestination(
            icon: Icon(Icons.insights_rounded),
            label: 'Impacto',
          ),
        ],
      ),
    );
  }
}
