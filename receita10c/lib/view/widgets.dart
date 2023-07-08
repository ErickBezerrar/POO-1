import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../data/data_service.dart';

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: MyAppBar(),
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
                return Text("Lascou");
            }
            return Text("...");
          },
        ),
        bottomNavigationBar:
            NewNavBar(itemSelectedCallback: dataService.carregar),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  final _itemSelectedCallback;

  NewNavBar({itemSelectedCallback})
      : _itemSelectedCallback = itemSelectedCallback ?? (int) {}

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
      onTap: (index) {
        state.value = index;
        _itemSelectedCallback(index);
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

class DataTableWidget extends HookWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget(
      {this.jsonObjects = const [],
      this.columnNames = const [],
      this.propertyNames = const []});

  @override
  Widget build(BuildContext context) {
    final sortAscending = useState(true);
    final sortColumnIndex = useState(1);

    return DataTable(
      sortAscending: sortAscending.value,
      sortColumnIndex: sortColumnIndex.value,
      columns: columnNames.map(
        (name) {
          return DataColumn(
            onSort: (columnIndex, ascending) {
              sortColumnIndex.value = columnIndex;
              sortAscending.value = !sortAscending.value;

              dataService.ordenarEstadoAtual(
                  propertyNames[columnIndex], sortAscending.value);
            },
            label: Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold, // Definindo o texto em negrito
                ),
              ),
            ),
          );
        },
      ).toList(),
      rows: jsonObjects.map(
        (obj) {
          return DataRow(
            cells: propertyNames.map(
              (propName) {
                return DataCell(Text(obj[propName]));
              },
            ).toList(),
          );
        },
      ).toList(),
    );
  }
}

class MyAppBar extends HookWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = useState(7);

    return AppBar(
      actions: [
        Flexible(
          child: TextField(
            onChanged: (value) {
              print('New text: $value');
              dataService.filtrarEstadoAtual(value);
            },
            style: TextStyle(
              fontWeight: FontWeight.bold, // Definindo o texto em negrito
            ),
            decoration: InputDecoration(
              hintText: 'Digite algo...',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white, // Alterando a cor da borda
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors
                      .blue, // Alterando a cor da borda quando o campo está em foco
                ),
              ),
              filled: true,
              fillColor:
                  Colors.white, // Alterando a cor do campo de texto preenchido
            ),
          ),
        ),
        PopupMenuButton(
          initialValue: state.value,
          itemBuilder: (_) => valores.map(
            (num) {
              return PopupMenuItem(
                value: num,
                child: Text(
                  "Carregar $num itens por vez",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Definindo o texto em negrito
                  ),
                ),
              );
            },
          ).toList(),
          onSelected: (number) {
            state.value = number;
            dataService.numberOfItems = number;
          },
        ),
      ],
    );
  }
}
