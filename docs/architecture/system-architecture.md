# Arquitetura do sistema

## 1. Objetivo
Definir uma arquitetura simples para o aplicativo mobile Flutter/Dart **Bairro na Mesa** (perfil morador) que cumpra o enunciado da Global Solution 2026.2, favorecendo separação de responsabilidades, componentização, consumo REST, persistência local e manutenção.

## 2. Estilo arquitetural
Arquitetura em camadas leve, com organização por responsabilidade e agrupamento por funcionalidade quando o projeto crescer. Não adotar Clean Architecture completa ou múltiplos frameworks sem necessidade: a avaliação prioriza funcionamento, compreensão e boas práticas estudadas.

## 3. Camadas e responsabilidades

| Camada | Responsabilidade | Exemplos |
|---|---|---|
| Presentation | Telas, navegação, estado visual e interação | `screens/`, `widgets/` |
| Models | Representação e conversão dos dados | `models/` |
| Services | Comunicação HTTP e persistência local | `services/` |
| Core | Tema, rotas, constantes e componentes compartilhados | `core/` |

### Regras
- Widgets não devem conhecer detalhes de HTTP.
- Services não devem importar widgets nem controlar a interface.
- Models não devem depender de Flutter UI.
- `setState` atualiza o estado visual local conforme requisito acadêmico.
- Componentes reutilizáveis não devem conter regras de negócio específicas de uma tela.

## 4. Estrutura de `lib/`

```text
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   └── api_config.dart
│   ├── routes/
│   ├── theme/
│   │   └── app_theme.dart
│   └── widgets/
│       ├── estado_view.dart
│       └── indicador_card.dart
├── models/
│   ├── feira.dart
│   ├── oferta.dart
│   ├── cesta.dart
│   ├── pedido.dart
│   ├── mutirao.dart
│   ├── resultado_triagem.dart
│   └── impacto.dart
├── services/
│   ├── api_client.dart
│   ├── feira_service.dart
│   ├── pedido_service.dart
│   ├── mutirao_service.dart
│   ├── impacto_service.dart
│   └── onboarding_preferences_service.dart
└── features/
    ├── splash/
    ├── onboarding/
    ├── home/
    │   └── home_shell.dart
    ├── feiras/
    │   └── widgets/feira_card.dart
    ├── catalogo/
    │   └── widgets/produto_card.dart
    ├── cesta/
    ├── pedidos/
    ├── mutirao/
    └── impacto/
```

Não manter diretórios vazios.

## 4.1 Contexto do ecossistema
O app é um dos clientes da API Bairro na Mesa (Java 21 + Spring Boot, PostgreSQL + PostGIS, hospedada no Azure Container Apps). Distância das feiras, estoque e regras da triagem são calculados na API. O painel web e os perfis produtor/organizador não fazem parte deste app.

## 5. Inicialização
`main.dart` inicializa o Flutter e executa `app.dart`. `app.dart` configura `MaterialApp`, tema e rotas. A Splash consulta a preferência local e decide o próximo destino.

## 6. Integração remota
A tela solicita dados ao service. O service usa `http`, verifica a resposta, converte JSON em models e devolve dados ou erro tratável. A tela controla os estados `initial`, `loading`, `success` e `error` usando estado local (`setState`).

## 7. Persistência local
`SharedPreferences` guarda apenas `skipOnboarding`. Não utilizar como banco de dados para dados complexos ou sensíveis. A renda da triagem nunca é persistida.

## 7.1 Estado da cesta
A cesta é compartilhada entre Catálogo e Cesta. Ela fica em `HomeShell` (`StatefulWidget`) e é passada por parâmetro com callbacks; `HomeShell` chama `setState` ao alterar itens. Sem pacotes de gerenciamento de estado.

## 8. Navegação
Usar Navigator do Flutter. Para um aplicativo pequeno, `MaterialPageRoute` ou rotas nomeadas são suficientes. Definir uma única convenção e documentar os argumentos necessários. A tela de detalhes recebe um identificador ou objeto de domínio validado.

## 9. Segurança e robustez
- Não armazenar tokens/segredos no Git.
- Validar dados recebidos.
- Tratar falhas de rede, timeout, status HTTP e parsing.
- Evitar confiar em dados externos sem validação.
- Não registrar dados pessoais desnecessários em logs.

## 10. Decisões em aberto
- Base URL da API publicada.
- Origem da posição do morador (bairro/CEP escolhido ou `geolocator`).
- Como "Meus pedidos" recupera pedidos sem login (códigos locais ou busca por telefone).
- Confirmação do professor sobre a regra do onboarding.

Toda mudança estrutural deve ser registrada em `docs/architecture/decisions/` (criar a pasta quando a primeira decisão for documentada).
