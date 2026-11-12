# Contexto do projeto

> Fonte de verdade do domínio: `../Bairro na Mesa – Resumo do Projeto (GS 2026.2).md` (raiz da pasta do projeto). Este arquivo recorta o que importa para o **app Flutter**.

## Identificação
- Nome do aplicativo: **Bairro na Mesa**
- Repositório: [URL – repositório ainda será criado]
- Disciplina/turma: [PREENCHER]
- Global Solution: **2026.2 – CitizenTech**
- Integrantes: João Victor Oliveira Avellar – RM 550283 (equipe de 1 pessoa; responsável por back-end, front e infra/produto)
- Prazo: software no ar até **17/11/2026**; entrega do pitch e do projeto em **19/11/2026 até 23h55**. Primeira versão na nuvem até **13/11/2026**.

## Problema e proposta
- **Problema real abordado:** na periferia, três problemas acontecem no mesmo território e não se conversam: comida fresca é cara e rara (desertos alimentares); o pequeno produtor depende de atravessadores e desperdiça colheita; muitas famílias não acessam benefícios a que têm direito (Bolsa Família, Tarifa Social, CadÚnico) por falta de informação, documentos ou tempo.
- **Público-alvo do app Flutter:** morador de baixa renda da periferia, com pouca familiaridade digital (persona: **Dona Maria**).
- **Proposta de valor:** a praça do bairro como ponto de encontro entre quem produz, quem precisa comer e os direitos de cada cidadão. O morador encontra a feira mais próxima, faz o pré-pedido da cesta, descobre benefícios a que pode ter direito e retira tudo na praça.
- **Cenário principal de uso (Dona Maria):** vê que no sábado há feira a duas quadras → monta a cesta e faz o pré-pedido → na triagem descobre que pode ter direito à Tarifa Social e recebe a lista de documentos → no sábado retira a cesta mostrando o QR code e é atendida no mutirão.

## Módulos da solução e o que entra no app Flutter
| Módulo | No app Flutter (morador) | Fora do app Flutter |
|---|---|---|
| Feira na Praça | Lista de feiras por distância, catálogo da semana, cesta, pré-pedido, QR de retirada | Oferta e lista de separação do produtor, leitura do QR pelo organizador |
| Mutirão Cidadão | Agenda do mutirão, triagem simples de benefícios, checklist de documentos | Gestão de atendimentos pelo organizador/parceiros |
| Painel de Impacto | Tela simples com indicadores | Painel web completo (prefeitura/parceiros) |

## Escopo funcional do app (perfil morador, sem login)
- Splash com logo e roteamento inicial.
- Onboarding com 3 páginas, voltar/avançar e botão "Não mostrar novamente" que salva a preferência (ver `docs/architecture/onboarding-decision.md`).
- Telas principais: **Feiras**, **Catálogo da feira**, **Cesta/Pré-pedido**, **Meus pedidos** (com QR), **Mutirão e Triagem**, **Impacto**.
- Consumo da API REST própria (Spring Boot) via `http`; mock com o mesmo contrato enquanto a API não estiver publicada.
- Conversão JSON para models Dart.
- Estados inicial, loading, success e error, com retry.
- Interações: lista → detalhes, adicionar/remover da cesta, filtrar por categoria, triagem de benefícios.

## Stack do app
- Flutter 3.44.1 / Dart (registrar a versão do Dart com `flutter --version`)
- `http`
- `shared_preferences`
- `qr_flutter` (apenas exibir o QR do pedido)
- `setState`

## Stack do ecossistema (fora do app, para referência)
Java 21 + Spring Boot (API), PostgreSQL + PostGIS, JWT para produtor/organizador, Azure (Container Apps, Static Web Apps, Blob Storage, Key Vault, Application Insights), GitHub Actions. Detalhes no resumo do projeto.

## Decisões tomadas
- App atende somente o perfil **morador**.
- **Sem login** no app; o pré-pedido pede apenas nome e telefone.
- Feiras exibidas em **lista ordenada por distância**; mapa (`flutter_map`) fica como evolução no pitch.
- QR code apenas **exibido** no app; a leitura é feita pelo organizador fora do app.
- Onboarding: botão "Não mostrar novamente" em todas as páginas salva `skipOnboarding = true`; "Começar" apenas entra no app.
- Identidade visual: paleta sugerida em `.ai/agents/ui-ux-designer.md` (a validar).

## Decisões ainda pendentes
- URL do repositório e turma: [PREENCHER].
- Base URL da API publicada na Azure: [PREENCHER após o deploy].
- Como o app obtém a posição do morador para ordenar feiras (bairro/CEP escolhido ou `geolocator`).
- Como "Meus pedidos" recupera os pedidos sem login (códigos salvos localmente ou busca por telefone).

## Regras do domínio que valem para todo o app
- **Triagem nunca afirma direito garantido:** sempre "você pode ter direito" + orientação para confirmar no CRAS.
- **LGPD:** a renda informada na triagem é usada só para o cálculo e não é armazenada; HTTPS em tudo; não registrar dados pessoais em logs.
- **Linguagem simples e poucos passos:** público com pouca familiaridade digital.
- Dados de produtores e feiras podem ser fictícios, mas devem ser identificados como tal no README e no pitch.

## Restrições acadêmicas
A solução deve ser desenvolvida pelo integrante. Não reutilizar código de outros grupos. Toda evidência deve corresponder ao aplicativo realmente executado.
