import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) => MaterialApp(

    title: 'Starbucks Cardápio',

    theme: ThemeData(

      primarySwatch: Colors.green,

    ),

    home: MyHomePage(title: 'Starbucks', dataObjects: getDataObjects()),

  );

  List<Map<String, dynamic>> getDataObjects() {
    // Aqui podemos retornar uma lista de objetos JSON
    // de qualquer tipo que desejarmos, com as propriedades
    // que quisermos.
    return [          

      {"name": "Café Latte", "style": "Expresso, leite vaporizado e espuma de leite", "Preço": "10"},
      {"name": "Café Filtrado", "style": "Preparado no método tradicional:filtro de papel", "Preço": "20"},    
      {"name": "Espresso Tradicional ou Macchiato", "style": "Espresso tradicional ou com espuma de leite", "Preço": "12,50"},    
      {"name": "Avelã", "style": "Espresso com leite e um toque de avelã, finalizado com chantilly e calda de chocolate", "Preço": "16,50"},    
      {"name": "Brigadeiro", "style": "Espresso com leite, finalizado com chocolate granulado", "Preço": "8,50"},    
      {"name": "Café Americano", "style": "Espresso suavizado com água quente", "Preço": "14,75"},    
      {"name": "Café com Leite", "style": "Café preparado em filtro de papel com leite vaporizado", "Preço": "13,80"},    
      {"name": "Flat white", "style": "Espresso ristretto com leite vaporizado", "Preço": "9,50"},    
      {"name": "Café Mocha", "style": "Calda de chocolate ou chocolate branco espresso, leite vaporizado e um toque de chantilly", "Preço": "12,75"},    
      {"name": "Doce de Leite", "style": "Leite vaporizado, calda de doce de leite. Espresso, finalizado com chantilly e calda de caramelo", "Preço": "100"},
      {"name": "Cappuccino Tradicional", "style": "Espresso com leite cremoso", "Preço": "9,50"},
      {"name": "Cappuccino Canela", "style": "Espresso, um toque de canela e leite cremoso, finalizado com pitadas de canela em pó", "Preço": "12,50"},
    ];

  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key? key, required this.title, required this.dataObjects}) : super(key: key);

  final String title;
  final List<Map<String, dynamic>> dataObjects;

  @override

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(widget.title),

      ),
      body: Center(

        child: DataBodyWidget(dataObjects: widget.dataObjects),

      ),
      bottomNavigationBar: BottomNavigationBar(

        items: [

          BottomNavigationBarItem(icon: Icon(Icons.coffee_outlined), label: 'Café'),
          BottomNavigationBarItem(icon: Icon(Icons.local_drink_outlined), label: 'Bebidas'),
          BottomNavigationBarItem(icon: Icon(Icons.flag_outlined), label: 'Países'),

        ],
      ),
    );
  }
}

class DataBodyWidget extends StatelessWidget {

  final List<Map<String, dynamic>> dataObjects;

  const DataBodyWidget({Key? key, required this.dataObjects}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return ListView(

      children: [

        for (final obj in dataObjects)

          ListTile(

            title: Text(obj['name'] ?? ''),
            
            // Aqui podemos exibir as propriedades que quisermos,
            // com o texto que quisermos. É possível usar condicionais,
            // formatação, etc.
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('style: ${obj['style'] ?? ''}'),
                Text('Preço: ${obj['Preço'] ?? ''}'),
              ],
            ),
            
          ),
      ],
    );
  }
}