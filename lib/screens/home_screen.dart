import 'package:flutter/material.dart';
import 'package:receitas_de_chimia/screens/chimia_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showAppMenu(BuildContext context, Offset position) async {
    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: const [
        PopupMenuItem(
          value: 'sobre',
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Sobre'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        PopupMenuItem(
          value: 'github',
          child: ListTile(
            leading: Icon(Icons.code),
            title: Text('GitHub'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );

    if (!context.mounted) return;

    if (selected == 'sobre') {
      showAboutDialog(
        context: context,
        applicationName: 'Receitas de Chimia',
        applicationVersion: '1.0.0',
        applicationLegalese: 'Desenvolvido por Amadeu Beraldin',
      );
    } else if (selected == 'github') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Depois vamos ligar seu GitHub aqui.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Início',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.more_vert),
                tooltip: 'Menu',
                onPressed: () {
                  final RenderBox button =
                      context.findRenderObject() as RenderBox;
                  final RenderBox overlay = Navigator.of(context)
                      .overlay!
                      .context
                      .findRenderObject() as RenderBox;

                  final Offset position =
                      button.localToGlobal(Offset.zero, ancestor: overlay);

                  _showAppMenu(context, position);
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceContainerHighest,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const _HomeHeader(
              title: 'Meu Livro de Receitas',
              subtitle:
                  'Escolha uma categoria para acessar suas receitas e cálculos.',
            ),
            const SizedBox(height: 14),
            _CategoryCard(
              title: 'Receitas de Chimia',
              subtitle: 'Chimias tradicionais com cálculo por peso',
              imagePath: 'assets/images/chimia.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChimiaMenuScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _CategoryCard(
              title: 'Receitas Fit',
              subtitle: 'Receitas saudáveis com controle nutricional',
              imagePath: 'assets/images/receita_fit.png',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Receitas Fit será adicionada em breve.'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _CategoryCard(
              title: 'Outras Receitas',
              subtitle: 'Novas categorias em breve',
              imagePath: 'assets/images/working.png',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Outras Receitas será adicionada em breve.'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _HomeHeader({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cs.primaryContainer,
            cs.secondaryContainer,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
