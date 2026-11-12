class Impacto {
  const Impacto({
    required this.familiasAtendidas,
    required this.kgVendidos,
    required this.rendaProdutores,
    required this.kgDesperdicioEvitado,
    required this.beneficiosSolicitados,
  });

  final int familiasAtendidas;
  final double kgVendidos;
  final double rendaProdutores;
  final double kgDesperdicioEvitado;
  final int beneficiosSolicitados;

  factory Impacto.fromJson(Map<String, dynamic> json) => Impacto(
    familiasAtendidas: (json['familiasAtendidas'] as num).toInt(),
    kgVendidos: (json['kgVendidos'] as num).toDouble(),
    rendaProdutores: (json['rendaProdutores'] as num).toDouble(),
    kgDesperdicioEvitado: (json['kgDesperdicioEvitado'] as num).toDouble(),
    beneficiosSolicitados: (json['beneficiosSolicitados'] as num).toInt(),
  );
}
