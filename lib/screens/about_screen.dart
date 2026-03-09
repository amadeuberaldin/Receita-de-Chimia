import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sobre',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cs.surface,
              cs.surfaceContainerHighest,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          cs.primaryContainer,
                          cs.secondaryContainer,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 56,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Receitas da Família Beraldin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Receitas tradicionais com preparo detalhado e cálculo por peso.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _AboutInfoRow(
                          icon: Icons.person_outline,
                          title: 'Autor',
                          subtitle: 'Amadeu Beraldin',
                        ),
                        SizedBox(height: 12),
                        _AboutInfoRow(
                          icon: Icons.android_outlined,
                          title: 'Versão',
                          subtitle: '1.0.0',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sobre o projeto',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Este aplicativo foi criado para organizar receitas reais de família, '
                      'padronizar proporções e facilitar o preparo de chimias e outras receitas artesanais.',
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.code),
                title: const Text('GitHub'),
                subtitle: const Text('Copiar link do projeto'),
                trailing: const Icon(Icons.copy),
                onTap: () async {
                  await Clipboard.setData(
                    const ClipboardData(
                      text:
                          'https://github.com/amadeuberaldin/Receita-de-Chimia',
                    ),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Link do GitHub copiado.'),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Apoio ao projeto',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Se este app for útil para você, no futuro haverá uma forma simples de apoiar o projeto e incentivar novas receitas e melhorias.',
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _AboutInfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: cs.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
