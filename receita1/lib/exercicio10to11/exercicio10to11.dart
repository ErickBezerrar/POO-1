import 'package:flutter/material.dart';

void exercicio10to11() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cervejas'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Nome',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Estilo',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'IBU',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: const <DataRow>[
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Stella Artois')),
                    DataCell(Text('Belgian Lager')),
                    DataCell(Text('5')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Guinness')),
                    DataCell(Text('Irish Stout')),
                    DataCell(Text('4.2')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Sierra Nevada Pale Ale')),
                    DataCell(Text('American Pale Ale')),
                    DataCell(Text('5.6')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Duvel Triple Hop')),
                    DataCell(Text('Belgian IPA')),
                    DataCell(Text('9.5')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Weihenstephaner Hefeweissbier')),
                    DataCell(Text('German Hefeweizen')),
                    DataCell(Text('5.4')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Chimay Grande Réserve')),
                    DataCell(Text('Belgian Strong Ale')),
                    DataCell(Text('9')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Pilsner Urquell')),
                    DataCell(Text('Czech Pilsner')),
                    DataCell(Text('4.4')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Tripel Karmeliet')),
                    DataCell(Text('Belgian Tripel')),
                    DataCell(Text('8.4')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('La Trappe Quadrupel')),
                    DataCell(Text('Dutch Quadrupel')),
                    DataCell(Text('10')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Rochefort 10')),
                    DataCell(Text('Belgian Quad')),
                    DataCell(Text('11.3')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Westvleteren 12')),
                    DataCell(Text('Belgian Quadrupel')),
                    DataCell(Text('10.2')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Founders Breakfast Stout')),
                    DataCell(Text('Imperial Stout')),
                    DataCell(Text('8.3')),
                ],
            ),
            DataRow(
                cells: <DataCell>[
                    DataCell(Text('Stone IPA')),
                    DataCell(Text('American IPA')),
                    DataCell(Text('6.9')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
