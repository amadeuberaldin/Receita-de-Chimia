import 'package:flutter/material.dart';

class ReceitaAbacaxiScreen extends StatefulWidget {
  const ReceitaAbacaxiScreen({super.key});
  @override
  ReceitaAbacaxiState createState() => ReceitaAbacaxiState();
}

class ReceitaAbacaxiState extends State<ReceitaAbacaxiScreen> {
  final TextEditingController _controller = TextEditingController();
  String result = '';

  void calculateProportions() {
    double pineapleWeight = double.tryParse(_controller.text) ?? 0;
    double sugar = (pineapleWeight * 750) / 1000;
    double coconut = (pineapleWeight * 150) / 1000;

    setState(() {
      result = '''
Para:
- $pineapleWeight g de Abacaxi
- $sugar g de açúcar
- $coconut g de coco ralado

Modo de preparo:
1. Ponha a polpa do Abacaxi em uma panela.
2. Adicione o açúcar.
3. Cozinhe em fogo baixo, mexendo sempre, até que a mistura fique consistente.
4. Adicione o coco ralado
5. Deixe esfriar antes de armazenar.
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doce de Abacaxi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso do Abacaxi (g)',
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
