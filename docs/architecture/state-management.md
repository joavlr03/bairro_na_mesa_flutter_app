# Gerenciamento de estado

## Abordagem
Utilizar `StatefulWidget` e `setState` para o gerenciamento de estado, conforme requisito explícito da avaliação. Não introduzir pacote externo de gerenciamento de estado sem autorização.

## Estados de tela
Para operações assíncronas, representar explicitamente:
- `initial`: ainda não iniciou a busca.
- `loading`: requisição em andamento.
- `success`: dados carregados.
- `error`: falha recuperável, com mensagem e ação de retry.

Uma enum pode representar o estado, evitando múltiplos booleanos inconsistentes.

## Exemplo conceitual
```dart
enum LoadStatus { initial, loading, success, error }
```

A tela chama o service e atualiza status/dados com `setState`. O service não chama `setState` e não conhece widgets.

## Ciclo de vida e segurança
- Verificar `mounted` antes de chamar `setState` após `await`.
- Evitar disparar a mesma requisição repetidamente sem necessidade.
- Desabilitar ações incompatíveis durante carregamento quando apropriado.
- Não apagar dados anteriores sem decisão explícita; considerar manter dados antigos durante atualização.
- Exibir estado vazio quando a requisição for bem-sucedida, mas não houver itens.

## Estado local
Exemplos no Bairro na Mesa: categoria selecionada no catálogo, página atual do onboarding, respostas do formulário de triagem e aba ativa do `HomeShell`.

## Estado compartilhado: a cesta
A cesta é usada pelo Catálogo e pela tela Cesta. Para continuar só com `setState`:
- `HomeShell` (`StatefulWidget`) mantém um objeto `Cesta`.
- Catálogo e Cesta recebem a `Cesta` e callbacks `onAdicionar`/`onRemover`.
- `HomeShell` executa a alteração dentro de `setState`, e as telas filhas são reconstruídas.
- Após o pré-pedido confirmado, `HomeShell` limpa a cesta com `setState`.
