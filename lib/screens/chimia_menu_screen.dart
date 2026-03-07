import 'package:flutter/material.dart';
import 'package:receitas_familia_beraldin/screens/receita_abacaxi.dart';
import 'package:receitas_familia_beraldin/screens/receita_abobora.dart';
import 'package:receitas_familia_beraldin/screens/receita_morango.dart';
import 'package:receitas_familia_beraldin/screens/receita_uva.dart';
import 'package:receitas_familia_beraldin/screens/receita_goiaba.dart';

class ChimiaMenuScreen extends StatelessWidget {
  const ChimiaMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas de Chimia'),
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
              title: 'Receitas de Chimia',
              subtitle: 'Escolha uma receita para calcular as proporções.',
            ),
            const SizedBox(height: 14),
            _ReceitaCard(
              title: "Abóbora com Coco",
              subtitle:
                  "750g açúcar + 100g coco ralado para 1kg da polpa da abóbora",
              imagePath: "assets/images/abobora.png",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReceitaAboboraScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _ReceitaCard(
              title: "Doce de Uva",
              subtitle: "700g açúcar para 1kg de uvas",
              imagePath: "assets/images/uva.png",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReceitaUvaScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _ReceitaCard(
              title: "Doce de Morango",
              subtitle: "650g açúcar para 1kg de morangos",
              imagePath: "assets/images/morango.png",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReceitaMorangoScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _ReceitaCard(
              title: "Abacaxi com Coco",
              subtitle:
                  "700g açúcar + 100g coco para 1kg de abacaxi descascado",
              imagePath: "assets/images/abacaxi.png",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReceitaAbacaxiScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _ReceitaCard(
              title: "Doce de Goiaba",
              subtitle: "700g açúcar para 1kg de goiaba",
              imagePath: "assets/images/goiaba.png",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReceitaGoiabaScreen(),
                ),
              ),
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

class _ReceitaCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onTap;

  const _ReceitaCard({
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
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
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
                      style: TextStyle(color: cs.onSurfaceVariant),
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
