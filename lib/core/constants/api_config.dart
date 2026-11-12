/// Base URL da API. Trocar mock/Azure alterando apenas este valor
/// (ou via --dart-define=API_BASE_URL=...). Nada de segredos aqui.
class ApiConfig {
  // 10.0.2.2 = localhost da máquina vista pelo emulador Android.
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );
  static const timeout = Duration(seconds: 10);

  // Posição provisória do morador (centro de SP) até decidir bairro/CEP ou
  // geolocator — decisão em aberto em docs/architecture/system-architecture.md.
  static const latitude = -23.55;
  static const longitude = -46.63;
}
