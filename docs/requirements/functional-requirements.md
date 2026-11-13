# Requisitos funcionais

## Requisitos acadêmicos

| ID | Requisito | Critério de aceite | No Bairro na Mesa |
|---|---|---|---|
| RF01 | Splash | Exibe logo, transita automaticamente e consulta preferência | Logo Bairro na Mesa; lê `skipOnboarding` |
| RF02 | Onboarding | Possui no mínimo 3 páginas, ícone/imagem, título, descrição e avançar/voltar | 3 páginas sobre feira, cesta e direitos |
| RF03 | Preferência | Salva opção "Não mostrar novamente" com SharedPreferences | Caixa "Não mostrar novamente" em todas as páginas; ao finalizar (Começar/Pular) salva `skipOnboarding = true` se marcada |
| RF04 | Navegação | Possui no mínimo 4 telas principais, excluindo Splash/Onboarding | Feiras, Catálogo, Cesta, Meus pedidos, Mutirão e Triagem, Impacto |
| RF05 | Parâmetros | Passa dados necessários entre telas | `Feira` para Catálogo; cesta para Cesta; `Pedido` para QR |
| RF06 | API | Usa pacote `http` para consumir pelo menos um endpoint REST | API Spring Boot própria (mock até o deploy) |
| RF07 | Models | Converte JSON em objetos Dart | `Feira`, `Oferta`, `Pedido`, `Mutirao`, `ResultadoTriagem`, `Impacto` |
| RF08 | Estados remotos | Apresenta inicial, loading, success e error | Feiras, Catálogo, Mutirão, Impacto |
| RF09 | Retry | Permite tentar novamente após falha | Botão "Tentar de novo" no `EstadoView` |
| RF10 | Componentes | Utiliza todos os widgets obrigatórios listados no enunciado | Ver checklist em `evaluation-rubric.md` |
| RF11 | Reutilização | Possui widgets personalizados reutilizados | `FeiraCard`, `ProdutoCard`, `IndicadorCard`, `EstadoView` |
| RF12 | Interações | Implementa pelo menos 3 interações distintas e perceptíveis | Ver abaixo |
| RF13 | Detalhes | Toque em item de lista abre tela de detalhes | Feira → Catálogo da feira |

## Requisitos do domínio

| ID | Requisito | Critério de aceite |
|---|---|---|
| RD01 | Listar feiras próximas | Lista ordenada por distância com praça, bairro, dia e horário |
| RD02 | Catálogo da semana | Mostra produtos com preço, unidade e estoque; esgotado fica desabilitado |
| RD03 | Cesta | Adicionar/remover itens atualiza quantidade e total |
| RD04 | Pré-pedido | Exige nome e telefone; envia `POST /api/pedidos`; pagamento na retirada |
| RD05 | Meus pedidos | Lista pedidos feitos e exibe QR do código de retirada |
| RD06 | Agenda do mutirão | Mostra atendimentos disponíveis na feira (CadÚnico, Tarifa Social, documentos) |
| RD07 | Triagem | Perguntas simples; resultado "pode ter direito" + documentos; renda não armazenada |
| RD08 | Impacto | Exibe famílias atendidas, kg vendidos, renda aos produtores, desperdício evitado, benefícios solicitados |

## Interações escolhidas
1. **Lista → detalhes:** tocar em uma feira abre o catálogo dela.
2. **Adicionar/remover da cesta:** botões + e − atualizam quantidade e total na hora.
3. **Filtrar por categoria:** chips (Todas, Frutas, Verduras, Legumes, Outros) filtram o catálogo.
4. **Triagem de benefícios:** responder o formulário mostra o resultado na tela.

## Fora do escopo do app (roadmap no pitch)
Login, perfis produtor/organizador, mapa, leitura de QR, Pix real, notificações push, bot no WhatsApp, triagem com IA, entregas, integração com o PNAE.
