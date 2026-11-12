# Bairro na Mesa – Resumo do Projeto (GS 2026.2)

Nov 10, 2026 · @João Victor

## Visão geral

O Bairro na Mesa transforma praças da periferia em pontos semanais de comida acessível e cidadania: uma feira de agricultores familiares e hortas comunitárias com pré-pedido pelo celular, acompanhada de um mutirão de acesso a benefícios sociais.

**Premissa:** comida boa e direitos básicos já existem perto de quem precisa, mas estão desconectados. A plataforma organiza o que o próprio território tem para que ninguém fique sem comida ou sem acesso ao que tem direito.

**Em uma frase:** a praça do bairro como ponto de encontro entre quem produz, quem precisa comer e os direitos de cada cidadão.

## Problema e cidadão beneficiado

Três problemas acontecem no mesmo território e hoje não se conversam:

1. **Comida fresca é cara e rara na periferia.** Muitos bairros são desertos alimentares, com mercadinhos caros e pouca fruta e verdura.
2. **O pequeno produtor ganha pouco e desperdiça.** Depende de atravessadores e não sabe quanto vai vender, então perde parte da colheita.
3. **Muita gente não acessa direitos que já tem.** Famílias deixam de pedir Bolsa Família, Tarifa Social ou de atualizar o CadÚnico por falta de informação, documentos ou tempo para ir ao CRAS.

**Quem é beneficiado:**

- Famílias de baixa renda da periferia, especialmente em insegurança alimentar ou fora dos programas sociais
- Agricultores familiares e hortas comunitárias da Grande São Paulo
- A comunidade do bairro, que ganha uma praça ocupada e movimentada

## Como funciona

A plataforma tem três módulos que se encontram no mesmo lugar físico: a praça.

| Módulo | O que faz | Quem usa |
| --- | --- | --- |
| **Feira na Praça** (núcleo) | Mapa de feiras, catálogo semanal, pré-pedido, lista de separação do produtor, retirada por QR code | Morador, produtor, organizador |
| **Mutirão Cidadão** | Agenda de atendimentos na feira (CadÚnico, Tarifa Social, documentos), triagem simples de benefícios, checklist de documentos, agendamento de horário | Morador, organizador, parceiros |
| **Painel de Impacto** | Famílias atendidas, kg vendidos, renda aos produtores, desperdício evitado, benefícios solicitados | Público, prefeitura, parceiros |

**Jornada do morador (Dona Maria):** vê que no sábado há feira a duas quadras, monta a cesta e faz o pré-pedido. Na triagem, descobre que pode ter direito à Tarifa Social e recebe a lista de documentos. No sábado, retira a cesta com QR code e é atendida no mutirão.

**Jornada do produtor (Seu José, agricultor de Mogi das Cruzes):** na segunda publica a oferta da semana, na sexta recebe a lista de separação, colhe só o necessário e vende direto na praça, sem intermediário.

## Ecossistema e diferenciais

Nenhuma solução atual junta comida acessível, renda para o produtor e acesso a direitos no mesmo lugar físico. Esse é o diferencial central.

**Quem participa:**

- **Produtores e hortas:** fornecem os alimentos
- **Associações de moradores e ONGs:** organizam a feira na praça
- **CRAS, Defensoria e universidades:** levam atendimentos ao mutirão (alunos da FIAP podem atuar como voluntários)
- **Prefeitura:** autoriza o uso das praças e usa os dados do painel para planejar políticas públicas

**Benchmarking:**

| Solução | O que faz | O que falta |
| --- | --- | --- |
| Raízs / Fruta Imperfeita | Venda de produtos de pequenos produtores | Delivery voltado a público de renda mais alta |
| Comida Invisível | Conecta doações de alimentos | Não gera renda ao produtor |
| App Meu CadÚnico / CRAS | Acesso a benefícios | Exige saber o que procurar e se deslocar |
| Feiras livres tradicionais | Comida fresca e barata | Raras na periferia, sem previsibilidade de venda |

**Outros diferenciais:** pré-pedido reduz desperdício, foco em quem tem pouca familiaridade digital (linguagem simples, poucos passos) e impacto medido em tempo real.

## ODS e impacto

O projeto atende três das ODS mais atrasadas segundo os relatórios de 2026 (2, 10 e 11), com a ODS 12 e a ODS 1 como complemento.

| ODS | Meta | Contribuição |
| --- | --- | --- |
| ODS 2 – Fome zero | 2.1 acesso a alimentos; 2.3 renda do pequeno produtor | Comida fresca mais barata e venda direta sem atravessador |
| ODS 10 – Redução das desigualdades | 10.2 inclusão social e econômica | Mutirão e triagem levam benefícios a quem está fora dos programas |
| ODS 11 – Cidades sustentáveis | 11.7 espaços públicos inclusivos | Praças ocupadas com feira e serviços |
| ODS 12 – Consumo responsável | 12.3 reduzir desperdício de alimentos | Pré-pedido faz o produtor colher só o necessário |
| ODS 1 – Erradicação da pobreza | Complementar | Acesso a benefícios e renda extra |

**Indicadores do painel:** famílias atendidas por mês, economia média por cesta frente ao varejo, renda adicional por produtor, kg de alimento que deixou de ser desperdiçado e benefícios solicitados a partir da triagem.

**Como escala:** cada nova praça é um cadastro no sistema, replicável bairro a bairro e em outras cidades. A sustentabilidade financeira pode vir de uma pequena taxa por venda paga pelo produtor (menor que a margem do atravessador), parcerias com prefeituras e editais de impacto social.

**Fontes para dados de mercado:** Rede PENSSAN (VIGISAN), IBGE (PNAD Contínua – Segurança Alimentar), Censo Agropecuário, MDS (dados do CadÚnico), Embrapa e FAO (desperdício de alimentos).

## Escopo do MVP, arquitetura e stack

O MVP entrega de verdade a feira com pré-pedido, a triagem de benefícios e o painel de impacto; pagamento real e integrações ficam como evolução.

**Construído no MVP:**

1. Cadastro e login com perfis (morador, produtor, organizador)
2. Mapa de feiras próximas e catálogo da semana com estoque
3. Carrinho e pré-pedido (pagamento simulado ou na retirada)
4. Painel do produtor com lista de separação
5. Retirada com QR code
6. Agenda do mutirão e triagem de benefícios com regras fixas no banco
7. Painel de impacto e notificações

**Roadmap (apresentado no pitch):** Pix real, bot no WhatsApp, triagem com IA, entregas e integração com o PNAE.

&#91;embedded content: arquitetura da solução · Azure + GitHub\]

App e painel falam só com a API; banco, arquivos e notificações ficam atrás dela, e o deploy é automático a cada merge.

| Camada | Tecnologia | Motivo |
| --- | --- | --- |
| Front | Flutter (mobile + web) + flutter\_map/OpenStreetMap | Um código para app e painel; mapa gratuito |
| Back-end | Java 21 + Spring Boot (Web, Security, Data JPA) | Padrão de mercado e da FIAP |
| Autenticação | JWT com perfis | Simples e seguro para o MVP |
| Banco | PostgreSQL + PostGIS (Azure Database Flexible Server) | Busca de feiras por distância, backup automático |
| Arquivos | Azure Blob Storage | Fotos de produtos e produtores |
| Notificações | Firebase Cloud Messaging | Gratuito e integrado ao Flutter |
| Hospedagem | Azure Container Apps (API) + Static Web Apps (painel) | Escala até zero, cabe no Azure for Students |
| CI/CD | GitHub Actions + GitHub Container Registry | Build, testes e deploy automáticos |
| Qualidade | JUnit, Mockito, Testcontainers, Newman, SonarCloud | Conversa com a disciplina de QA |
| Monitoramento | Application Insights | Logs e métricas para o vídeo |
| Segredos | Azure Key Vault | Credenciais fora do código |

**Entidades principais:** Usuario, Produtor, Praca, Feira, Produto, Oferta, Pedido, ItemPedido, Mutirao, AgendamentoAtendimento e Beneficio.

**LGPD:** a triagem calcula o resultado sem guardar a renda informada (ou guarda só com consentimento), senhas com BCrypt e HTTPS em tudo.

Se as disciplinas usarem Oracle ou AWS, a arquitetura é a mesma: troca-se o banco por Oracle ou os serviços por App Runner, RDS, S3 e CloudWatch.

## Cronograma, equipe e riscos

O software precisa estar no ar até 17/11 para sobrar tempo de gravar o vídeo e entregar o pitch em Nov 19, 2026, até 23h55.

&#91;embedded content: cronograma até a entrega de 19/11\]

Suba uma primeira versão na Azure já no dia 13, mesmo incompleta, para não ter surpresa no deploy.

| Integrante | Responsabilidade |
| --- | --- |
| Pessoa 1 (back-end) | API, banco, segurança, testes do back |
| Pessoa 2 (front) | App Flutter, mapa, telas do morador e do produtor |
| Pessoa 3 (infra e produto) | Azure, pipeline, painel de impacto, pesquisa de mercado, benchmarking e roteiro do pitch |

**Riscos e respostas:**

- **Escopo crescer demais:** cortar notificações e QR code antes do resto
- **Falta de produtores reais:** dados fictícios baseados em conversa com um feirante, com fala dele no vídeo
- **Regras de benefícios incorretas:** triagem indica “pode ter direito” e orienta a confirmar no CRAS
- **Deploy na última hora:** primeira versão na nuvem até 13/11

**Próximos passos:**

- [ ] Fechar a equipe e dividir as responsabilidades
- [ ] Conversar com 1 ou 2 feirantes e moradores para validar o problema
- [ ] Criar repositório, pipeline e protótipo no Figma
- [ ] Levantar os dados de mercado nas fontes listadas
