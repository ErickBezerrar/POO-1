import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
  });

  void carregar(int index) {
    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes];

    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
    };

    funcoes[index]();
  }

  void carregarCafes() {
    var coffeesUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/coffee/random_coffee',
      queryParameters: {'size': '5'},
    );

    http.read(coffeesUri).then((jsonString) {
      var coffeesJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': coffeesJson,
        'columnNames': ['Nome', 'Origem', 'Variedade', 'Notas', 'Intensidade'],
        'propertyNames': [
          'blend_name',
          'origin',
          'variety',
          'notes',
          'intensifier'
        ],
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    });
  }

  void carregarNacoes() async {
    try {
      var nationsUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/nation/random_nation',
        queryParameters: {'size': '5'},
      );

      var jsonString = await http.read(nationsUri);
      var nationsJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': nationsJson,
        'columnNames': ['Nacionalidade', 'Idioma', 'Capital', 'Esporte Nac.'],
        'propertyNames': [
          'nationality',
          'language',
          'capital',
          'national_sport'
        ]
      };
    } catch (error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    }
  }

  void carregarCervejas() {
    var beersUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/beer/random_beer',
      queryParameters: {'size': '5'},
    );

    http.read(beersUri).then((jsonString) {
      var beersJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': beersJson,
        'columnNames': ['Nome', 'Estilo', 'IBU'],
        'propertyNames': ['name', 'style', 'ibu'],
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    });
  }
}

final dataService = DataService();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tabelas"),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://www.bemcolar.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/l/e/letreiro-3d-decorativo-bem-vindo.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 200),
                          Text(
                            "Bem-vindo ao meu aplicativo!!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  offset: Offset(0, 0),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              case TableStatus.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case TableStatus.ready:
                return DataTableWidget(
                  jsonObjects: value['dataObjects'],
                  propertyNames: value['propertyNames'],
                  columnNames: value['columnNames'],
                );
              case TableStatus.error:
                return Text("Ocorreu um erro");
              default:
                return Text("...");
            }
          },
        ),
        bottomNavigationBar:
            NewNavBar(itemSelectedCallback: dataService.carregar),
      ),
    );
  }
}

class NewNavBar extends StatelessWidget {
  final Function(int) itemSelectedCallback;

  NewNavBar({required this.itemSelectedCallback});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        itemSelectedCallback(index);
      },
      items: const [
        BottomNavigationBarItem(
          label: "Cafés",
          icon: Icon(Icons.local_cafe),
        ),
        BottomNavigationBarItem(
          label: "Cervejas",
          icon: Icon(Icons.local_drink),
        ),
        BottomNavigationBarItem(
          label: "Nações",
          icon: Icon(Icons.public),
        ),
      ],
    );
  }
}

class DataTableWidget extends StatefulWidget {
  final List<dynamic> jsonObjects;
  final List<String> propertyNames;
  final List<String> columnNames;

  DataTableWidget({
    required this.jsonObjects,
    required this.propertyNames,
    required this.columnNames,
  });

  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  int? _sortColumnIndex;
  bool _isColumnSortedAscending = true;

  void sortDataObjects(int columnIndex) {
    setState(() {
      if (columnIndex == 0) {
        if (_isColumnSortedAscending) {
          widget.jsonObjects.sort((a, b) => a[widget.propertyNames[columnIndex]]
              .compareTo(b[widget.propertyNames[columnIndex]]));
        } else {
          widget.jsonObjects.sort((a, b) => b[widget.propertyNames[columnIndex]]
              .compareTo(a[widget.propertyNames[columnIndex]]));
        }
        _isColumnSortedAscending = !_isColumnSortedAscending;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: List<DataColumn>.generate(
              widget.columnNames.length,
              (index) => DataColumn(
                label: Text(
                  widget.columnNames[index],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onSort: (columnIndex, ascending) {
                  sortDataObjects(columnIndex);
                },
                tooltip: 'Sort',
              ),
            ),
            rows: List<DataRow>.generate(
              widget.jsonObjects.length,
              (index) => DataRow(
                cells: List<DataCell>.generate(
                  widget.propertyNames.length,
                  (cellIndex) => DataCell(
                    Text(widget.jsonObjects[index]
                            [widget.propertyNames[cellIndex]]
                        .toString()),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
