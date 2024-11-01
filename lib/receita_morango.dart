import 'package:flutter/material.dart';

class ReceitaMorangoScreen extends StatefulWidget {
  const ReceitaMorangoScreen({super.key});
  @override
  ReceitaMorangoScreenState createState() => ReceitaMorangoScreenState();
}

class ReceitaMorangoScreenState extends State<ReceitaMorangoScreen> {
  final TextEditingController _controller = TextEditingController();
  String result = '';

  void calculateProportions() {
    double strawberryWeight = double.tryParse(_controller.text) ?? 0;
    double sugar = (strawberryWeight * 650) / 1000;

    setState(() {
      result = '''
Para:
- $strawberryWeight g de Morango
- $sugar g de açúcar

Modo de preparo:
1. Ponha a polpa do morango em uma panela.
2. Adicione o açúcar.
3. Adicione o suco de um limão
4. Cozinhe em fogo baixo, mexendo sempre, até que a mistura fique consistente.
5. Deixe esfriar antes de armazenar.
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doce de Morango'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso da Uva (g)',
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
