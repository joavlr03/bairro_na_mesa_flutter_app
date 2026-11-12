import 'package:flutter/material.dart';

import '../../core/utils/formatadores.dart';
import '../../core/widgets/cabecalho_tela.dart';
import '../../models/cesta.dart';
import '../../models/pedido.dart';
import '../../services/api_client.dart';
import '../../services/pedido_service.dart';

class CestaScreen extends StatefulWidget {
  const CestaScreen({
    super.key,
    required this.cesta,
    required this.onPedidoConfirmado,
  });

  final Cesta cesta;
  final ValueChanged<Pedido> onPedidoConfirmado;

  @override
  State<CestaScreen> createState() => _CestaScreenState();
}

class _CestaScreenState extends State<CestaScreen> {
  final _service = PedidoService();
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _telefone = TextEditingController();
  bool _enviando = false;
  String? _erro;

  @override
  void dispose() {
    _nome.dispose();
    _telefone.dispose();
    super.dispose();
  }

  Future<void> _confirmar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _enviando = true;
      _erro = null;
    });
    try {
      final pedido = await _service.criarPedido(
        cesta: widget.cesta,
        nome: _nome.text.trim(),
        telefone: _telefone.text.replaceAll(RegExp(r'\D'), ''),
      );
      if (!mounted) return;
      setState(() => _enviando = false);
      _nome.clear();
      _telefone.clear();
      widget.onPedidoConfirmado(pedido);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _erro = e.mensagem;
        _enviando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cesta = widget.cesta;
    final cores = Theme.of(context).colorScheme;
    if (cesta.vazia || cesta.feira == null) {
      return const Column(
        children: [
          CabecalhoTela(titulo: 'Sua cesta'),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Sua cesta está vazia.\nEscolha uma feira e coloque produtos nela.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      );
    }
    final feira = cesta.feira!;
    return Column(
      children: [
        CabecalhoTela(
          titulo: 'Sua cesta',
          subtitulo: 'Retirada na ${feira.praca} · ${feira.dia}',
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        for (final i in cesta.itens) ...[
                          _Linha(
                            '${i.quantidade}× ${i.oferta.nomeComUnidade}',
                            formatarMoeda(i.oferta.preco * i.quantidade),
                          ),
                          const Divider(height: 1),
                        ],
                        _Linha(
                          'Total',
                          formatarMoeda(cesta.total),
                          destaque: true,
                          cor: cores.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cores.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline_rounded, color: cores.primary),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Você paga só na retirada, em dinheiro ou Pix na barraca.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Seu nome',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nome,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Ex.: Maria',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().length < 2)
                      ? 'Escreva seu nome.'
                      : null,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Telefone (WhatsApp)',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _telefone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: '(11) 9 0000-0000',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final digitos = (v ?? '').replaceAll(RegExp(r'\D'), '');
                    return (digitos.length < 10 || digitos.length > 11)
                        ? 'Digite o telefone com DDD.'
                        : null;
                  },
                ),
                if (_erro != null) ...[
                  const SizedBox(height: 12),
                  Text(_erro!, style: TextStyle(color: cores.error)),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _enviando ? null : _confirmar,
              child: _enviando
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 3),
                    )
                  : const Text('Confirmar pré-pedido'),
            ),
          ),
        ),
      ],
    );
  }
}

class _Linha extends StatelessWidget {
  const _Linha(this.rotulo, this.valor, {this.destaque = false, this.cor});

  final String rotulo;
  final String valor;
  final bool destaque;
  final Color? cor;

  @override
  Widget build(BuildContext context) {
    final peso = destaque ? FontWeight.w800 : FontWeight.w600;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              rotulo,
              style: TextStyle(fontSize: destaque ? 18 : 16, fontWeight: peso),
            ),
          ),
          Text(
            valor,
            style: TextStyle(
              fontSize: destaque ? 22 : 16,
              fontWeight: FontWeight.w800,
              color: cor,
            ),
          ),
        ],
      ),
    );
  }
}
