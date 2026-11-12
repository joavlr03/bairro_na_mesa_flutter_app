# Decisão: preferência do onboarding

**Status:** decidido em 12/11/2026 por João Victor Oliveira Avellar. Substitui a regra anterior ("concluir já esconde").

## Regra adotada
O onboarding oferece o botão **"Não mostrar novamente"**, que segue literalmente o enunciado.

Chave em `SharedPreferences`: `skipOnboarding` (bool).
- `true`: Splash segue direto para Feiras.
- `false`/ausente: Splash exibe o onboarding.

## Comportamento dos botões
| Botão | Onde aparece | Salva `skipOnboarding` | Destino |
|---|---|---|---|
| Voltar | Páginas 2 e 3 | Não | Página anterior |
| Avançar | Páginas 1 e 2 | Não | Próxima página |
| Começar | Página 3 | Não | Feiras (onboarding volta a aparecer na próxima abertura) |
| Não mostrar novamente | Todas as páginas | Sim (`true`) | Feiras |

As duas saídas para Feiras usam `pushReplacement`, para o botão voltar do Android não retornar ao onboarding.

## Por quê
- O enunciado pede explicitamente a opção "Não mostrar novamente" salva com `SharedPreferences`; um botão visível deixa isso demonstrável no vídeo e nos prints.
- Ficar disponível em todas as páginas permite que quem já conhece o app saia sem passar pelas 3 telas.

## Testes relacionados
T01, T02, T03 e T03b em `docs/quality/test-plan.md`.
