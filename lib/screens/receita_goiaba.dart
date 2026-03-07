import 'package:flutter/material.dart';

class ReceitaGoiabaScreen extends StatefulWidget {
  const ReceitaGoiabaScreen({super.key});

  @override
  State<ReceitaGoiabaScreen> createState() => _ReceitaGoiabaScreenState();
}

class _ReceitaGoiabaScreenState extends State<ReceitaGoiabaScreen> {
  final TextEditingController _pesoController = TextEditingController();

  double? pesoPolpa;
  double? acucar;

  void calcular() {
    final valor = double.tryParse(
      _pesoController.text.replaceAll(',', '.'),
    );

    if (valor == null || valor <= 0) return;

    setState(() {
      pesoPolpa = valor;
      acucar = valor * 0.7; // proporção 700g para 1000g
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chimia de Goiaba'),
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
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    cs.primaryContainer,
                    cs.secondaryContainer,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/goiaba.png",
                    height: 80,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Chimia de Goiaba",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Receita tradicional com aproveitamento da casca.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Texto inicial
            _infoCard(
              context,
              title: "Antes de pesar a polpa",
              content: const [
                "• Higienize bem as goiabas com água e vinagre.",
                "• Enxágue corretamente.",
                "• Corte as goiabas e separe a parte com as sementes.",
                "• Coloque a parte com sementes no liquidificador com 1 copo de água e pulse algumas vezes para soltar as sementes.",
                "• Coe para remover completamente as sementes.",
                "• Bata o restante da goiaba (com casca) com 1 copo de água.",
                "• Só depois pese a polpa obtida.",
              ],
            ),

            const SizedBox(height: 20),

            // Cálculo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Calcular ingredientes",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _pesoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Peso da polpa de goiaba (g)",
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: calcular,
                      child: const Text("Calcular"),
                    ),
                    if (pesoPolpa != null) ...[
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text(
                        "Ingredientes",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      _ingrediente("Polpa de goiaba", "$pesoPolpa g"),
                      _ingrediente("Açúcar", "${acucar!.toStringAsFixed(1)} g"),
                      _ingrediente("Suco de limão", "1 unidade"),
                    ]
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Modo de preparo
            _infoCard(
              context,
              title: "Modo de preparo",
              content: const [
                "1. Após separar e coar as sementes, pese a polpa da goiaba.",
                "2. Coloque a polpa na panela.",
                "3. Adicione o açúcar calculado e o suco de 1 limão.",
                "4. Cozinhe em fogo baixo, mexendo sempre.",
                "5. Deixe ferver até atingir o ponto desejado.",
                "6. O ponto ideal é quando a colher abre caminho no fundo da panela.",
                "7. Após esfriar, a chimia ficará mais firme.",
              ],
            ),

            const SizedBox(height: 20),

            // Informação nutricional
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Informação nutricional",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Text("Por 100 g"),
                    SizedBox(height: 6),
                    Text("Calorias: 205 kcal"),
                    Text("Carboidratos: 45 g"),
                    Text("Proteínas: 0,5 g"),
                    Text("Gorduras totais: 0,1 g"),
                    Text("Fibra alimentar: 1,8 g"),
                    Divider(height: 30),
                    Text("Porção de 5 g"),
                    SizedBox(height: 6),
                    Text("Calorias: 10 kcal"),
                    Text("Carboidratos: 2,3 g"),
                    Text("Proteínas: <0,1 g"),
                    Text("Gorduras totais: <0,1 g"),
                    Text("Fibra alimentar: 0,2 g"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _ingrediente(String nome, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(nome),
          Text(valor, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _infoCard(BuildContext context,
      {required String title, required List<String> content}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...content.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(e),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
