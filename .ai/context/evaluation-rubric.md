# Matriz de avaliação e evidências

Use este documento para rastrear os critérios do enunciado. Status possíveis: `Não iniciado`, `Em andamento`, `Implementado`, `Validado`. Só marcar `Validado` após evidência reproduzível.

| Critério | Pontos | Evidência mínima | Como o Bairro na Mesa atende | Status |
|---|---:|---|---|---|
| Splash | 1,0 | Logo, transição automática, leitura de preferência e destino correto | Logo Bairro na Mesa; lê `skipOnboarding` e vai para Onboarding ou Feiras | Não iniciado |
| Onboarding | 1,5 | 3+ páginas, imagem/ícone, título, descrição, voltar/avançar e preferência persistida | 3 páginas: Feira perto de você / Monte sua cesta / Seus direitos na praça; botão "Não mostrar novamente" salva a preferência | Não iniciado |
| Navegação | 1,5 | 4+ telas principais, navegação funcional, parâmetros e retorno | Feiras, Catálogo, Cesta, Meus pedidos, Mutirão e Triagem, Impacto; Feira e Produto passados como parâmetro | Não iniciado |
| WebService | 2,0 | `http`, endpoint REST, model Dart, dados na UI, 4 estados, mensagem e retry | API Spring Boot própria (`GET /api/feiras`, ofertas, impacto etc.); mock com mesmo contrato até o deploy | Não iniciado |
| Componentes e visual | 1,0 | Widgets obrigatórios e componentes reutilizáveis | `FeiraCard`, `ProdutoCard`, `IndicadorCard`, `EstadoView` (loading/erro/vazio) | Não iniciado |
| Interação | 1,0 | 3+ interações perceptíveis, uma lista → detalhes | Lista de feiras → catálogo; adicionar/remover da cesta; filtro por categoria; triagem de benefícios | Não iniciado |
| Organização e estado | 2,0 | Separação de camadas, nomes padronizados, `setState`, manutenção e atualização correta | Features por módulo, services HTTP separados, cesta mantida por `setState` no widget pai | Não iniciado |

## Checklist de componentes obrigatórios
- [ ] Column
- [ ] Row
- [ ] Card (`FeiraCard`, `ProdutoCard`, `IndicadorCard`)
- [ ] ListView ou GridView (lista de feiras, catálogo)
- [ ] Scaffold
- [ ] AppBar
- [ ] ElevatedButton, TextButton ou OutlinedButton (confirmar pré-pedido, concluir triagem)
- [ ] Icon e IconButton (adicionar/remover da cesta)
- [ ] Image.asset ou Image.network (logo/onboarding em asset; foto do produto via URL)

## Regras de evidência
- Para cada item, registrar caminho do arquivo, cenário de teste e resultado observado.
- Capturas de tela devem ser obtidas da aplicação executável.
- Não considerar a existência de uma classe como prova de funcionamento.
- Build sem erro é condição de entrega, não prova suficiente de todos os requisitos.
- Conferir a rubrica original caso o professor publique esclarecimentos ou alterações.
- Se a demonstração usar o mock, registrar isso na evidência do critério WebService.
