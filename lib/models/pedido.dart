import 'feira.dart';

class Pedido {
  const Pedido({
    required this.codigo,
    required this.total,
    required this.status,
    this.praca,
    this.quando,
  });

  final String codigo;
  final double total;
  final String status;
  final String? praca;
  final String? quando;

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
    codigo: json['codigo'] as String,
    total: (json['total'] as num).toDouble(),
    status: json['status'] as String,
    praca: json['praca'] as String?,
    quando: json['quando'] as String?,
  );

  /// A resposta do POST traz só código/total/status; completa com a feira.
  Pedido comFeira(Feira feira) => Pedido(
    codigo: codigo,
    total: total,
    status: status,
    praca: feira.praca,
    quando: feira.quando,
  );

  String get statusLegivel => switch (status) {
    'AGUARDANDO_RETIRADA' => 'Aguardando retirada',
    'RETIRADO' => 'Retirado',
    'CANCELADO' => 'Cancelado',
    _ => status,
  };
}
