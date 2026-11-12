import 'package:flutter/material.dart';

import '../../core/utils/formatadores.dart';
import '../../core/widgets/cabecalho_tela.dart';
import '../../core/widgets/estado_view.dart';
import '../../models/cesta.dart';
import '../../models/feira.dart';
import '../../models/oferta.dart';
import '../../services/api_client.dart';
import '../../services/feira_service.dart';
import 'widgets/produto_card.dart';

const _categorias = <(String rotulo, String? valor)>[
  ('Todas', null),
  ('Frutas', 'FRUTAS'),
  ('Verduras', 'VERDURAS'),
  ('Legumes', 'LEGUMES'),
  ('Outros', 'OUTROS'),
];

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({
    super.key,
    required this.feira,
    required this.cesta,
    required this.onAdicionar,
    required this.onRemover,
    required this.onVerCesta,
  });

  final Feira feira;
  final Cesta cesta;

  /// O dono da cesta (HomeShell) altera dentro de setState.
  final ValueChanged<Oferta> onAdicionar;
  final ValueChanged<Oferta> onRemover;
  final VoidCallback onVerCesta;

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final _service = FeiraService();
  LoadStatus _status = LoadStatus.initial;
  List<Oferta> _ofertas = const [];
  String? _erro;
  String? _categoria; // null = todas

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _status = LoadStatus.loading);
    try {
      final ofertas = await _service.listarOfertas(widget.feira.id);
      if (!mounted) return;
      setState(() {
        _ofertas = ofertas;
        _status = LoadStatus.success;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _erro = e.mensagem;
        _status = LoadStatus.error;
      });
    }
  }

  // A cesta pertence a uma feira; em outra feira a quantidade aqui é zero.
  bool get _cestaEstaNestaFeira => widget.cesta.feira?.id == widget.feira.id;

  void _mudar(VoidCallback acao) {
    acao();
    setState(() {}); // a rota empilhada não é reconstruída pelo HomeShell
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final visiveis = _categoria == null
        ? _ofertas
        : _ofertas.where((o) => o.categoria == _categoria).toList();
    final cesta = widget.cesta;
    return Scaffold(
      body: Column(
        children: [
          CabecalhoTela(
            titulo: widget.feira.praca,
            subtitulo:
                '${widget.feira.quando}'
                '${widget.feira.distanciaKm == null ? '' : ' · ${formatarKm(widget.feira.distanciaKm!)}'}',
            onVoltar: () => Navigator.of(context).pop(),
          ),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              itemCount: _categorias.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final (rotulo, valor) = _categorias[i];
                final selecionada = _categoria == valor;
                return ChoiceChip(
                  label: Text(rotulo),
                  selected: selecionada,
                  showCheckmark: false,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selecionada ? cores.onPrimary : null,
                  ),
                  selectedColor: cores.primary,
                  onSelected: (_) => setState(() => _categoria = valor),
                );
              },
            ),
          ),
          Expanded(
            child: EstadoView(
              status: _status,
              erro: _erro,
              onRetry: _carregar,
              vazio: visiveis.isEmpty,
              mensagemVazio: 'Nenhum produto nesta categoria esta semana.',
              builder: (context) => ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                itemCount: visiveis.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final oferta = visiveis[i];
                  return ProdutoCard(
                    oferta: oferta,
                    quantidade: _cestaEstaNestaFeira
                        ? cesta.quantidadeDe(oferta)
                        : 0,
                    onAdicionar: () => _mudar(() => widget.onAdicionar(oferta)),
                    onRemover: () => _mudar(() => widget.onRemover(oferta)),
                  );
                },
              ),
            ),
          ),
          if (_cestaEstaNestaFeira && !cesta.vazia)
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onVerCesta();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Ver cesta · ${cesta.totalItens} '
                          '${cesta.totalItens == 1 ? 'item' : 'itens'}',
                        ),
                      ),
                      Text(formatarMoeda(cesta.total)),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
