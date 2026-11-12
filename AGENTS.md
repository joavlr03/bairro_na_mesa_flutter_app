# Instruções gerais para agentes de programação

## Objetivo
Ajudar a desenvolver e validar o aplicativo Flutter/Dart **Bairro na Mesa** para a Global Solution 2026.2 (CitizenTech), respeitando o enunciado, a arquitetura documentada e a integridade acadêmica.

## Contexto do domínio
O Bairro na Mesa transforma praças da periferia em pontos semanais de comida acessível e cidadania: feira de agricultores familiares com pré-pedido pelo celular, mutirão de acesso a benefícios sociais e painel de impacto. O app Flutter atende **somente o morador**, **sem login**.

- Resumo completo: `../Bairro na Mesa – Resumo do Projeto (GS 2026.2).md`.
- Recorte para o app: `.ai/context/project-context.md`.
- Entidades do back-end usadas pelo app: `Praca`, `Feira`, `Produto`, `Oferta`, `Pedido`, `ItemPedido`, `Mutirao`, `Beneficio` e o indicador de impacto.
- Equipe de 1 pessoa (João Victor Oliveira Avellar – RM 550283), responsável por API, app, infra e pitch. Priorize tarefas pequenas e entregáveis.

### Regras de negócio que todo agente deve respeitar
- A triagem nunca afirma direito garantido: sempre "você pode ter direito" e orienta a confirmar no CRAS.
- A renda informada na triagem é enviada só para o cálculo e não é salva no app nem em logs (LGPD).
- Linguagem simples, poucos passos, botões grandes: o público tem pouca familiaridade digital.
- Dados fictícios de produtores e feiras devem ser identificados como tal.
- Em caso de corte de escopo, remover primeiro o QR code e depois o Painel de Impacto; nunca a feira com pré-pedido.

## Antes de agir
1. Leia `README.md`, `.ai/context/project-context.md`, `.ai/context/evaluation-rubric.md` e os documentos relevantes em `docs/`.
2. Inspecione o código existente antes de propor alterações.
3. Identifique requisitos e arquivos afetados.
4. Se uma informação essencial estiver ausente (tema, API, decisão de navegação, regra de negócio), pergunte ou registre como pendência. Não invente.

## Regras obrigatórias
- Use Flutter e Dart.
- Utilize o pacote `http` para requisições HTTP, conforme o requisito acadêmico.
- Utilize `SharedPreferences` para a preferência do onboarding.
- A API consumida é a API Spring Boot do próprio projeto. Enquanto ela não estiver publicada, use o mock com o mesmo contrato (`docs/api/api-documentation.md`), trocando apenas a base URL.
- Dependências aprovadas além das obrigatórias: `qr_flutter` (exibir QR do pedido). `flutter_map`, `geolocator` ou outras exigem decisão registrada antes.
- Utilize `setState` para gerenciamento de estado, conforme exigido pelo enunciado. Não introduza Provider, Riverpod, Bloc ou outra solução sem autorização explícita do grupo/professor.
- Separe telas, widgets reutilizáveis, models, services e lógica de acesso a dados.
- Não coloque regras de negócio complexas diretamente nos widgets de tela.
- Preserve o padrão de nomenclatura e a arquitetura já adotados.
- Evite dependências desnecessárias.
- Não remova funcionalidades existentes sem explicar impacto e obter concordância.
- Nunca invente resultados de testes, prints, endpoints, nomes, RMs ou evidências.
- Nunca inclua segredos, tokens ou credenciais no repositório.
- Não copie código de outros grupos ou projetos acadêmicos. Use documentação oficial e fontes autorizadas; identifique dependências e recursos externos quando necessário.

## Processo de implementação
1. Entender o requisito e seu critério de aceite.
2. Localizar a camada correta.
3. Propor uma alteração pequena e coerente.
4. Implementar somente o escopo combinado.
5. Executar `dart format .`, `flutter analyze` e testes relevantes quando disponíveis.
6. Informar exatamente o que foi alterado, comandos executados e resultados observados.
7. Atualizar documentação se a arquitetura, API, fluxo ou comportamento mudou.

## Qualidade
- Trate estados inicial, carregamento, sucesso e erro nas operações remotas.
- Disponibilize retry para falhas de carregamento.
- Verifique respostas HTTP e erros de parsing.
- Considere estados vazios, entradas inválidas e ausência de conexão.
- Evite `!` (null assertion) sem justificativa.
- Use `const` quando apropriado.
- Não deixe `print`, código morto ou TODOs críticos sem explicar.
- Mantenha widgets pequenos e reutilizáveis.

## Limites
- Não afirmar que o projeto atende à rubrica sem evidências.
- Não preencher dados pessoais dos integrantes por suposição. O único integrante informado é João Victor Oliveira Avellar – RM 550283.
- Não realizar submissão final em nome do grupo.
- Quando houver conflito entre este arquivo, o enunciado e uma decisão documentada do grupo, sinalize o conflito e peça confirmação; o enunciado acadêmico prevalece sobre conveniências técnicas.

## Coding Standards and Reference Code

Before implementing any feature:

1. Read `.ai/coding-standards/coding-level.md`.
2. Inspect relevant examples in
   `.ai/coding-standards/`.
3. Follow the project's preferred coding style.
4. Use GOOD PRACTICES as positive references.
5. Avoid patterns documented in ANTI-PATTERNS.
6. Adapt examples to the actual project architecture.
7. Do not copy examples blindly.

## Expected Development Level

Target: Intermediate.

Implement solutions that demonstrate
intermediate Dart and Flutter knowledge.

Do not unnecessarily simplify the code.
Do not introduce advanced abstractions
without a concrete reason.

Explain important technical decisions
when the implementation is not obvious.