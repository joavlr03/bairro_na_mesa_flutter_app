# Fluxo de navegação

## Fluxo de inicialização e telas

```mermaid
flowchart TD
    A[Inicialização do app] --> B[Splash]
    B --> C{skipOnboarding?}
    C -->|false/ausente| D[Onboarding 1: Feira perto de você]
    D --> E[Onboarding 2: Monte sua cesta]
    E --> F[Onboarding 3: Seus direitos na praça]
    F -->|Começar - salva só se "Não mostrar novamente" marcado| G[HomeShell]
    D & E -->|Pular - salva só se marcado| G
    C -->|true| G
    G --> H[Feiras]
    G --> I[Cesta]
    G --> J[Meus pedidos]
    G --> K[Mutirão e Triagem]
    G --> L[Impacto]
    H -->|Feira| M[Catálogo da feira]
    M -->|adiciona itens| I
    I -->|pré-pedido confirmado| J
    J -->|Pedido| N[QR de retirada]
```

## Requisitos de navegação
- Splash e Onboarding não contam como telas principais.
- `HomeShell` usa `NavigationBar` com 5 abas: Feiras, Cesta, Pedidos, Mutirão, Impacto.
- Catálogo e QR de retirada são abertos com `Navigator.push` e voltam pela pilha.
- Ao sair do onboarding ("Começar" ou "Pular"), usar `pushReplacement` para o usuário não voltar a ele.

## Inventário

| Tela | Objetivo | Origem | Destino/ações |
|---|---|---|---|
| Splash | Verificar preferência e encaminhar | Inicialização | Onboarding ou HomeShell |
| Onboarding | Explicar a proposta em 3 páginas | Splash | Próxima/anterior/Começar/Pular e caixa "Não mostrar novamente" |
| Feiras | Mostrar feiras por distância | Aba | Catálogo da feira |
| Catálogo da feira | Produtos da semana, filtro, adicionar à cesta | Feiras | Voltar; aba Cesta |
| Cesta | Revisar itens e confirmar pré-pedido | Aba / Catálogo | Meus pedidos |
| Meus pedidos | Listar pedidos | Aba / Cesta | QR de retirada |
| QR de retirada | Mostrar QR do código do pedido | Meus pedidos | Voltar |
| Mutirão e Triagem | Agenda + formulário + resultado | Aba | Mesma tela (resultado) |
| Impacto | Indicadores do projeto | Aba | Atualizar |

## Parâmetros
| Destino | Parâmetro | Tipo | Obrigatório |
|---|---|---|---|
| Catálogo da feira | feira selecionada | `Feira` | Sim |
| Catálogo da feira | cesta atual + callbacks de adicionar/remover | `Cesta`, `ValueChanged` | Sim |
| Cesta | cesta atual + callbacks | `Cesta` | Sim |
| QR de retirada | pedido | `Pedido` | Sim |
