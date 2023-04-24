import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorQuantidade = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CADASTRO DE PRODUTO'),
        ),
        body: Column(
          children: <Widget>[
            TextField( controller: _controladorNome,),
            TextField( controller: _controladorQuantidade,),
            TextField( controller: _controladorValor,),
            ElevatedButton(
              child: Text('Cadastrar'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class Produto {
  final String nome;
  final int quantidade;
  final double valor;

  Produto(
    this.nome,
    this.quantidade,
    this.valor,
  );
}