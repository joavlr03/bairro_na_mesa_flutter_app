import '../core/utils/formatadores.dart';

class Feira {
  const Feira({
    required this.id,
    required this.praca,
    required this.bairro,
    required this.diaSemana,
    required this.horarioInicio,
    required this.horarioFim,
    required this.temMutirao,
    this.distanciaKm,
  });

  final int id;
  final String praca;
  final String bairro;
  final String diaSemana;
  final String horarioInicio;
  final String horarioFim;
  final bool temMutirao;
  final double? distanciaKm;

  factory Feira.fromJson(Map<String, dynamic> json) => Feira(
    id: json['id'] as int,
    praca: json['praca'] as String,
    bairro: json['bairro'] as String,
    diaSemana: json['diaSemana'] as String,
    horarioInicio: json['horarioInicio'] as String,
    horarioFim: json['horarioFim'] as String,
    temMutirao: json['temMutirao'] as bool? ?? false,
    distanciaKm: (json['distanciaKm'] as num?)?.toDouble(),
  );

  /// "SABADO" -> "Sábado".
  String get dia => switch (diaSemana) {
    'SEGUNDA' => 'Segunda',
    'TERCA' => 'Terça',
    'QUARTA' => 'Quarta',
    'QUINTA' => 'Quinta',
    'SEXTA' => 'Sexta',
    'SABADO' => 'Sábado',
    'DOMINGO' => 'Domingo',
    _ => diaSemana,
  };

  /// Dia da semana no padrão de DateTime.weekday (segunda = 1 … domingo = 7).
  int get diaDaSemanaNumero => switch (diaSemana) {
    'SEGUNDA' => DateTime.monday,
    'TERCA' => DateTime.tuesday,
    'QUARTA' => DateTime.wednesday,
    'QUINTA' => DateTime.thursday,
    'SEXTA' => DateTime.friday,
    'SABADO' => DateTime.saturday,
    _ => DateTime.sunday,
  };

  /// "Sábado · 8h às 13h".
  String get quando =>
      '$dia · ${formatarHora(horarioInicio)} às ${formatarHora(horarioFim)}';
}
