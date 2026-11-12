import 'package:bairro_na_mesa/models/cesta.dart';
import 'package:bairro_na_mesa/models/feira.dart';
import 'package:bairro_na_mesa/models/oferta.dart';
import 'package:flutter_test/flutter_test.dart';

Feira _feira(int id) => Feira(
  id: id,
  praca: 'P$id',
  bairro: 'B',
  diaSemana: 'SABADO',
  horarioInicio: '08:00',
  horarioFim: '13:00',
  temMutirao: false,
);

const _alface = Oferta(
  id: 10,
  produto: 'Alface',
  categoria: 'VERDURAS',
  unidade: 'maço',
  preco: 2.5,
  estoque: 2,
);

void main() {
  test('soma itens e total, respeita estoque', () {
    final cesta = Cesta();
    cesta.adicionar(_feira(1), _alface);
    cesta.adicionar(_feira(1), _alface);
    cesta.adicionar(_feira(1), _alface); // acima do estoque: ignorado
    expect(cesta.totalItens, 2);
    expect(cesta.total, 5.0);
  });

  test('remover até zero esvazia a cesta; outra feira zera a anterior', () {
    final cesta = Cesta();
    cesta.adicionar(_feira(1), _alface);
    cesta.remover(_alface);
    expect(cesta.vazia, isTrue);
    cesta.adicionar(_feira(1), _alface);
    cesta.adicionar(_feira(2), _alface);
    expect(cesta.totalItens, 1);
    expect(cesta.feira?.id, 2);
  });
}
