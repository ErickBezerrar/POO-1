import 'package:flutter/material.dart';

void main() {
  runApp(
    Builder(
      builder: (BuildContext context) => MyApp(context),
    ),
  );
}


class MyApp extends StatelessWidget {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorQuantidade = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();
  final BuildContext context;

  MyApp(this.context);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CADASTRO DE PRODUTO'),
        ),
        body: Builder(
          builder: (BuildContext scaffoldContext) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Nome'),
                    TextField(
                      controller: _controladorNome,
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Quantidade(INT)'),
                          TextField(
                            controller: _controladorQuantidade,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Valor(FLOAT)'),
                          TextField(
                            controller: _controladorValor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Limpar'),
                        onPressed: () {
                          _controladorNome.clear();
                          _controladorQuantidade.clear();
                          _controladorValor.clear();
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Dados de exemplo'),
                        onPressed: () {
                          _controladorNome.text = 'Produto exemplo';
                          _controladorQuantidade.text = '10';
                          _controladorValor.text = '9.99';
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Cadastrar'),
                  onPressed: () {
                    _processarFormulario(scaffoldContext);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _processarFormulario(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Formulário sendo processado...'),
      ),
    );

    final String nome = _controladorNome.text;
    final int quantidade = int.tryParse(_controladorQuantidade.text) ?? 0;
    final double valor = double.tryParse(_controladorValor.text) ?? 0.0;
    final Produto produtoNovo = Produto(nome, quantidade, valor);
    print(produtoNovo);
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
