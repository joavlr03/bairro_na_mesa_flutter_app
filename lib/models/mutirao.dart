/// Um atendimento disponível no mutirão da feira.
class Mutirao {
  const Mutirao({required this.id, required this.horario, required this.tipo});

  final int id;
  final String horario;
  final String tipo;

  factory Mutirao.fromJson(Map<String, dynamic> json) => Mutirao(
    id: json['id'] as int,
    horario: json['horario'] as String,
    tipo: json['tipo'] as String,
  );

  /// "09:00" -> "9h00" (como no mockup).
  String get horarioFormatado {
    final partes = horario.split(':');
    final h = int.tryParse(partes.first) ?? 0;
    return '${h}h${partes.length > 1 ? partes[1] : '00'}';
  }
}
