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
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Nome em String'),
                  TextField(
                    controller: _controladorNome,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Quantidade em Int'),
                  TextField(
                    controller: _controladorQuantidade,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Valor em Float'),
                  TextField(
                    controller: _controladorValor,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Cadastrar'),
                onPressed: () {
                  final String nome = _controladorNome.text;
                  final int quantidade =
                      int.tryParse(_controladorQuantidade.text) ?? 0;
                  final double valor =
                      double.tryParse(_controladorValor.text) ?? 0.0;
                  final Produto produtoNovo =
                      Produto(nome, quantidade, valor);
                  print(produtoNovo);
                },
              ),
            ],
          ),
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

  @override
  String toString() {
    return 'Produto{nome: $nome, quantidade: $quantidade, valor: $valor}';
  }
}
