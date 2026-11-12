# Requisitos não funcionais

- **Usabilidade:** linguagem simples, poucos passos e ícones com texto; público com pouca familiaridade digital.
- **Acessibilidade básica:** contraste mínimo 4.5:1, áreas de toque de 48 dp, suporte a aumento de fonte do sistema sem overflow.
- **Responsividade:** adaptar conteúdo a diferentes dimensões sem overflow.
- **Manutenibilidade:** separar telas, models, services e widgets por feature.
- **Legibilidade:** nomenclatura padronizada e código formatado.
- **Robustez:** tratar erros de rede, respostas inválidas, listas vazias e produto esgotado.
- **Desempenho:** evitar rebuilds e requisições desnecessárias.
- **Privacidade (LGPD):** a renda da triagem não é armazenada no app nem registrada em logs; nome e telefone do pré-pedido trafegam só por HTTPS.
- **Segurança:** não versionar credenciais e validar dados externos.
- **Portabilidade:** trocar API publicada e mock alterando apenas a base URL.
- **Compatibilidade:** Flutter 3.44.1; validar em emulador Android no Windows 11.
