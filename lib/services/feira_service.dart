import '../core/constants/api_config.dart';
import '../models/feira.dart';
import '../models/oferta.dart';
import 'api_client.dart';

class FeiraService {
  FeiraService({ApiClient? api}) : _api = api ?? ApiClient();

  final ApiClient _api;

  Future<List<Feira>> listarFeiras() async {
    final json = await _api.get(
      '/api/feiras',
      query: {'lat': '${ApiConfig.latitude}', 'lng': '${ApiConfig.longitude}'},
    );
    final feiras = (json as List<dynamic>)
        .map((e) => Feira.fromJson(e as Map<String, dynamic>))
        .toList();
    feiras.sort(
      (a, b) => (a.distanciaKm ?? double.infinity).compareTo(
        b.distanciaKm ?? double.infinity,
      ),
    );
    return feiras;
  }

  /// [categoria] nula = todas.
  Future<List<Oferta>> listarOfertas(int feiraId, {String? categoria}) async {
    final json = await _api.get(
      '/api/feiras/$feiraId/ofertas',
      query: categoria == null ? null : {'categoria': categoria},
    );
    return (json as List<dynamic>)
        .map((e) => Oferta.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
