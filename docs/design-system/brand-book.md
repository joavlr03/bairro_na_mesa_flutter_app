# Bairro na Mesa

**A praça do bairro como ponto de encontro entre quem produz, quem precisa comer e os direitos de cada cidadão.**

Brand kit do Bairro na Mesa, projeto da Global Solution 2026.2 (FIAP · CitizenTech). Aqui estão a essência da marca, o logo e suas regras, cores, tipografia, tom de voz, ícones, imagens e aplicações. Os valores exatos ficam em `tokens.json` e os arquivos do logo no grupo de assets **Logos** e **Simbolo**.

---

## 1. Essência da marca

| | |
| --- | --- |
| **Propósito** | Ninguém do bairro fica sem comida boa ou sem acesso ao que tem direito. |
| **Missão** | Organizar o que o próprio território já tem — produtores, praças, serviços públicos — num ponto semanal de comida acessível e cidadania. |
| **Visão** | Cada praça da periferia funcionando como uma mesa comunitária, replicável bairro a bairro. |
| **Promessa** | "No sábado, na praça: sua cesta e seus direitos, no mesmo lugar." |
| **Posicionamento** | Para famílias da periferia e pequenos produtores da Grande São Paulo, o Bairro na Mesa é a única plataforma que junta comida fresca acessível, renda direta ao produtor e acesso a benefícios sociais no mesmo lugar físico: a praça. |

### Valores

- **Perto** — a solução está no território, a duas quadras de casa.
- **Justo** — preço bom para quem compra, renda justa para quem planta, sem atravessador.
- **Simples** — poucos passos, palavras do dia a dia, funciona para quem tem pouca prática com o celular.
- **Junto** — morador, produtor, associação, CRAS e voluntários dividem a mesma mesa.
- **Transparente** — o impacto é medido e mostrado no painel, em tempo real.

### Personalidade

A marca fala como **a vizinha que organiza a feira**: acolhedora, prática e confiável. Sabe das coisas, mas não fala difícil. É animada sem ser infantil, e séria quando o assunto é direito e dinheiro.

| É | Não é |
| --- | --- |
| Acolhedora | Assistencialista ou com pena |
| Prática | Burocrática |
| Popular | Improvisada |
| Confiável | Fria ou "de governo" |
| Alegre | Infantil |

### Públicos

- **Moradores (ex.: Dona Maria)** — famílias de baixa renda, muitas vezes com celular básico e pouco tempo. Precisam de clareza, letra grande e confiança.
- **Produtores (ex.: Seu José, Mogi das Cruzes)** — agricultores familiares e hortas comunitárias. Querem previsibilidade de venda e menos desperdício.
- **Organizadores e parceiros** — associações, ONGs, CRAS, Defensoria, universidades e prefeitura. Precisam de dados e de uma marca séria o bastante para apoiar.

---

## 2. Logo

### Conceito

O símbolo junta as três partes do projeto num só desenho, que também lembra uma barraca de feira:

- **Telhado (terra-tijolo)** — o bairro e a casa. A cor vem do tijolo aparente das casas da periferia.
- **Broto (verde-horta)** — a comida fresca e o pequeno produtor. Cresce *dentro* da casa: o alimento chega ao bairro.
- **Mesa (tinta)** — o encontro na praça, onde se compra, se conversa e se é atendido. A mesa é mais larga que o telhado: cabe todo mundo.

As pontas arredondadas em todos os traços deixam a marca amigável e são a base do raio `raio-pilula` dos botões.

### Versões

| Arquivo | Quando usar |
| --- | --- |
| `logo-horizontal-cor` | **Versão principal.** Cabeçalho do app web, slides, documentos. |
| `logo-vertical-cor` | Espaços quadrados ou altos: splash do app, cartaz, camiseta. |
| `simbolo-cor` | Quando o nome já aparece por perto ou o espaço é pequeno. |
| `*-negativo` | Sobre `verde-horta` ou `verde-mata`: telhado e mesa em creme, broto e "Mesa" em milho. |
| `*-mono-escuro` | Impressão em uma cor, carimbo, fax, documentos oficiais. |
| `*-mono-branco` | Sobre fotos escuras ou cores fora da paleta. |
| `icone-app` | Ícone do app (Android/iOS) e PWA: símbolo negativo sobre `verde-horta`. |
| `avatar-redes` | Foto de perfil no Instagram, WhatsApp Business e similares. |
| `favicon` | Aba do navegador do painel web. |

As versões negativo e mono-branco aparecem "vazias" nos quadros claros desta página porque são claras; abra o arquivo sobre um fundo escuro.

### Área de proteção

Mantenha ao redor do logo um espaço livre igual à **altura do telhado do símbolo** (a distância da ponta do telhado até a mesa). Nada de texto, borda ou imagem dentro dessa área.

### Tamanho mínimo

- Logo horizontal: **120px** de largura na tela, **30mm** no impresso.
- Logo vertical: **72px** / **20mm**.
- Símbolo: **24px** / **8mm**. Abaixo disso, use o `favicon` (fundo verde, traços mais grossos em proporção).

### Não faça

- Não troque as cores do símbolo nem use o telhado em verde ou a mesa em terra.
- Não distorça, gire, contorne ou aplique sombra e degradê.
- Não reescreva o nome em outra fonte: use sempre os arquivos (o texto já está em curvas).
- Não coloque a versão colorida sobre `terra-tijolo`, `milho` ou fotos movimentadas: use negativo ou mono.
- Não separe o broto da casa nem use só o telhado como logo.

---

## 3. Cores

A paleta vem do próprio território: **verde da horta, tijolo das casas, milho da feira e o creme do papel kraft** das sacolas.

| Token | Claro | Papel |
| --- | --- | --- |
| `verde-horta` | #2F7D4F | Cor principal: botões, links, preços |
| `verde-mata` | #173D28 | Fundos escuros de marca |
| `terra-tijolo` | #D2572B | Telhado do logo, selos, formas |
| `milho` | #F2B630 | Destaques positivos e CTA sobre verde |
| `creme-100` | #FBF5EA | Fundo de página |
| `tinta` | #1E2B23 | Texto e mesa do logo |

**Proporção sugerida:** 60% creme (respiro), 25% verde (marca e ação), 10% tinta (texto), 5% terra + milho (destaques). O verde guia a ação; terra e milho só pontuam.

**Regras de uso**

- Texto pequeno: só `tinta`, `tinta-suave`, `verde-horta`, `verde-horta-forte`, `terra-texto` ou `erro` sobre `creme-100`/`creme-200` (todos ≥ 4,5:1).
- `terra-tijolo` é para formas e texto em negrito a partir de 19px; para texto menor use `terra-texto`.
- Sobre `milho`, texto sempre em `tinta`. Sobre `verde-horta` e `verde-mata`, texto em `creme-100` ou `milho`.
- O **Mutirão Cidadão** usa `terra-texto` como cor de identificação; a **Feira na Praça** usa `verde-horta`. Assim o morador sabe em que parte do app está.
- Estado nunca é só cor: erro tem ícone + texto, item selecionado tem marca de seleção.
- O tema escuro existe para o painel e para economia de bateria; a marca nasce no claro.

---

## 4. Tipografia

| Família | Uso | Por quê |
| --- | --- | --- |
| **Bricolage Grotesque** (`--font-display`) | Títulos, números grandes, peças de divulgação, nome do logo | Grotesca com personalidade e traço levemente "feito à mão": tem cara de cartaz de feira sem perder seriedade. |
| **Atkinson Hyperlegible** (`--font-texto`) | Todo o texto do app, botões, formulários | Criada pelo Braille Institute para máxima legibilidade: diferencia bem letras parecidas (I, l, 1; O, 0). Ideal para quem lê pouco na tela. |

Ambas são gratuitas (Google Fonts, licença OFL) e estão em `fonts/`. No Flutter, use o pacote `google_fonts` ou declare os arquivos `.ttf` no `pubspec.yaml`.

**Regras**

- Corpo do app em **17px**, nunca abaixo de **16px**; só `legenda` usa 14px.
- Títulos em Bricolage com tracking levemente negativo; texto corrido em Atkinson com tracking normal.
- No máximo dois pesos por tela (regular + negrito).
- Preços em `titulo-3` com `verde-horta`: "R$ 3,00", sempre com vírgula e centavos.

---

## 5. Tom de voz

Escreva como quem explica no balcão da feira: frase curta, palavra comum, verbo no começo.

**Princípios**

1. **Fale com a pessoa**: "você", nunca "o usuário" ou "o beneficiário".
2. **Uma ideia por frase**. Até 15 palavras sempre que der.
3. **Diga o próximo passo**: todo aviso termina com o que fazer.
4. **Sem sigla solta**: "CadÚnico (o cadastro do governo para programas sociais)" na primeira vez.
5. **Nunca prometa benefício**: a triagem sempre diz "**pode ter direito**" e orienta a confirmar no CRAS.
6. **Respeito, não pena**: a pessoa tem direito, não está pedindo favor.

| Faça | Evite |
| --- | --- |
| "Sua cesta está separada. Retire no sábado, das 8h às 13h." | "Seu pedido foi processado com sucesso e encontra-se disponível para retirada." |
| "Você pode ter direito à Tarifa Social. Leve RG, CPF e uma conta de luz." | "Você foi aprovado para a Tarifa Social!" |
| "Seu José colheu hoje cedo em Mogi das Cruzes." | "Produto de fornecedor parceiro." |
| "Não deu certo. Confira o número do celular e tente de novo." | "Erro 401: credenciais inválidas." |
| "Ajude quem precisa a ter acesso ao que é seu por direito." | "Ajude os carentes." |

**Palavras da marca:** praça, feira, cesta, vizinho, produtor, mesa, direito, retirar, separar, mutirão.
**Evite:** carente, necessitado, beneficiário, usuário, processar, solicitação, ecossistema (em texto para morador).

---

## 6. Iconografia

- Use **Material Symbols Rounded** (já vem no Flutter como `Icons.*_rounded`): traço arredondado conversa com o símbolo.
- Tamanho 24px no app; 28px em ações principais. Cor `tinta` ou a cor do módulo.
- Ícone nunca sozinho em ação importante: sempre com rótulo ("Mapa", "Cesta", "Direitos", "Retirar").
- Ícones-chave: `storefront` (feira), `shopping_basket` (cesta), `map` (mapa), `qr_code_2` (retirada), `volunteer_activism` (mutirão), `checklist` (documentos), `insights` (painel).

## 7. Grafismo e imagens

- **Grafismo de telhados**: o "chapéu" do telhado repetido em linha, alternando creme, milho e terra, vira faixa decorativa (veja `faixa-feira` e `post-mutirao`). Use em topo ou borda, nunca atrás de texto.
- **Fotos**: gente real da praça e da roça, luz natural, mãos e alimentos de perto. Pessoas em ação (escolhendo, colhendo, conversando), nunca posadas como "necessitadas".
- Peça autorização de imagem a todo morador e produtor fotografado; em crianças, só sem rosto identificável.
- Sem banco de imagem genérico, sem fruta "perfeita de estúdio": o alimento pode ser imperfeito, isso faz parte da proposta.

## 8. Interface (Flutter)

- Fundo `creme-100`, cartões `creme-200` com `raio-m` e `sombra-cartao`.
- Botão primário: `verde-horta`, texto `creme-100` em `rotulo`, `raio-pilula`, altura `alvo-toque` (48px).
- Botão secundário: contorno `verde-horta` 2px, texto `verde-horta`.
- Selo "pode ter direito": fundo `milho`, texto `tinta`, `raio-pilula`.
- Margem lateral `espaco-4`; entre cartões `espaco-6`.
- Mapa (flutter_map): pin da feira em `verde-horta` com o símbolo em creme.

```dart
final bairroNaMesa = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF2F7D4F),
    primary: const Color(0xFF2F7D4F),
    secondary: const Color(0xFFB4461C),
    tertiary: const Color(0xFFF2B630),
    surface: const Color(0xFFFBF5EA),
    onSurface: const Color(0xFF1E2B23),
    error: const Color(0xFFB42318),
  ),
  scaffoldBackgroundColor: const Color(0xFFFBF5EA),
  textTheme: GoogleFonts.atkinsonHyperlegibleTextTheme().apply(
    bodyColor: const Color(0xFF1E2B23),
  ),
);
```

## 9. Aplicações

- **Faixa da feira** (`faixa-feira`, 1500×500): lona na praça e capa de redes.
- **Post do mutirão** (`post-mutirao`, 1080×1080): divulgação no Instagram e WhatsApp.
- **Sacola de retirada**: kraft com logo vertical mono-escuro e o QR code da feira.
- **Camiseta de voluntário**: verde-mata com logo vertical negativo; nas costas, "Pode perguntar pra mim".
- **Placa do ponto de retirada**: milho com texto em tinta, "Retire sua cesta aqui", e o símbolo.
- **Pitch e vídeo**: slides em creme com títulos em Bricolage; abertura com o logo vertical sobre verde-horta.
