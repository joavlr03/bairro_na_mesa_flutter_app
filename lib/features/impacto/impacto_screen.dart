import 'package:flutter/material.dart';

import '../../core/utils/formatadores.dart';
import '../../core/widgets/cabecalho_tela.dart';
import '../../core/widgets/estado_view.dart';
import '../../core/widgets/indicador_card.dart';
import '../../models/impacto.dart';
import '../../services/api_client.dart';
import '../../services/impacto_service.dart';

class ImpactoScreen extends StatefulWidget {
  const ImpactoScreen({super.key});

  @override
  State<ImpactoScreen> createState() => _ImpactoScreenState();
}

class _ImpactoScreenState extends State<ImpactoScreen> {
  final _service = ImpactoService();
  LoadStatus _status = LoadStatus.initial;
  Impacto? _impacto;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _status = LoadStatus.loading);
    try {
      final impacto = await _service.buscar();
      if (!mounted) return;
      setState(() {
        _impacto = impacto;
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CabecalhoTela(
          titulo: 'Impacto do Bairro na Mesa',
          subtitulo: 'Dados de exemplo · atualizados pela API',
        ),
        Expanded(
          child: EstadoView(
            status: _status,
            erro: _erro,
            onRetry: _carregar,
            vazio: _impacto == null,
            builder: (context) {
              final i = _impacto!;
              return RefreshIndicator(
                onRefresh: _carregar,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _Par(
                      IndicadorCard(
                        rotulo: 'Famílias atendidas',
                        valor: formatarMilhar(i.familiasAtendidas),
                        legenda: 'neste mês',
                      ),
                      IndicadorCard(
                        rotulo: 'Alimento vendido',
                        valor: '${formatarMilhar(i.kgVendidos)} kg',
                        legenda: 'direto do produtor',
                      ),
                    ),
                    const SizedBox(height: 12),
                    _Par(
                      IndicadorCard(
                        rotulo: 'Renda aos produtores',
                        valor: 'R\$ ${formatarMilhar(i.rendaProdutores)}',
                        legenda: 'sem atravessador',
                      ),
                      IndicadorCard(
                        rotulo: 'Desperdício evitado',
                        valor: '${formatarMilhar(i.kgDesperdicioEvitado)} kg',
                        legenda: 'colheita sob encomenda',
                      ),
                    ),
                    const SizedBox(height: 12),
                    IndicadorCard(
                      destaque: true,
                      rotulo: 'Benefícios solicitados a partir da triagem',
                      valor: formatarMilhar(i.beneficiosSolicitados),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Par extends StatelessWidget {
  const _Par(this.a, this.b);

  final Widget a;
  final Widget b;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: a),
          const SizedBox(width: 12),
          Expanded(child: b),
        ],
      ),
    );
  }
}
