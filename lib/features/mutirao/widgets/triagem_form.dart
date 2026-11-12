import 'package:flutter/material.dart';

import '../../../models/resultado_triagem.dart';
import '../../../services/api_client.dart';
import '../../../services/mutirao_service.dart';

/// Formulário da triagem. A renda só existe no controller: é enviada para o
/// cálculo e apagada em seguida; nunca é guardada nem registrada em log (LGPD).
class TriagemForm extends StatefulWidget {
  const TriagemForm({
    super.key,
    required this.service,
    required this.onResultado,
  });

  final MutiraoService service;
  final ValueChanged<ResultadoTriagem> onResultado;

  @override
  State<TriagemForm> createState() => _TriagemFormState();
}

class _TriagemFormState extends State<TriagemForm> {
  final _formKey = GlobalKey<FormState>();
  final _pessoas = TextEditingController();
  final _renda = TextEditingController();
  bool _temCadUnico = false;
  bool _enviando = false;
  String? _erro;

  @override
  void dispose() {
    _pessoas.dispose();
    _renda.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _enviando = true;
      _erro = null;
    });
    try {
      final resultado = await widget.service.triar(
        pessoasNaCasa: int.parse(_pessoas.text.trim()),
        rendaFamiliar: double.parse(_renda.text.trim().replaceAll(',', '.')),
        temCadUnico: _temCadUnico,
      );
      if (!mounted) return;
      _renda.clear();
      setState(() => _enviando = false);
      widget.onResultado(resultado);
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
    final cores = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Descubra seus direitos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pessoas,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Pessoas na sua casa',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final n = int.tryParse((v ?? '').trim());
                  return (n == null || n < 1) ? 'Digite um número.' : null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _renda,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Renda total da família por mês (R\$)',
                  helperText: 'Não guardamos esse valor.',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final n = double.tryParse(
                    (v ?? '').trim().replaceAll(',', '.'),
                  );
                  return (n == null || n < 0) ? 'Digite um valor.' : null;
                },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Já tenho CadÚnico'),
                value: _temCadUnico,
                onChanged: (v) => setState(() => _temCadUnico = v),
              ),
              if (_erro != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(_erro!, style: TextStyle(color: cores.error)),
                ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _enviando ? null : _enviar,
                  child: _enviando
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        )
                      : const Text('Ver o que posso ter direito'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
