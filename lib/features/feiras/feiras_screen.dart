import 'package:flutter/material.dart';

import '../../core/widgets/cabecalho_tela.dart';
import '../../core/widgets/estado_view.dart';
import '../../models/feira.dart';
import '../../services/api_client.dart';
import '../../services/feira_service.dart';
import 'widgets/feira_card.dart';

class FeirasScreen extends StatefulWidget {
  const FeirasScreen({super.key, required this.onAbrirFeira});

  final ValueChanged<Feira> onAbrirFeira;

  @override
  State<FeirasScreen> createState() => _FeirasScreenState();
}

class _FeirasScreenState extends State<FeirasScreen> {
  final _service = FeiraService();
  LoadStatus _status = LoadStatus.initial;
  List<Feira> _feiras = const [];
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _status = LoadStatus.loading);
    try {
      final feiras = await _service.listarFeiras();
      if (!mounted) return;
      setState(() {
        _feiras = feiras;
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
        CabecalhoTela(
          titulo: 'Feiras perto de você',
          subtitulo: _feiras.isEmpty ? null : 'Bairro: ${_feiras.first.bairro}',
        ),
        Expanded(
          child: EstadoView(
            status: _status,
            erro: _erro,
            onRetry: _carregar,
            vazio: _feiras.isEmpty,
            mensagemVazio: 'Nenhuma feira por perto ainda',
            builder: (context) => RefreshIndicator(
              onRefresh: _carregar,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _feiras.length + 1,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return Text(
                      '${_feiras.length} feiras nesta semana · da mais perto para a mais longe',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    );
                  }
                  final feira = _feiras[i - 1];
                  return FeiraCard(
                    feira: feira,
                    onTap: () => widget.onAbrirFeira(feira),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
