import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  final ValueNotifier<List> tableStateNotifier = ValueNotifier([]);

  final Map<int, List<Map<String, String>>> _dataMap = {
    0: [
      {"name": "Café brasileiro", "type": "Arábica", "strength": "Médio"},
      {"name": "Café colombiano", "type": "Arábica", "strength": "Forte"},
      {"name": "Café turco", "type": "Robusta", "strength": "Muito forte"},
      {"name": "Café peruano", "type": "Arábica", "strength": "Médio"},
      {"name": "Café etíope", "type": "Arábica", "strength": "Forte"},
      {"name": "Café jamaicano", "type": "Arábica", "strength": "Médio"},
      {"name": "Café indonésio", "type": "Robusta", "strength": "Forte"},
      {"name": "Café guatemalteco", "type": "Arábica", "strength": "Forte"},
      {"name": "Café mexicano", "type": "Arábica", "strength": "Suave"},
      {"name": "Café hondurenho", "type": "Robusta", "strength": "Médio"}
      ],
    1: [
      {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
      {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
      {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
      {"name": "Guinness Draught", "style": "Irish Dry Stout", "ibu": "45"},
      {"name": "Tripel Karmeliet", "style": "Tripel", "ibu": "20"},
      {"name": "Rochefort 10", "style": "Quadrupel", "ibu": "27"},
      {"name": "Weihenstephaner Hefeweissbier", "style": "Hefeweizen", "ibu": "14"},
      {"name": "Founders Kentucky Breakfast Stout", "style": "Imperial Stout", "ibu": "70"},
      {"name": "Stone IPA", "style": "American IPA", "ibu": "77"},
      {"name": "Belhaven Scottish Ale", "style": "Scottish Ale", "ibu": "20"}
      ],
    2: [
      {"name": "Brasil", "continent": "América do Sul", "population": "213.8 milhões"},
      {"name": "China", "continent": "Ásia", "population": "1.4 bilhões"},
      {"name": "Índia", "continent": "Ásia", "population": "1.3 bilhões"},
      {"name": "Estados Unidos", "continent": "América do Norte", "population": "328.2 milhões"},
      {"name": "Indonésia", "continent": "Ásia", "population": "267.7 milhões"},
      {"name": "Paquistão", "continent": "Ásia", "population": "220.9 milhões"},
      {"name": "Bangladesh", "continent": "Ásia", "population": "164.7 milhões"},
      {"name": "Nigéria", "continent": "África", "population": "206.1 milhões"},
      {"name": "Rússia", "continent": "Europa/Ásia", "population": "144.5 milhões"},
      {"name": "Japão", "continent": "Ásia", "population": "126.5 milhões"},
      {"name": "México", "continent": "América do Norte", "population": "128.9 milhões"},
      {"name": "Filipinas", "continent": "Ásia", "population": "108.1 milhões"},
      {"name": "Etiópia", "continent": "África", "population": "114.9 milhões"},
      {"name": "Egito", "continent": "África", "population": "101.7 milhões"}

    ],
  };

  void carregar(int index) {
    tableStateNotifier.value = _dataMap[index] ?? [];
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DataService dataService = DataService();
  int _selectedIndex = 0;

  static const List<Map<String, dynamic>> _navBarItems = [
    {
      'label': 'Cafés',
      'icon': Icon(Icons.coffee_outlined),
      'columnNames': ['Nome', 'Tipo', 'Intensidade'],
      'propertyNames': ['name', 'type', 'strength'],
    },
    {
      'label': 'Cervejas',
      'icon': Icon(Icons.local_drink_outlined),
      'columnNames': ['Nome', 'Estilo', 'IBU'],
      'propertyNames': ['name', 'style', 'ibu'],
    },
    {
      'label': 'Nações',
      'icon': Icon(Icons.flag_outlined),
      'columnNames': ['Nome', 'Continente', 'População'],
      'propertyNames': ['name', 'continent', 'population'],
    },
  ];

  @override
  void initState() {
    super.initState();
    dataService.carregar(_selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      dataService.carregar(_selectedIndex);
    });
  }


  @override
  
  Widget build(BuildContext context) {
    final navBarItem = _navBarItems[_selectedIndex];

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dicas'),
        ),
        body: ValueListenableBuilder<List>(
          valueListenable: dataService.tableStateNotifier,
          builder: (context, value, child) {
            return DataTableWidget(
              jsonObjects: value,
              columnNames: navBarItem['columnNames'],
              propertyNames: navBarItem['propertyNames'],
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            for (var item in _navBarItems)
              BottomNavigationBarItem(
                label: item['label'],
                icon: item['icon'],
              ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}



class NewNavBar extends HookWidget {
  final void Function(int)? onItemSelected;

  NewNavBar({this.onItemSelected});

  @override
  
  Widget build(BuildContext context) {
    var state = useState(1);
    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          onItemSelected?.call(index);
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
            label: "Cervejas",
            icon: Icon(Icons.local_drink_outlined),
          ),
          BottomNavigationBarItem(
            label: "Nações",
            icon: Icon(Icons.flag_outlined),
          )
        ]);
  }
}



class DataTableWidget extends StatelessWidget {

  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget({this.jsonObjects = const [], this.columnNames = const [], this.propertyNames = const []});

  @override
  
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames
            .map(
              (name) => DataColumn(
                label: Expanded(child: Text(name, style: TextStyle(fontStyle: FontStyle.italic))),
              ),
            ).toList(),
        rows: jsonObjects
            .map(
              (obj) => DataRow(
                cells: propertyNames
                    .map(
                      (propName) => DataCell(Text(obj[propName] ?? "")),
                    ).toList(),
              ),
            ).toList()
          );
  }
}