import 'package:flutter/material.dart';
import 'package:receitas_de_chimia/receita_abobora.dart';
import 'package:receitas_de_chimia/receita_uva.dart';
import 'package:receitas_de_chimia/receita_abacaxi.dart';
import 'package:receitas_de_chimia/receita_morango.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Receitas de Chimia',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas de Chimia'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReceitaAboboraScreen()),
                );
              },
              child: const Text('Abóbora com Coco'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReceitaUvaScreen()),
                );
              },
              child: const Text('Doce de Uva'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReceitaMorangoScreen()),
                );
              },
              child: const Text('Doce de Morango'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReceitaAbacaxiScreen()),
                );
              },
              child: const Text('Abacaxi com Coco'),
            ),
          ],
        ),
      ),
    );
  }
}

