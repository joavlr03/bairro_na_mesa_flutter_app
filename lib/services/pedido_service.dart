import '../models/cesta.dart';
import '../models/pedido.dart';
import 'api_client.dart';

class PedidoService {
  PedidoService({ApiClient? api}) : _api = api ?? ApiClient();

  final ApiClient _api;

  Future<Pedido> criarPedido({
    required Cesta cesta,
    required String nome,
    required String telefone,
  }) async {
    final feira = cesta.feira;
    if (feira == null || cesta.vazia) {
      throw const ApiException('Sua cesta está vazia.');
    }
    final json = await _api.post('/api/pedidos', {
      'feiraId': feira.id,
      'nome': nome,
      'telefone': telefone,
      'itens': [
        for (final i in cesta.itens)
          {'ofertaId': i.oferta.id, 'quantidade': i.quantidade},
      ],
    });
    return Pedido.fromJson(json as Map<String, dynamic>).comFeira(feira);
  }
}
