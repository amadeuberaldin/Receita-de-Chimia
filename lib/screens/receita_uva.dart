import 'package:flutter/material.dart';

class ReceitaUvaScreen extends StatefulWidget {
  const ReceitaUvaScreen({super.key});

  @override
  State<ReceitaUvaScreen> createState() => _ReceitaUvaScreenState();
}

class _ReceitaUvaScreenState extends State<ReceitaUvaScreen> {
  final TextEditingController _controller = TextEditingController();

  double? _pesoPolpaUva;
  double? _acucar;

  void _calcular() {
    final texto = _controller.text.trim().replaceAll(',', '.');
    final peso = double.tryParse(texto);

    if (peso == null || peso <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite um peso válido para a polpa da uva.'),
        ),
      );
      return;
    }

    setState(() {
      _pesoPolpaUva = peso;
      _acucar = (peso * 700) / 1000;
    });
  }

  String _formatarGramas(double valor) {
    if (valor == valor.roundToDouble()) {
      return '${valor.toStringAsFixed(0)} g';
    }
    return '${valor.toStringAsFixed(1)} g';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doce de Uva',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _RecipeHeroCard(colorScheme: cs),
              const SizedBox(height: 16),
              const _InfoCard(
                title: 'Antes de pesar a polpa da uva',
                icon: Icons.info_outline,
                children: [
                  'Higienize as uvas com água e vinagre.',
                  'Depois enxágue bem.',
                  'Coloque as uvas em uma panela com 1 copo de água e leve ao fogo até ferver.',
                  'Se as uvas não tiverem sementes, bata normalmente no liquidificador.',
                  'Se tiverem sementes, use a função pulsar apenas 1 vez, no máximo 2, só para soltar as sementes.',
                  'Não bata demais, pois isso pode triturar as sementes e alterar o sabor da chimia.',
                  'Depois de soltar as sementes, coe a polpa para removê-las completamente.',
                  'Somente depois disso pese a polpa da uva que será usada na receita.',
                ],
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Calcular ingredientes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _controller,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Peso da polpa de uva (g)',
                          hintText: 'Ex: 1000',
                          prefixIcon: Icon(Icons.scale_outlined),
                        ),
                        onSubmitted: (_) => _calcular(),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _calcular,
                          icon: const Icon(Icons.calculate_outlined),
                          label: const Text('Calcular'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_pesoPolpaUva != null && _acucar != null)
                _IngredientsCard(
                  pesoPolpaUva: _pesoPolpaUva!,
                  acucar: _acucar!,
                  formatarGramas: _formatarGramas,
                ),
              if (_pesoPolpaUva != null) const SizedBox(height: 16),
              const _InfoCard(
                title: 'Processo de preparo',
                icon: Icons.menu_book_outlined,
                children: [
                  'Coloque a polpa da uva em uma panela.',
                  'Adicione o açúcar e o suco de 1 limão.',
                  'Cozinhe em fogo baixo.',
                  'Mexa sempre até atingir o ponto desejado.',
                  'Desligue o fogo e deixe esfriar antes de armazenar.',
                ],
              ),
              const SizedBox(height: 16),
              const _AttentionCard(),
              const SizedBox(height: 16),
              const _NutritionSummaryCard(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeHeroCard extends StatelessWidget {
  final ColorScheme colorScheme;

  const _RecipeHeroCard({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primaryContainer,
                  colorScheme.secondaryContainer,
                ],
              ),
            ),
            child: Center(
              child: SizedBox(
                height: 110,
                width: 110,
                child: Image.asset(
                  'assets/images/uva.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Doce de Uva',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Chimia tradicional de uva, preparada a partir da polpa já processada.',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> children;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: cs.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...children.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•  '),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          color: cs.onSurfaceVariant,
                        ),
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

class _AttentionCard extends StatelessWidget {
  const _AttentionCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Se a uva tiver sementes, use o liquidificador apenas para soltá-las. '
                  'Depois é essencial coar a polpa. '
                  'Bater demais pode triturar as sementes e comprometer o sabor da chimia.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IngredientsCard extends StatelessWidget {
  final double pesoPolpaUva;
  final double acucar;
  final String Function(double) formatarGramas;

  const _IngredientsCard({
    required this.pesoPolpaUva,
    required this.acucar,
    required this.formatarGramas,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingredientes calculados',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            _IngredientRow(
              label: 'Polpa de uva',
              value: formatarGramas(pesoPolpaUva),
            ),
            _IngredientRow(
              label: 'Açúcar',
              value: formatarGramas(acucar),
            ),
            const _IngredientRow(
              label: 'Limão',
              value: '1 unidade',
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.primaryContainer.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'Esses valores foram calculados com base no peso da polpa de uva já preparada.',
                style: TextStyle(
                  color: cs.onSurface,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IngredientRow extends StatelessWidget {
  final String label;
  final String value;

  const _IngredientRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionSummaryCard extends StatelessWidget {
  const _NutritionSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.local_fire_department_outlined),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Informação nutricional',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Valores aproximados da receita pronta.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Por 100 g',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            const _NutritionRow(label: 'Calorias', value: '200 kcal'),
            const _NutritionRow(label: 'Carboidratos', value: '52 g'),
            const _NutritionRow(label: 'Proteínas', value: '< 2 g'),
            const _NutritionRow(label: 'Fibra alimentar', value: '< 2 g'),
            const _NutritionRow(label: 'Açúcares', value: '50 g'),
            const _NutritionRow(label: 'Gorduras totais', value: '< 2 g'),
            const _NutritionRow(label: 'Gorduras saturadas', value: '< 1 g'),
            const _NutritionRow(label: 'Potássio', value: '112 mg'),
            const Divider(height: 28),
            const Text(
              'Porção de 5 g',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            const _NutritionRow(label: 'Calorias', value: '10 kcal'),
            const _NutritionRow(label: 'Carboidratos', value: '2,6 g'),
            const _NutritionRow(label: 'Proteínas', value: '< 0,1 g'),
            const _NutritionRow(label: 'Fibra alimentar', value: '< 0,1 g'),
            const _NutritionRow(label: 'Açúcares', value: '2,5 g'),
            const _NutritionRow(label: 'Gorduras totais', value: '< 0,1 g'),
            const _NutritionRow(label: 'Gorduras saturadas', value: '< 0,1 g'),
            const _NutritionRow(label: 'Potássio', value: '5,6 mg'),
          ],
        ),
      ),
    );
  }
}

class _NutritionRow extends StatelessWidget {
  final String label;
  final String value;

  const _NutritionRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
