import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',

      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),

      home: MyHomePage(title: 'Flutter Demo Home Page'),

    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dataObjects = [    
    {"name": "Cerveja 1", "style": "Estilo 1", "ibu": "10"},
    {"name": "Cerveja 2", "style": "Estilo 2", "ibu": "20"},    
    {"name": "Cerveja 3", "style": "Estilo 3", "ibu": "30"},    
    {"name": "Cerveja 4", "style": "Estilo 4", "ibu": "40"},    
    {"name": "Cerveja 5", "style": "Estilo 5", "ibu": "50"},    
    {"name": "Cerveja 6", "style": "Estilo 6", "ibu": "60"},    
    {"name": "Cerveja 7", "style": "Estilo 7", "ibu": "70"},    
    {"name": "Cerveja 8", "style": "Estilo 8", "ibu": "80"},    
    {"name": "Cerveja 9", "style": "Estilo 9", "ibu": "90"},    
    {"name": "Cerveja 10", "style": "Estilo 10", "ibu": "100"},  
  ];

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(widget.title),

      ),
      body: Center(

        child: MyTileWidget(dataObjects: dataObjects),

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

class MyTileWidget extends StatelessWidget {

  final List<Map<String, String>> dataObjects;

  MyTileWidget({required this.dataObjects});

  @override

  Widget build(BuildContext context) {

    return ListView.builder(

      itemCount: dataObjects.length,

      itemBuilder: (BuildContext context, int index) {

        final obj = dataObjects[index];

        return ListTile(

          title: Text(obj['name'] ?? ''),

          subtitle: Text('Estilo: ${obj['style'] ?? ''} - IBU: ${obj['ibu'] ?? ''}'),
          
        );
      },
    );
  }
}
