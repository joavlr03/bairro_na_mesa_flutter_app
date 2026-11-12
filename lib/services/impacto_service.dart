import '../models/impacto.dart';
import 'api_client.dart';

class ImpactoService {
  ImpactoService({ApiClient? api}) : _api = api ?? ApiClient();

  final ApiClient _api;

  Future<Impacto> buscar() async {
    final json = await _api.get('/api/impacto');
    return Impacto.fromJson(json as Map<String, dynamic>);
  }
}
