class Oferta {
  const Oferta({
    required this.id,
    required this.produto,
    required this.categoria,
    required this.unidade,
    required this.preco,
    required this.estoque,
    this.produtor,
    this.fotoUrl,
  });

  final int id;
  final String produto;
  final String categoria;
  final String unidade;
  final double preco;
  final int estoque;
  final String? produtor;
  final String? fotoUrl;

  factory Oferta.fromJson(Map<String, dynamic> json) => Oferta(
    id: json['id'] as int,
    produto: json['produto'] as String,
    categoria: json['categoria'] as String,
    unidade: json['unidade'] as String,
    preco: (json['preco'] as num).toDouble(),
    estoque: (json['estoque'] as num).toInt(),
    produtor: json['produtor'] as String?,
    fotoUrl: json['fotoUrl'] as String?,
  );

  bool get esgotado => estoque <= 0;

  /// "Alface crespa (maço)".
  String get nomeComUnidade => '$produto ($unidade)';
}
