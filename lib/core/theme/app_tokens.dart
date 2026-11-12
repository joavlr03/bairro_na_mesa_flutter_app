// Gerado a partir de design-system/tokens.json. Não edite à mão: atualize o tokens.json e regenere.
import 'package:flutter/material.dart';

/// Paleta do Bairro na Mesa (tema claro e escuro).
class AppColors {
  const AppColors._({
    required this.verdeHorta,
    required this.verdeHortaForte,
    required this.verdeMata,
    required this.verdeBroto,
    required this.terraTijolo,
    required this.terraTexto,
    required this.milho,
    required this.milhoClaro,
    required this.creme100,
    required this.creme200,
    required this.creme300,
    required this.tinta,
    required this.tintaSuave,
    required this.linha,
    required this.linhaCampo,
    required this.sucesso,
    required this.erro,
    required this.info,
    required this.foco,
  });

  /// Cor principal da marca. Botões primários, links, preço, destaques. Contraste 4,6:1 sobre creme-100 (claro) e 8,9:1 sobre creme-100 (escuro).
  final Color verdeHorta;

  /// Hover e pressionado de elementos verde-horta; texto verde em tamanho pequeno (6,4:1 sobre creme-100).
  final Color verdeHortaForte;

  /// Fundos escuros de marca: rodapé, faixas de evento, barra da feira. Texto em creme-100 ou milho por cima.
  final Color verdeMata;

  /// Fundo suave: cartão selecionado, chip de categoria, bloco de confirmação de pedido.
  final Color verdeBroto;

  /// Cor do telhado no logo. Formas, ilustrações, selos e etiquetas com texto em negrito ≥19px. Não usar em texto pequeno sobre creme (3,8:1).
  final Color terraTijolo;

  /// Versão acessível da terra para texto e ícones pequenos: destaque do Mutirão Cidadão, links secundários (5,1:1 sobre creme-100).
  final Color terraTexto;

  /// Destaques de atenção positiva: selo 'pode ter direito', badge de novidade, CTA sobre fundo verde. Texto sempre em tinta por cima (8,1:1).
  final Color milho;

  /// Fundo de avisos e dicas (ex.: 'leve RG e CPF').
  final Color milhoClaro;

  /// Fundo de página. É o 'papel kraft' da marca, nunca branco puro como fundo principal.
  final Color creme100;

  /// Superfície de cartões, folhas e campos de formulário.
  final Color creme200;

  /// Superfície rebaixada: barra de busca, área de filtros, linha zebrada.
  final Color creme300;

  /// Texto principal e títulos (13,6:1 sobre creme-100). Mesa do logo.
  final Color tinta;

  /// Texto secundário, legendas, metadados (5,5:1 sobre creme-100).
  final Color tintaSuave;

  /// Bordas finas de cartão, divisórias. Decorativa: não usar como única borda de campo.
  final Color linha;

  /// Borda de campos de formulário e controles (3:1 sobre creme-200).
  final Color linhaCampo;

  /// Pedido confirmado, retirada concluída.
  final Color sucesso;

  /// Erros de formulário e falhas (6,1:1 sobre creme-100). Sempre com ícone e texto, nunca só cor.
  final Color erro;

  /// Mensagens informativas neutras (horários, avisos do organizador).
  final Color info;

  /// Anel de foco de teclado, 2px com 2px de afastamento.
  final Color foco;

  static const claro = AppColors._(
    verdeHorta: Color(0xFF2F7D4F),
    verdeHortaForte: Color(0xFF246640),
    verdeMata: Color(0xFF173D28),
    verdeBroto: Color(0xFFE3F1E7),
    terraTijolo: Color(0xFFD2572B),
    terraTexto: Color(0xFFB4461C),
    milho: Color(0xFFF2B630),
    milhoClaro: Color(0xFFFDF0CC),
    creme100: Color(0xFFFBF5EA),
    creme200: Color(0xFFFFFFFF),
    creme300: Color(0xFFF1E8D8),
    tinta: Color(0xFF1E2B23),
    tintaSuave: Color(0xFF5C665F),
    linha: Color(0xFFE2D7C4),
    linhaCampo: Color(0xFF8A8F84),
    sucesso: Color(0xFF2F7D4F),
    erro: Color(0xFFB42318),
    info: Color(0xFF1F6F8B),
    foco: Color(0xFF1F6F8B),
  );

  static const escuro = AppColors._(
    verdeHorta: Color(0xFF6FCB93),
    verdeHortaForte: Color(0xFF8BD9A9),
    verdeMata: Color(0xFF0F2A1C),
    verdeBroto: Color(0xFF1F3A2A),
    terraTijolo: Color(0xFFF07A4B),
    terraTexto: Color(0xFFF59A73),
    milho: Color(0xFFF2B630),
    milhoClaro: Color(0xFF3A2F12),
    creme100: Color(0xFF141B17),
    creme200: Color(0xFF1C2620),
    creme300: Color(0xFF26322B),
    tinta: Color(0xFFF3EDE2),
    tintaSuave: Color(0xFFA9B3AC),
    linha: Color(0xFF34433A),
    linhaCampo: Color(0xFF7A867E),
    sucesso: Color(0xFF6FCB93),
    erro: Color(0xFFF97066),
    info: Color(0xFF7CC4DD),
    foco: Color(0xFF7CC4DD),
  );
}

/// Espaçamentos (px lógicos).
class AppSpacing {
  static const double espaco1 = 4; // Entre ícone e texto.
  static const double espaco2 =
      8; // Entre itens de um grupo (chips, linhas de lista compacta).
  static const double espaco3 = 12; // Padding vertical de botões e campos.
  static const double espaco4 =
      16; // Padding de cartões e margem lateral do app.
  static const double espaco6 = 24; // Entre cartões e blocos de conteúdo.
  static const double espaco8 = 32; // Entre seções de uma tela.
  static const double espaco12 =
      48; // Respiro de capas, faixas e topo de telas de boas-vindas.
}

/// Raios de borda.
class AppRadius {
  static const double raioP = 8; // Chips, campos, miniaturas.
  static const double raioM =
      14; // Cartões de produto, de feira e de atendimento.
  static const double raioG =
      24; // Folhas inferiores, banners, ícone do app (proporcional).
  static const double raioPilula =
      999; // Botões e selos: ecoa as pontas arredondadas do símbolo.
}

/// Altura mínima de qualquer área tocável.
const double kAlvoToque = 48;
