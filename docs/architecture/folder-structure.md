# Estrutura de pastas

## Estrutura proposta

```text
project/
├── assets/
│   ├── images/   (logo, ilustrações do onboarding)
│   └── icons/
├── docs/
├── lib/
│   ├── core/
│   ├── models/
│   ├── services/
│   └── features/
├── test/
├── .ai/
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
├── README.md
├── AGENTS.md
└── CLAUDE.md
```

## Convenções
- Arquivos e diretórios: `snake_case`.
- Classes, enums e typedefs: `PascalCase`.
- Variáveis e métodos: `lowerCamelCase`.
- Widgets: nome terminado em `Screen` para telas e nomes descritivos para componentes.
- Um arquivo deve ter responsabilidade clara.
- Assets devem ter nomes descritivos, minúsculos e sem espaços.

## Onde colocar
- Tela exclusiva de uma feature: `lib/features/<feature>/`.
- Widget usado em várias features: `lib/core/widgets/`.
- Model de domínio/API: `lib/models/` ou dentro da feature se for exclusivo.
- HTTP e SharedPreferences: `lib/services/`.
- Rotas e tema: `lib/core/`.
- Testes: espelhar a organização de `lib/` dentro de `test/`.

Features do Bairro na Mesa: `splash`, `onboarding`, `home`, `feiras`, `catalogo`, `cesta`, `pedidos`, `mutirao`, `impacto` (detalhes em `system-architecture.md`).

Nomes de domínio ficam em português (`Feira`, `Oferta`, `Pedido`), mantendo o padrão das entidades da API. Ajustar a estrutura ao tamanho real do aplicativo; não criar camadas vazias por formalidade.
