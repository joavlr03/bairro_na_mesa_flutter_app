import 'package:flutter/material.dart';

import '../../core/widgets/cabecalho_tela.dart';
import '../../core/widgets/estado_view.dart';
import '../../models/feira.dart';
import '../../models/mutirao.dart';
import '../../models/resultado_triagem.dart';
import '../../services/api_client.dart';
import '../../services/feira_service.dart';
import '../../services/mutirao_service.dart';
import 'widgets/triagem_form.dart';

/// Agenda do mutirão + triagem. [feira] é a última feira aberta pelo morador;
/// sem ela, usa a feira mais próxima que tem mutirão.
class MutiraoScreen extends StatefulWidget {
  const MutiraoScreen({super.key, this.feira});

  final Feira? feira;

  @override
  State<MutiraoScreen> createState() => _MutiraoScreenState();
}

class _MutiraoScreenState extends State<MutiraoScreen> {
  final _feiraService = FeiraService();
  final _service = MutiraoService();
  LoadStatus _status = LoadStatus.initial;
  Feira? _feira;
  List<Mutirao> _atendimentos = const [];
  String? _erro;
  ResultadoTriagem? _resultado;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void didUpdateWidget(MutiraoScreen antigo) {
    super.didUpdateWidget(antigo);
    final nova = widget.feira;
    if (nova != null && nova.id != _feira?.id) _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _status = LoadStatus.loading);
    try {
      var feira = widget.feira;
      if (feira == null) {
        final feiras = await _feiraService.listarFeiras();
        feira = feiras.where((f) => f.temMutirao).firstOrNull;
      }
      final atendimentos = feira == null
          ? const <Mutirao>[]
          : await _service.listarAtendimentos(feira.id);
      if (!mounted) return;
      setState(() {
        _feira = feira;
        _atendimentos = atendimentos;
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
    final feira = _feira;
    return Column(
      children: [
        CabecalhoTela(
          titulo: 'Mutirão e Triagem',
          cor: Theme.of(context).colorScheme.secondary,
          subtitulo: feira == null ? null : '${feira.praca} · ${feira.dia}',
        ),
        Expanded(
          child: EstadoView(
            status: _status,
            erro: _erro,
            onRetry: _carregar,
            builder: (context) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TriagemForm(
                  service: _service,
                  onResultado: (r) => setState(() => _resultado = r),
                ),
                if (_resultado != null) ...[
                  const SizedBox(height: 16),
                  _ResultadoCard(resultado: _resultado!),
                ],
                const SizedBox(height: 20),
                _Agenda(feira: feira, atendimentos: _atendimentos),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultadoCard extends StatelessWidget {
  const _ResultadoCard({required this.resultado});

  final ResultadoTriagem resultado;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resultado da sua triagem',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cores.tertiary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline_rounded, color: cores.onTertiary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      resultado.beneficios.isEmpty
                          ? 'Com essas respostas não encontramos benefícios. Procure o CRAS do seu bairro para confirmar.'
                          : 'Você pode ter direito. Confirme no CRAS ou no mutirão levando os documentos abaixo.',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: cores.onTertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (final b in resultado.beneficios) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: cores.outlineVariant),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      b.nome,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: cores.secondary,
                      ),
                    ),
                    Text(b.mensagem),
                    if (b.documentos.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Leve: ${b.documentos.join(', ')}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Agenda extends StatefulWidget {
  const _Agenda({required this.feira, required this.atendimentos});

  final Feira? feira;
  final List<Mutirao> atendimentos;

  @override
  State<_Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<_Agenda> {
  // Agendamento só de demonstração: fica na tela, não chama a API.
  final Map<int, DateTime> _agendados = {};

  /// Calendário só com os dias em que a feira acontece.
  Future<void> _agendar(Mutirao atendimento) async {
    final feira = widget.feira!;
    final hoje = DateUtils.dateOnly(DateTime.now());
    var inicial = hoje;
    while (inicial.weekday != feira.diaDaSemanaNumero) {
      inicial = inicial.add(const Duration(days: 1));
    }
    final data = await showDatePicker(
      context: context,
      initialDate: inicial,
      firstDate: hoje,
      lastDate: hoje.add(const Duration(days: 90)),
      helpText: 'Escolha o dia',
      cancelText: 'Cancelar',
      confirmText: 'Agendar',
      selectableDayPredicate: (d) => d.weekday == feira.diaDaSemanaNumero,
    );
    if (data == null || !mounted) return;
    setState(() => _agendados[atendimento.id] = data);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Agendado! ${atendimento.tipo}, '
          '${MaterialLocalizations.of(context).formatShortDate(data)} '
          'às ${atendimento.horarioFormatado}.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;
    final feira = widget.feira;
    if (feira == null || widget.atendimentos.isEmpty) {
      return Text(
        'Nenhum atendimento do mutirão por perto esta semana.',
        style: tema.textTheme.bodyLarge,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Atendimentos neste ${feira.dia.toLowerCase()}',
          style: tema.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        for (final a in widget.atendimentos)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 64,
                      child: Text(
                        a.horarioFormatado,
                        style: tema.textTheme.titleLarge?.copyWith(
                          fontSize: 17,
                          color: cores.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(a.tipo, style: tema.textTheme.bodyLarge),
                    ),
                    if (_agendados.containsKey(a.id))
                      OutlinedButton.icon(
                        onPressed: () => _agendar(a), // trocar a data
                        icon: const Icon(Icons.check_rounded),
                        label: const Text('Agendado!'),
                      )
                    else
                      FilledButton(
                        onPressed: () => _agendar(a),
                        child: const Text('Agendar'),
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
