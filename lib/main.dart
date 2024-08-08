import 'package:flutter/material.dart';
import 'receita_abobora.dart'; // Criaremos este arquivo a seguir

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas de Chimia',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas de Chimia'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReceitaAboboraScreen()),
                );
              },
              child: Text('Abóbora com Coco'),
            ),
            // Adicione mais botões aqui para outras receitas
          ],
        ),
      ),
    );
  }
}
