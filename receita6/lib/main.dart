import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  final ValueNotifier<List<Map<String, String>>> tableStateNotifier = new ValueNotifier([]);
  int currentIndex = 0;

  void carregar(index) {
    currentIndex = index;
    if (index == 0) {
      carregarCafes();
    } else if (index == 1) {
      carregarCervejas();
    } else if (index == 2) {
      carregarNacoes();
    }
  }

  void carregarCervejas() {
    tableStateNotifier.value = [
      {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},    ];
  }

  void carregarCafes() {
    tableStateNotifier.value = [
      {"name": "Café Brasil", "style": "Arábica", "torra": "Média"},    ];
  }

  void carregarNacoes() {
    tableStateNotifier.value = [
      {
       "name": "Brasil", 
       "capital": "Brasília", 
       "populacao": "211 milhões"
      },    
    ];
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final DataService dataService = DataService();
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dicas"),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (dataService.currentIndex) {
              case 0:
                return DataTableWidget(
                  jsonObjects: dataService.tableStateNotifier.value,
                  propertyNames: ["name", "style", "torra"],
                  columnNames: ["Nome", "Estilo", "Torra"],
                );
              case 1:
                return DataTableWidget(
                  jsonObjects: dataService.tableStateNotifier.value,
                  propertyNames: ["name", "style", "ibu"],
                  columnNames: ["Nome", "Estilo", "IBU"],
                );
              case 2:
                return DataTableWidget(
                  jsonObjects: dataService.tableStateNotifier.value,
                  propertyNames: ["name", "capital", "populacao"],
                  columnNames: ["País", "Capital", "População"],
                );
              default:
                return Container();
            }
          },
        ),
        bottomNavigationBar: NewNavBar(
          itemSelectedCallback: dataService.carregar,
          currentIndex: dataService.currentIndex,
        ),
      ),
    );
  }
}


class NewNavBar extends HookWidget {
  final Function(int) itemSelectedCallback;
  final int currentIndex; 

  NewNavBar({required this.itemSelectedCallback, required this.currentIndex}); 

  @override
  Widget build(BuildContext context) {
    final state = useState<int>(1);
    return BottomNavigationBar(
      onTap: (index) {
        state.value = index;
        itemSelectedCallback(index);
      },
      currentIndex: currentIndex, 
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
        ),
      ],
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget({
    this.jsonObjects = const [],
    this.columnNames = const ["Nome", "Estilo", "IBU"],
    this.propertyNames = const ["name", "style", "ibu"],
  });

  DataTableWidget.cafes({
    required this.jsonObjects,
    this.columnNames = const ["Nome", "Estilo", "Torra"],
    this.propertyNames = const ["name", "style", "torra"],
  });

  DataTableWidget.nacoes({
    required this.jsonObjects,
    this.columnNames = const ["Nome", "Capital", "População"],
    this.propertyNames = const ["name", "capital", "populacao"],
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnNames
          .map(
            (name) => DataColumn(
              label: Expanded(
                child: Text(name, style: TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
          )
          .toList(),
      rows: jsonObjects
          .map(
            (obj) => DataRow(
              cells: propertyNames
                  .map(
                    (propName) => DataCell(
                      Text(obj[propName]),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
