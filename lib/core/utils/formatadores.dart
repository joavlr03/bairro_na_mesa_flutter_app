String formatarMoeda(double valor) =>
    'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';

String formatarKm(double km) =>
    '${km.toStringAsFixed(1).replaceAll('.', ',')} km';

/// "08:00" -> "8h"; "09:30" -> "9h30".
String formatarHora(String hhmm) {
  final partes = hhmm.split(':');
  final h = int.tryParse(partes.first) ?? 0;
  final m = partes.length > 1 ? int.tryParse(partes[1]) ?? 0 : 0;
  return m == 0 ? '${h}h' : '${h}h${m.toString().padLeft(2, '0')}';
}

/// 8450 -> "8.450".
String formatarMilhar(num valor) {
  final inteiro = valor.round().toString();
  return inteiro.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.');
}
