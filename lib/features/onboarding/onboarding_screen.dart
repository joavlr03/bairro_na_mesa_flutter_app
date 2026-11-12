import 'package:flutter/material.dart';

import '../../services/onboarding_preferences_service.dart';
import '../home/home_shell.dart';

class _Pagina {
  const _Pagina(this.icone, this.titulo, this.descricao);
  final IconData icone;
  final String titulo;
  final String descricao;
}

const _paginas = [
  _Pagina(
    Icons.storefront_rounded,
    'Feira perto de você',
    'Veja as feiras de agricultores que acontecem nas praças do seu bairro, com comida fresca e preço justo.',
  ),
  _Pagina(
    Icons.shopping_basket_rounded,
    'Monte sua cesta',
    'Escolha os produtos da semana, faça o pré-pedido e retire na praça com o seu QR code.',
  ),
  _Pagina(
    Icons.volunteer_activism_rounded,
    'Seus direitos na praça',
    'Descubra benefícios a que você pode ter direito e veja os documentos que precisa levar.',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  final _prefs = OnboardingPreferencesService();
  int _pagina = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _irPara(int i) => _controller.animateToPage(
    i,
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeInOut,
  );

  Future<void> _entrar({required bool salvar}) async {
    if (salvar) await _prefs.salvarPularOnboarding();
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeShell()));
  }

  @override
  Widget build(BuildContext context) {
    final ultima = _pagina == _paginas.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, top: 8),
                child: TextButton(
                  onPressed: () => _entrar(salvar: true),
                  child: const Text('Não mostrar novamente'),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _paginas.length,
                onPageChanged: (i) => setState(() => _pagina = i),
                itemBuilder: (_, i) => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.sizeOf(context).height * 0.6,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _paginas[i].icone,
                            size: 88,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          _paginas[i].titulo,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _paginas[i].descricao,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _paginas.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _pagina ? 28 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: i == _pagina
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: _pagina > 0
                          ? () => _irPara(_pagina - 1)
                          : null,
                      child: const Text('Voltar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: FilledButton(
                      onPressed: ultima
                          ? () => _entrar(salvar: false)
                          : () => _irPara(_pagina + 1),
                      child: Text(ultima ? 'Começar' : 'Avançar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
