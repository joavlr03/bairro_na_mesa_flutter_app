# Plano de testes

## Ambiente
- Flutter: 3.44.1
- Dart: 3.12.1
- Sistema/dispositivo: Windows 11 + emulador Android [PREENCHER modelo/API level]
- API/ambiente: Mock local em Node.js (`node mock/server.js`); API Spring Boot na Azure ainda não publicada
- Data:

## Casos de teste

| ID | Cenário | Passos resumidos | Resultado esperado |
|---|---|---|---|
| T01 | Primeira abertura | Limpar dados do app e iniciar | Splash direciona ao onboarding |
| T02 | Onboarding | Avançar e voltar entre as 3 páginas | Conteúdo e navegação corretos |
| T03 | Não mostrar novamente | Marcar a caixa "Não mostrar novamente", tocar "Começar" (ou "Pular") e reiniciar | Splash vai direto para Feiras |
| T03b | Concluir sem marcar | Limpar dados, deixar a caixa desmarcada, tocar "Começar" na página 3 e reiniciar | Onboarding aparece de novo |
| T04 | Navegação | Abrir as 5 abas do HomeShell | Todas acessíveis |
| T05 | Lista → detalhes | Tocar em uma feira | Catálogo mostra a feira tocada |
| T06 | API sucesso | Abrir Feiras com API/mock no ar | Feiras convertidas e exibidas |
| T07 | API loading | Simular resposta lenta | Indicador aparece |
| T08 | API erro | Desligar mock/API e abrir Feiras | Mensagem e "Tentar de novo" |
| T09 | Retry | Religar e tocar "Tentar de novo" | Nova requisição e dados exibidos |
| T10 | Lista vazia | Mock retornando `[]` | Estado vazio com mensagem |
| T11 | Filtro | Selecionar "Frutas" e depois "Todas" | Catálogo filtra e restaura |
| T12 | Cesta | Adicionar 2 e remover 1 item | Quantidade e total corretos |
| T13 | Esgotado | Abrir produto com estoque 0 | Botão adicionar desabilitado |
| T14 | Pré-pedido inválido | Confirmar sem nome/telefone | Mensagem de validação, sem envio |
| T15 | Pré-pedido | Confirmar com dados válidos | Pedido aparece em Meus pedidos; cesta limpa |
| T16 | QR | Abrir pedido em Meus pedidos | QR do código exibido |
| T17 | Triagem | Preencher e enviar | "Pode ter direito" + documentos + aviso CRAS |
| T18 | Triagem LGPD | Enviar, sair e voltar à tela | Campo de renda vazio; nada salvo |
| T19 | Impacto | Abrir aba Impacto | Indicadores exibidos |
| T20 | Build | `flutter build apk --debug` | Build finaliza sem erro |

## Registro de execução
Para cada teste, registrar data, ambiente (mock ou Azure), resultado (Passou/Falhou/Bloqueado), observação e evidência. Não marcar como passou sem executar.
