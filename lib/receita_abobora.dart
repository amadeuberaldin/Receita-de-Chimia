import 'package:flutter/material.dart';

class ReceitaAboboraScreen extends StatefulWidget {
  @override
  _ReceitaAboboraScreenState createState() => _ReceitaAboboraScreenState();
}

class _ReceitaAboboraScreenState extends State<ReceitaAboboraScreen> {
  final TextEditingController _controller = TextEditingController();
  String result = '';

  void calculateProportions() {
    double pumpkinWeight = double.tryParse(_controller.text) ?? 0;
    double sugar = (pumpkinWeight * 750) / 1000;
    double coconut = (pumpkinWeight * 150) / 1000;

    setState(() {
      result = 'Para $pumpkinWeight g de abóbora, use $sugar g de açúcar e $coconut g de coco ralado.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abóbora com Coco'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso da Abóbora (g)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateProportions,
              child: Text('Calcular'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
