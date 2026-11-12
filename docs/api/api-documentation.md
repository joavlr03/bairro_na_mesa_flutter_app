# Documentação da API

> **Status do contrato: Proposto.** API própria do projeto, ainda não implementada. Atualizar cada endpoint para "Implementado" após testar na API real. Os exemplos abaixo definem o formato que a API Spring Boot e o mock devem seguir; não são respostas observadas.

## Identificação
- Nome: API Bairro na Mesa (Java 21 + Spring Boot)
- URL da documentação: [PREENCHER – Swagger/OpenAPI após o deploy]
- Base URL (Azure): [PREENCHER após o deploy]
- Base URL (mock local): `http://10.0.2.2:3000` no emulador Android; `http://localhost:3000` no Flutter web/desktop
- Autenticação: endpoints do morador são públicos; JWT apenas para produtor/organizador (fora do app)
- Data em que foi consultada: [PREENCHER]

## Endpoints usados pelo app

| Método | Caminho | Objetivo | Tela | Status |
|---|---|---|---|---|
| GET | `/api/feiras?lat={lat}&lng={lng}` | Feiras ordenadas por distância | Feiras | Proposto |
| GET | `/api/feiras/{id}/ofertas?categoria={categoria}` | Catálogo da semana da feira | Catálogo | Proposto |
| POST | `/api/pedidos` | Criar pré-pedido | Cesta | Proposto |
| GET | `/api/pedidos/{codigo}` | Consultar pedido e status | Meus pedidos | Proposto |
| GET | `/api/feiras/{id}/mutiroes` | Agenda do mutirão na feira | Mutirão | Proposto |
| POST | `/api/triagem` | Calcular benefícios possíveis (sem salvar renda) | Triagem | Proposto |
| GET | `/api/impacto` | Indicadores do painel | Impacto | Proposto |

## Exemplos de JSON (formato proposto)

`GET /api/feiras`
```json
[
  {
    "id": 1,
    "praca": "Praça Exemplo",
    "bairro": "Bairro Exemplo",
    "diaSemana": "SABADO",
    "horarioInicio": "08:00",
    "horarioFim": "13:00",
    "distanciaKm": 0.4,
    "temMutirao": true
  }
]
```

`GET /api/feiras/{id}/ofertas`
```json
[
  {
    "id": 10,
    "produto": "Alface crespa",
    "categoria": "VERDURAS",
    "unidade": "maço",
    "preco": 2.50,
    "estoque": 30,
    "produtor": "Produtor fictício",
    "fotoUrl": "https://..."
  }
]
```

`POST /api/pedidos` (corpo)
```json
{
  "feiraId": 1,
  "nome": "Maria",
  "telefone": "11999999999",
  "itens": [{ "ofertaId": 10, "quantidade": 2 }]
}
```
Resposta `201`: `{ "codigo": "BNM-0001", "total": 5.00, "status": "AGUARDANDO_RETIRADA" }`

`POST /api/triagem` (corpo)
```json
{ "pessoasNaCasa": 4, "rendaFamiliar": 1800.00, "temCadUnico": false }
```
Regras (calculadas na API; o app só exibe o resultado):
- **CadÚnico:** renda familiar total de até 3 salários mínimos (R$ 1.621 em 2026 — confirmar o valor vigente) e ainda não inscrito.
- **Tarifa Social de Energia (isenção na conta de luz):** estar inscrito no CadÚnico; quem tem direito ao CadÚnico também pode ter direito a ela.
- Sempre "pode ter direito", com orientação de confirmar no CRAS.

Resposta `200`:
```json
{
  "beneficios": [
    { "nome": "Tarifa Social de Energia", "mensagem": "Você pode ter direito. Confirme no CRAS.", "documentos": ["RG ou CPF", "Conta de luz", "Comprovante de residência"] }
  ]
}
```

`GET /api/impacto`
```json
{ "familiasAtendidas": 0, "kgVendidos": 0, "rendaProdutores": 0, "kgDesperdicioEvitado": 0, "beneficiosSolicitados": 0 }
```

## Models Dart
| Classe | Origem | Campos opcionais |
|---|---|---|
| `Feira` | `GET /api/feiras` | `distanciaKm` |
| `Oferta` | `GET /api/feiras/{id}/ofertas` | `fotoUrl`, `produtor` |
| `Pedido` / `ItemPedido` | `POST`/`GET /api/pedidos` | — |
| `Mutirao` | `GET /api/feiras/{id}/mutiroes` | — |
| `ResultadoTriagem` / `Beneficio` | `POST /api/triagem` | `documentos` |
| `Impacto` | `GET /api/impacto` | — |

Valores numéricos devem aceitar `int` e `double` no `fromJson` (`(json['preco'] as num).toDouble()`).

## Estados e erros
| Cenário | Comportamento esperado |
|---|---|
| Antes da chamada | Estado inicial |
| Requisição em andamento | Indicador de carregamento |
| HTTP 200 com dados | Exibir dados |
| HTTP 200 com lista vazia | Estado vazio ("Nenhuma feira por perto ainda") |
| Sem conexão/timeout | Mensagem e retry |
| HTTP 400 no pré-pedido | Mostrar mensagem de validação (ex.: produto esgotado) |
| HTTP 5xx | Mensagem genérica e retry |
| JSON inválido | Tratar erro de parsing |

## Observações
- Dados de feiras e produtores são fictícios no MVP e devem ser declarados como tal.
- A renda enviada em `/api/triagem` não é persistida pela API nem pelo app.
