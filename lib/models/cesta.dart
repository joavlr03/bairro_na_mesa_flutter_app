import 'feira.dart';
import 'oferta.dart';

/// Cesta do morador. Pertence a uma única feira; adicionar item de outra feira
/// esvazia a cesta anterior. Mutável de propósito: quem a altera (HomeShell)
/// chama setState.
class Cesta {
  Feira? feira;
  final Map<int, ({Oferta oferta, int quantidade})> _itens = {};

  Iterable<({Oferta oferta, int quantidade})> get itens => _itens.values;
  int get totalItens => _itens.values.fold(0, (s, i) => s + i.quantidade);
  double get total =>
      _itens.values.fold(0, (s, i) => s + i.oferta.preco * i.quantidade);
  bool get vazia => _itens.isEmpty;

  int quantidadeDe(Oferta oferta) => _itens[oferta.id]?.quantidade ?? 0;

  void adicionar(Feira daFeira, Oferta oferta) {
    if (feira?.id != daFeira.id) {
      _itens.clear();
      feira = daFeira;
    }
    final atual = quantidadeDe(oferta);
    if (atual >= oferta.estoque) return;
    _itens[oferta.id] = (oferta: oferta, quantidade: atual + 1);
  }

  void remover(Oferta oferta) {
    final atual = quantidadeDe(oferta);
    if (atual <= 1) {
      _itens.remove(oferta.id);
    } else {
      _itens[oferta.id] = (oferta: oferta, quantidade: atual - 1);
    }
    if (_itens.isEmpty) feira = null;
  }

  void limpar() {
    _itens.clear();
    feira = null;
  }
}
