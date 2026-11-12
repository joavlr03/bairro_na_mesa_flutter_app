# Bairro na Mesa — Global Solution 2026.2

> Aplicativo desenvolvido em Flutter e Dart para a Global Solution 2026.2 – CitizenTech.

## 1. Identificação dos desenvolvedores

| Nome completo | RM |
|---|---|
| João Victor Oliveira Avellar | 550283 |

Turma: 3SIR

## 2. Descrição da solução

O Bairro na Mesa transforma praças da periferia em pontos semanais de comida acessível e cidadania. Pelo app, o morador encontra a feira de agricultores familiares mais próxima, monta a cesta com pré-pedido, descobre benefícios sociais a que pode ter direito e retira tudo na praça, onde também acontece um mutirão de atendimento (CadÚnico, Tarifa Social, documentos).

**Problema:** comida fresca é cara e rara na periferia; o pequeno produtor depende de atravessadores e desperdiça colheita; muitas famílias não acessam direitos que já têm por falta de informação.

**Público-alvo do app:** famílias de baixa renda da periferia, com pouca familiaridade digital.

## 3. Tema da Global Solution

- **Tema oficial:** CitizenTech
- **Problema abordado:** insegurança alimentar, baixa renda do pequeno produtor e falta de acesso a benefícios sociais no mesmo território
- **Objetivo da solução:** usar a praça do bairro como ponto de encontro entre quem produz, quem precisa comer e os direitos de cada cidadão
- **ODS:** 2 (Fome zero), 10 (Redução das desigualdades), 11 (Cidades sustentáveis), 12 (Consumo responsável); ODS 1 como complemento

## 4. Funcionalidades

- Lista de feiras próximas, ordenadas por distância
- Catálogo da semana com filtro por categoria
- Cesta e pré-pedido (pagamento na retirada)
- Meus pedidos com QR code de retirada
- Agenda do mutirão e triagem simples de benefícios
- Painel de impacto (famílias atendidas, kg vendidos, desperdício evitado)

## 5. Tecnologias

- Flutter 3.44.1
- Dart
- `http` para consumo da API REST
- `shared_preferences` para a preferência do onboarding
- `qr_flutter` para exibir o QR do pedido
- API Bairro na Mesa (Java 21 + Spring Boot, PostgreSQL + PostGIS, Azure)

## 6. Fluxo de telas

`Splash → Onboarding (só na primeira vez) → Feiras → Catálogo da feira → Cesta → Meus pedidos → QR de retirada`

Telas principais (navegação inferior):
1. Feiras
2. Cesta
3. Meus pedidos
4. Mutirão e Triagem
5. Impacto

Tela de detalhes: Catálogo da feira (aberta a partir da lista de feiras).


## 7. API / WebService

- **Nome:** API Bairro na Mesa (própria do projeto)
- **Documentação:** [PREENCHER – URL do Swagger após o deploy]
- **Endpoint(s) consumido(s):** `GET /api/feiras`, `GET /api/feiras/{id}/ofertas`, `POST /api/pedidos`, `GET /api/pedidos/{codigo}`, `GET /api/feiras/{id}/mutiroes`, `POST /api/triagem`, `GET /api/impacto`
- **Dados exibidos:** feiras, produtos da semana, pedidos, agenda do mutirão, resultado da triagem e indicadores
- **Tratamento de estados:** inicial, carregamento, sucesso e erro, com opção de tentar novamente.


## 8. Arquitetura

O aplicativo separa interface (features), modelos, serviços e componentes reutilizáveis, com estado gerenciado por `setState`. A estrutura detalhada e as decisões técnicas estão em [`docs/architecture/system-architecture.md`](docs/architecture/system-architecture.md).

## 9. Como executar (Windows 11)

### Pré-requisitos
- Flutter SDK 3.44.1 (Dart incluído).
- Android Studio ou VS Code com emulador Android configurado.

### Instalação (PowerShell)
```powershell
flutter doctor
flutter pub get
```

### Configurar a API
Editar a base URL em `lib/core/constants/api_config.dart`:
- API publicada: [PREENCHER]
- Mock local no emulador Android: `http://10.0.2.2:3000`

### Execução
```powershell
flutter run
```

### Testes e validação
```powershell
flutter analyze
flutter test
flutter build apk --debug
```

## 10. Capturas de tela

Adicionar imagens reais da versão executável em `docs/delivery/screenshots/` e referenciá-las abaixo.

| Tela | Captura |
|---|---|
| Splash | [Adicionar imagem] |
| Onboarding | [Adicionar imagem] |
| Feiras | [Adicionar imagem] |
| Catálogo da feira | [Adicionar imagem] |
| Cesta | [Adicionar imagem] |
| Meus pedidos / QR | [Adicionar imagem] |
| Mutirão e Triagem | [Adicionar imagem] |
| Impacto | [Adicionar imagem] |

## 11. Vídeo pitch

[Inserir link do vídeo pitch conforme as orientações da Global Solution.]

## 12. Integridade acadêmica

A implementação, as decisões e a documentação refletem o trabalho efetivamente realizado pelo integrante. Dados de feiras e produtores usados na demonstração são fictícios. Toda dependência, API, imagem ou recurso externo respeita sua licença e é identificado quando aplicável.



## Rodando com o mock da API

```bash
node mock/server.js          # http://localhost:3000, dados fictícios
flutter run                  # emulador Android usa 10.0.2.2:3000
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:3000
```
