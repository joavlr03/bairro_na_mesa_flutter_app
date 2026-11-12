import '../models/mutirao.dart';
import '../models/resultado_triagem.dart';
import 'api_client.dart';

class MutiraoService {
  MutiraoService({ApiClient? api}) : _api = api ?? ApiClient();

  final ApiClient _api;

  Future<List<Mutirao>> listarAtendimentos(int feiraId) async {
    final json = await _api.get('/api/feiras/$feiraId/mutiroes');
    return (json as List<dynamic>)
        .map((e) => Mutirao.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// A renda segue só para o cálculo: não é guardada nem registrada em log (LGPD).
  Future<ResultadoTriagem> triar({
    required int pessoasNaCasa,
    required double rendaFamiliar,
    required bool temCadUnico,
  }) async {
    final json = await _api.post('/api/triagem', {
      'pessoasNaCasa': pessoasNaCasa,
      'rendaFamiliar': rendaFamiliar,
      'temCadUnico': temCadUnico,
    });
    return ResultadoTriagem.fromJson(json as Map<String, dynamic>);
  }
}
