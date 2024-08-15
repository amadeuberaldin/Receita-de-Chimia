import 'package:flutter/material.dart';

class ReceitaAboboraScreen extends StatefulWidget {
  const ReceitaAboboraScreen({super.key});
  @override
  ReceitaAboboraScreenState createState() => ReceitaAboboraScreenState();
}

class ReceitaAboboraScreenState extends State<ReceitaAboboraScreen> {
  final TextEditingController _controller = TextEditingController();
  String result = '';

  void calculateProportions() {
    double pumpkinWeight = double.tryParse(_controller.text) ?? 0;
    double sugar = (pumpkinWeight * 750) / 1000;
    double coconut = (pumpkinWeight * 100) / 1000;

    setState(() {
      result = '''
Para:
- $pumpkinWeight g de Abobora
- $sugar g de açúcar
- $coconut g de coco ralado

Modo de preparo:
1. Ponha a polpa da Abobora em uma panela.
2. Adicione o açúcar.
3. Adicione o suco de um limão
4. Cozinhe em fogo baixo, mexendo sempre, até que a mistura fique consistente.
5. Adicione o coco ralado
6. Deixe esfriar antes de armazenar.
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abóbora com Coco'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso da Abóbora (g)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateProportions,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
