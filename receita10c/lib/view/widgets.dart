import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../data/data_service.dart';

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var state = useState(7);

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dicas"),
          actions: [
            PopupMenuButton(
              initialValue: state.value,
              itemBuilder: (_) => valores.map(
                (num) => PopupMenuItem(
                  value: num,
                  child: Text("Carregar $num itens por vez"),
                ),
              ).toList(),
              onSelected: (number) {
                state.value = number;
                dataService.numberOfItems = number;
              },
            ),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
                return Center(child: Text("Toque em algum botão"));
              case TableStatus.loading:
                return Center(child: CircularProgressIndicator());
              case TableStatus.ready:
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTableWidget(
                        jsonObjects: value['dataObjects'],
                        propertyNames: value['propertyNames'],
                        columnNames: value['columnNames'],
                      ),
                    ),
                  ),
                );
              case TableStatus.error:
                return Center(child: Text("Lascou"));
            }
            return Text("...");
          },
        ),
        bottomNavigationBar: NewNavBar(itemSelectedCallback: dataService.load),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  final Function(int) _itemSelectedCallback;

  NewNavBar({required Function(int) itemSelectedCallback})
      : _itemSelectedCallback = itemSelectedCallback;

  static const int indexCarros = 0;
  static const int indexBarcos = 1;
  static const int indexFilmes = 2;

  @override
  Widget build(BuildContext context) {
    var state = useState(indexCarros);

    return BottomNavigationBar(
      onTap: (index) {
        state.value = index;
        _itemSelectedCallback(index);
      },
      currentIndex: state.value,
      items: [
        BottomNavigationBarItem(
          label: "Carros",
          icon: Icon(Icons.car_crash_outlined),
        ),
        BottomNavigationBarItem(
          label: "Barcos",
          icon: Icon(Icons.directions_boat_outlined),
        ),
        BottomNavigationBarItem(
          label: "Filmes",
          icon: Icon(Icons.movie_outlined),
        ),
      ],
    );
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
      columns: columnNames.map(
        (name) => DataColumn(
          onSort: (columnIndex, ascending) => dataService.sortCurrentState(propertyNames[columnIndex]),
          label: Expanded(
            child: Text(name, style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ),
      ).toList(),
      rows: jsonObjects.map(
        (obj) => DataRow(
          cells: propertyNames.map(
            (propName) => DataCell(Text(obj[propName])),
          ).toList(),
        ),
      ).toList(),
    );
  }
}
