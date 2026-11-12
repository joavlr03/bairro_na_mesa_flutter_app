class Beneficio {
  const Beneficio({
    required this.nome,
    required this.mensagem,
    required this.documentos,
  });

  final String nome;
  final String mensagem;
  final List<String> documentos;

  factory Beneficio.fromJson(Map<String, dynamic> json) => Beneficio(
    nome: json['nome'] as String,
    mensagem: json['mensagem'] as String,
    documentos: (json['documentos'] as List<dynamic>? ?? const [])
        .cast<String>(),
  );
}

class ResultadoTriagem {
  const ResultadoTriagem(this.beneficios);

  final List<Beneficio> beneficios;

  factory ResultadoTriagem.fromJson(Map<String, dynamic> json) =>
      ResultadoTriagem(
        (json['beneficios'] as List<dynamic>)
            .map((e) => Beneficio.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
