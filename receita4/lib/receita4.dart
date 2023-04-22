import 'package:flutter/material.dart';

var dataObjects = [
    {
        "name": "La Fin Du Monde",
        "style": "Bock",
        "ibu": "65"
    },  
    {
        "name": "Sapporo Premiume",
        "style": "Sour Ale",
        "ibu": "54"
    },
    {
        "name": "Duvel",
        "style": "Pilsner",
        "ibu": "82"
    },
    {
        "name": "Heineken",
        "style": "Lager",
        "ibu": "23"
    },
    {
        "name": "Stella Artois",
        "style": "Belgian Pilsner",
        "ibu": "25"
    },
    {
        "name": "Guinness",
        "style": "Stout",
        "ibu": "45"
    },
    {
        "name": "Corona",
        "style": "American Lager",
        "ibu": "19"
    },
    {
        "name": "Budweiser",
        "style": "American Lager",
        "ibu": "12"
    },
    {
        "name": "Carlsberg",
        "style": "Pilsner",
        "ibu": "30"
    },
    {
        "name": "Asahi",
        "style": "Lager",
        "ibu": "18"
    },
    {
        "name": "Coors Banquet",
        "style": "American Lager",
        "ibu": "10"
    },
    {
        "name": "Amstel",
        "style": "Lager",
        "ibu": "21"
    },
    {
        "name": "Chimay",
        "style": "Belgian Dubbel",
        "ibu": "20"
    },
    {
        "name": "Miller",
        "style": "American Lager",
        "ibu": "04"
    },
    {
        "name": "Beck's",
        "style": "German Pilsner",
        "ibu": "20"
    },
    {
        "name": "Duvel",
        "style": "Belgian Strong Ale",
        "ibu": "30"
    },
];

void main() {
//   MyApp app = MyApp();
  ModifiedApp app = ModifiedApp();

  runApp(app);
}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: ThemeData(primarySwatch: Colors.green),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                appBar: AppBar(
                    title: const Text("Restaurante do Zé - Cervejas"),
                ),
                body: Center(
                    child: 
                        SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataBodyWidget(objects: dataObjects, columnNames: ["Nome", "Estilo", "IBU"], propertyNames: ["name", "style", "ibu"])
                        )
                ),                
                bottomNavigationBar: NewNavBar(),
            )
        );
    }
}

class ModifiedApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: ThemeData(primarySwatch: Colors.green),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                appBar: AppBar(
                    title: const Text("Restaurante do Zé - Cervejas do Menu"),
                ),
                body: Center(
                    child: MyTileWidget(objects: dataObjects, columnNames: ["Nome", "Estilo", "IBU"], propertyNames: ["name", "style", "ibu"])
                ),                
                bottomNavigationBar: NewNavBar(),
            )
        );
    }
}

class NewNavBar extends StatelessWidget {
  const NewNavBar();

  void _onButtonPressed(int index) {
    print("Botão $index pressionado");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onButtonPressed,
      items: const [
        BottomNavigationBarItem(
          label: "Cafés",
          icon: Icon(Icons.coffee_outlined),
        ),
        BottomNavigationBarItem(
          label: "Cervejas", 
          icon: Icon(Icons.local_drink_outlined)
        ),
        BottomNavigationBarItem(
          label: "Nações", 
          icon: Icon(Icons.flag_outlined)
        ),
      ],
    );
  }
}

class DataBodyWidget extends StatelessWidget {
  final List<Map<String, dynamic>> objects;
  final List<String> columnNames;
  final List<String> propertyNames;

  const DataBodyWidget({
    this.objects = const [],
    this.columnNames = const [],
    this.propertyNames = const [],
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: List.generate(
        columnNames.length,
        (index) => DataColumn(
          label: Expanded(
            child: Text(
              columnNames[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      rows: List.generate(
        objects.length,
        (index) => DataRow(
          cells: List.generate(
            propertyNames.length,
            (cellIndex) => DataCell(
              Text(
                objects[index][propertyNames[cellIndex]].toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class MyTileWidget extends StatelessWidget {
    List<Map<String, dynamic>> objects;
    final List<String> columnNames;
    final List<String> propertyNames;

    MyTileWidget({this.objects = const [], this.columnNames = const [], this.propertyNames = const []});

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: objects.length,
            itemBuilder: (context, index) {
                final obj = objects[index];

                final columnTexts = columnNames.map((col) {
                    final prop = propertyNames[columnNames.indexOf(col)];
                    return Text("$col: ${obj[prop]}");
                }).toList();

                return ListTile(
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: columnTexts,
                    ),
                );
            },
        );
    }
}