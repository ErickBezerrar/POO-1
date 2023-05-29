import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error, noConnection }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'columnNames': ["Nome", "Estilo", "IBU"],
  });

  void carregar(int index) {
    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes];

    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'columnNames': [],
    };

    funcoes[index]();
  }

  void carregarCafes() {
    var cafesUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/coffee/random_coffee',
      queryParameters: {'size': '5'},
    );

    http.get(cafesUri).then((response) {
      if (response.statusCode == 200) {
        var cafesJson = jsonDecode(response.body) as List<dynamic>;
        tableStateNotifier.value = {
          'status': TableStatus.ready,
          'dataObjects': cafesJson,
          'columnNames': ["Nome", "Origem", "Intensidade"],
        };
      } else {
        tableStateNotifier.value = {
          'status': TableStatus.error,
          'dataObjects': [],
          'columnNames': [],
        };
      }
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.noConnection,
        'dataObjects': [],
        'columnNames': [],
      };
    });
  }

  Future<void> carregarNacoes() async {
    var nationsUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/nation/random_nation',
      queryParameters: {'size': '5'},
    );

    try {
      var response = await http.get(nationsUri);
      if (response.statusCode == 200) {
        var nationsJson = jsonDecode(response.body) as List<dynamic>;
        tableStateNotifier.value = {
          'status': TableStatus.ready,
          'dataObjects': nationsJson,
          'columnNames': ["Nome", "Capital", "População"],
        };
      } else {
        tableStateNotifier.value = {
          'status': TableStatus.error,
          'dataObjects': [],
          'columnNames': [],
        };
      }
    } catch (error) {
      tableStateNotifier.value = {
        'status': TableStatus.noConnection,
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

    http.get(beersUri).then((response) {
      if (response.statusCode == 200) {
        var beersJson = jsonDecode(response.body) as List<dynamic>;
        tableStateNotifier.value = {
          'status': TableStatus.ready,
          'dataObjects': beersJson,
          'columnNames': ["Nome", "Estilo", "IBU"],
        };
      } else {
        tableStateNotifier.value = {
          'status': TableStatus.error,
          'dataObjects': [],
          'columnNames': [],
        };
      }
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.noConnection,
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
          title: const Text("Dicas"),
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
                            "Bem-vindo ao meu aplicativo!\nToque em um botão para começar.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
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
                  columnNames: value['columnNames'],
                );
              case TableStatus.error:
                return Text("Ocorreu um erro");
              case TableStatus.noConnection:
                return Text("Sem conexão de rede");
              default:
                return Text("...");
            }
          },
        ),
        bottomNavigationBar: NewNavBar(itemSelectedCallback: dataService.carregar),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  final Function(int) itemSelectedCallback;

  NewNavBar({required this.itemSelectedCallback});

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
      onTap: (index) {
        state.value = index;
        itemSelectedCallback(index);
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
        ),
      ],
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List<dynamic> jsonObjects;
  final List<String> columnNames;

  const DataTableWidget({
    Key? key,
    required this.jsonObjects,
    required this.columnNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: columnNames
                .map((columnName) => DataColumn(label: Text(columnName)))
                .toList(),
            rows: jsonObjects
                .map((jsonObject) => DataRow(
                      cells: jsonObject.entries
                          .map((entry) => DataCell(
                                Text(entry.value.toString()),
                              ))
                          .toList(),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
