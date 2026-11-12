// Mock da API Bairro na Mesa (mesmo contrato de docs/api/api-documentation.md).
// Uso: node mock/server.js   (porta 3000). Dados fictícios.
const http = require('http');

const feiras = [
  { id: 1, praca: 'Praça das Flores', bairro: 'Jardim Exemplo', diaSemana: 'SABADO', horarioInicio: '08:00', horarioFim: '13:00', distanciaKm: 0.4, temMutirao: true },
  { id: 2, praca: 'Praça do Coreto', bairro: 'Vila Exemplo', diaSemana: 'SABADO', horarioInicio: '07:00', horarioFim: '12:00', distanciaKm: 1.2, temMutirao: false },
  { id: 3, praca: 'Praça da Matriz', bairro: 'Parque Exemplo', diaSemana: 'DOMINGO', horarioInicio: '08:00', horarioFim: '12:00', distanciaKm: 2.0, temMutirao: true },
  { id: 4, praca: 'Praça Esperança', bairro: 'Conjunto Exemplo', diaSemana: 'QUARTA', horarioInicio: '16:00', horarioFim: '20:00', distanciaKm: 3.5, temMutirao: false },
];

const ofertas = [
  { id: 10, produto: 'Alface crespa', categoria: 'VERDURAS', unidade: 'maço', preco: 2.5, estoque: 30, produtor: 'Horta Comunitária Exemplo' },
  { id: 11, produto: 'Tomate', categoria: 'LEGUMES', unidade: 'kg', preco: 6.0, estoque: 20, produtor: 'Sítio Exemplo · Mogi das Cruzes' },
  { id: 12, produto: 'Banana prata', categoria: 'FRUTAS', unidade: 'dúzia', preco: 5.0, estoque: 15, produtor: 'Sítio Exemplo · Mogi das Cruzes' },
  { id: 13, produto: 'Couve', categoria: 'VERDURAS', unidade: 'maço', preco: 3.0, estoque: 0, produtor: 'Horta Comunitária Exemplo' },
];

const mutiroes = [
  { id: 1, horario: '09:00', tipo: 'CadÚnico (CRAS)' },
  { id: 2, horario: '10:30', tipo: 'Tarifa Social' },
];

const SALARIO_MINIMO = 1621; // 2026 — confirmar o valor vigente
const pedidos = new Map();

function enviar(res, status, corpo) {
  res.writeHead(status, { 'Content-Type': 'application/json; charset=utf-8', 'Access-Control-Allow-Origin': '*' });
  res.end(JSON.stringify(corpo));
}

function lerCorpo(req) {
  return new Promise((ok) => {
    let dados = '';
    req.on('data', (c) => (dados += c));
    req.on('end', () => {
      try { ok(JSON.parse(dados || '{}')); } catch { ok(null); }
    });
  });
}

http.createServer(async (req, res) => {
  if (req.method === 'OPTIONS') { res.writeHead(204, { 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Headers': 'Content-Type' }); return res.end(); }
  const url = new URL(req.url, 'http://localhost');
  const p = url.pathname;
  let m;

  if (req.method === 'GET' && p === '/api/feiras') return enviar(res, 200, feiras);
  if (req.method === 'GET' && (m = p.match(/^\/api\/feiras\/(\d+)\/ofertas$/))) {
    const cat = url.searchParams.get('categoria');
    return enviar(res, 200, ofertas.filter((o) => !cat || o.categoria === cat));
  }
  if (req.method === 'GET' && p.match(/^\/api\/feiras\/(\d+)\/mutiroes$/)) return enviar(res, 200, mutiroes);

  if (req.method === 'POST' && p === '/api/pedidos') {
    const b = await lerCorpo(req);
    if (!b || !b.nome || !b.telefone || !Array.isArray(b.itens) || !b.itens.length) {
      return enviar(res, 400, { mensagem: 'Informe nome, telefone e ao menos um item.' });
    }
    let total = 0;
    for (const i of b.itens) {
      const o = ofertas.find((x) => x.id === i.ofertaId);
      if (!o || o.estoque < i.quantidade) return enviar(res, 400, { mensagem: `Produto esgotado: ${o ? o.produto : i.ofertaId}.` });
      total += o.preco * i.quantidade;
    }
    const codigo = `BNM-${String(pedidos.size + 1).padStart(4, '0')}`;
    const pedido = { codigo, total, status: 'AGUARDANDO_RETIRADA' };
    pedidos.set(codigo, pedido);
    return enviar(res, 201, pedido);
  }
  if (req.method === 'GET' && (m = p.match(/^\/api\/pedidos\/(.+)$/))) {
    const pedido = pedidos.get(m[1]);
    return pedido ? enviar(res, 200, pedido) : enviar(res, 404, { mensagem: 'Pedido não encontrado.' });
  }

  if (req.method === 'POST' && p === '/api/triagem') {
    const b = await lerCorpo(req);
    if (!b) return enviar(res, 400, { mensagem: 'Dados inválidos.' });
    // Regras: CadÚnico = renda familiar total de até 3 salários mínimos.
    // Isenção/Tarifa Social da conta de luz = estar inscrito no CadÚnico
    // (quem tem direito ao CadÚnico, portanto, também pode ter à tarifa social).
    const beneficios = [];
    const direitoCadUnico = Number(b.rendaFamiliar) <= 3 * SALARIO_MINIMO;
    if (!b.temCadUnico && direitoCadUnico) {
      beneficios.push({ nome: "Cadastro no CadÚnico", mensagem: "Cadastro que dá acesso a vários programas do governo.", documentos: ["Documentos de todos da casa", "comprovante de endereço"] });
    }
    if (b.temCadUnico || direitoCadUnico) {
      beneficios.push({ nome: "Tarifa Social de Energia", mensagem: b.temCadUnico ? "Desconto na conta de luz para quem está no CadÚnico." : "Desconto na conta de luz. Vale depois de entrar no CadÚnico.", documentos: ["RG ou CPF", "conta de luz", "comprovante de endereço"] });
    }
    return enviar(res, 200, { beneficios }); // renda usada só no cálculo, nunca guardada
  }

  if (req.method === 'GET' && p === '/api/impacto') {
    return enviar(res, 200, { familiasAtendidas: 128, kgVendidos: 1250, rendaProdutores: 8450, kgDesperdicioEvitado: 310, beneficiosSolicitados: 42 });
  }

  enviar(res, 404, { mensagem: 'Não encontrado.' });
}).listen(3000, () => console.log('Mock Bairro na Mesa em http://localhost:3000'));
