import 'package:flutter/material.dart';

class ReceitaAbacaxiScreen extends StatefulWidget {
  const ReceitaAbacaxiScreen({super.key});

  @override
  State<ReceitaAbacaxiScreen> createState() => _ReceitaAbacaxiScreenState();
}

class _ReceitaAbacaxiScreenState extends State<ReceitaAbacaxiScreen> {
  final TextEditingController _controller = TextEditingController();

  double? _pesoAbacaxi;
  double? _acucar;
  double? _coco;

  void _calcular() {
    final texto = _controller.text.trim().replaceAll(',', '.');
    final peso = double.tryParse(texto);

    if (peso == null || peso <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite um peso válido para o abacaxi.'),
        ),
      );
      return;
    }

    setState(() {
      _pesoAbacaxi = peso;
      _acucar = (peso * 700) / 1000;
      _coco = (peso * 100) / 1000;
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
          'Abacaxi com Coco',
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
                title: 'Antes de pesar o abacaxi',
                icon: Icons.info_outline,
                children: [
                  'Descasque completamente o abacaxi.',
                  'Corte em pedaços pequenos.',
                  'Somente após esse preparo pese a quantidade que será utilizada na receita.',
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
                          labelText: 'Peso do abacaxi preparado (g)',
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
              if (_pesoAbacaxi != null && _acucar != null && _coco != null)
                _IngredientsCard(
                  pesoAbacaxi: _pesoAbacaxi!,
                  acucar: _acucar!,
                  coco: _coco!,
                  formatarGramas: _formatarGramas,
                ),
              if (_pesoAbacaxi != null) const SizedBox(height: 16),
              const _InfoCard(
                title: 'Modo de preparo',
                icon: Icons.menu_book_outlined,
                children: [
                  'Coloque os pedaços de abacaxi em uma panela.',
                  'Cozinhe em fogo baixo até começar a liberar líquido.',
                  'Vá mexendo até que os pedaços comecem a se desfazer.',
                  'Adicione o açúcar e misture bem.',
                  'Acrescente o suco de 1 limão.',
                  'Continue cozinhando em fogo baixo, mexendo sempre.',
                  'Quando a espuma começar a diminuir, adicione o coco ralado.',
                  'Mexa até atingir o ponto desejado.',
                  'Deixe esfriar antes de armazenar.',
                ],
              ),
              const SizedBox(height: 16),
              const _InfoCard(
                title: 'Dicas de preparo',
                icon: Icons.tips_and_updates_outlined,
                children: [
                  'Não adicione o açúcar enquanto os pedaços ainda estiverem grandes, pois pode caramelizar.',
                  'Após adicionar o açúcar e o limão, a chimia começará a espumar.',
                  'Se desejar uma chimia mais limpa e cristalina, retire a espuma com uma escumadeira.',
                  'Caso vá remover a espuma, espere que ela diminua antes de adicionar o coco ralado.',
                  'Mexa sempre para evitar que grude no fundo da panela.',
                  'O ponto ideal é quando a colher abre caminho no fundo da panela.',
                  'Depois de fria, a chimia fica mais firme do que durante o cozimento.',
                  'Se cozinhar demais, a chimia pode ficar muito dura.',
                ],
              ),
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
                  'assets/images/abacaxi.png',
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
                  'Abacaxi com Coco',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Chimia tradicional de abacaxi com coco ralado.',
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

class _IngredientsCard extends StatelessWidget {
  final double pesoAbacaxi;
  final double acucar;
  final double coco;
  final String Function(double) formatarGramas;

  const _IngredientsCard({
    required this.pesoAbacaxi,
    required this.acucar,
    required this.coco,
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
              label: 'Abacaxi',
              value: formatarGramas(pesoAbacaxi),
            ),
            _IngredientRow(
              label: 'Açúcar',
              value: formatarGramas(acucar),
            ),
            _IngredientRow(
              label: 'Coco ralado',
              value: formatarGramas(coco),
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
                'Esses valores foram calculados com base no peso do abacaxi já preparado.',
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
            const _NutritionRow(label: 'Calorias', value: '220 kcal'),
            const _NutritionRow(label: 'Carboidratos', value: '46 g'),
            const _NutritionRow(label: 'Proteínas', value: '< 2 g'),
            const _NutritionRow(label: 'Fibra alimentar', value: '< 2 g'),
            const _NutritionRow(label: 'Açúcares', value: '44 g'),
            const _NutritionRow(label: 'Gorduras totais', value: '4 g'),
            const _NutritionRow(label: 'Gorduras saturadas', value: '4 g'),
            const _NutritionRow(label: 'Vitamina C', value: '26 mg'),
            const Divider(height: 28),
            const Text(
              'Porção de 5 g',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            const _NutritionRow(label: 'Calorias', value: '11 kcal'),
            const _NutritionRow(label: 'Carboidratos', value: '2,3 g'),
            const _NutritionRow(label: 'Proteínas', value: '< 0,1 g'),
            const _NutritionRow(label: 'Fibra alimentar', value: '< 0,1 g'),
            const _NutritionRow(label: 'Açúcares', value: '2,2 g'),
            const _NutritionRow(label: 'Gorduras totais', value: '0,2 g'),
            const _NutritionRow(label: 'Gorduras saturadas', value: '0,2 g'),
            const _NutritionRow(label: 'Vitamina C', value: '1,3 mg'),
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
