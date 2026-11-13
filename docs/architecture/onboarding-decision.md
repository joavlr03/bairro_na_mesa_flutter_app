# Decisão: preferência do onboarding

**Status:** revisado em 12/11/2026 por João Victor Oliveira Avellar. Substitui a decisão anterior (botão "Não mostrar novamente" que saía na hora).

## Regra adotada
O onboarding tem uma **caixa de seleção "Não mostrar novamente"**, visível em todas as páginas. Ao **finalizar** a introdução ("Começar" na página 3, ou "Pular" em qualquer página), a preferência é salva **somente se a caixa estiver marcada**. Isso segue o enunciado: "ao finalizar a introdução, salvar a preferência respeitando a opção selecionada".

Chave em `SharedPreferences`: `skipOnboarding` (bool).
- `true`: Splash segue direto para Feiras.
- `false`/ausente: Splash exibe o onboarding.

## Comportamento dos controles
| Controle | Onde aparece | Salva `skipOnboarding` | Destino |
|---|---|---|---|
| Voltar | Páginas 2 e 3 | Não | Página anterior |
| Avançar | Páginas 1 e 2 | Não | Próxima página |
| Caixa "Não mostrar novamente" | Todas as páginas | Só marca; não sai da tela | — |
| Começar | Página 3 | Sim, se a caixa estiver marcada | Feiras |
| Pular | Todas as páginas | Sim, se a caixa estiver marcada | Feiras |

As saídas para Feiras usam `pushReplacement`, para o botão voltar do Android não retornar ao onboarding.

## Por quê
- O enunciado fala em salvar a preferência ao finalizar, respeitando a opção selecionada, o que descreve uma opção marcável e não um botão que sai na hora.
- "Pular" evita obrigar quem já conhece o app a passar pelas 3 páginas, sem ignorar a caixa.

## Testes relacionados
T01, T02, T03 e T03b em `docs/quality/test-plan.md` (e testes automatizados em `test/widget_test.dart`).
