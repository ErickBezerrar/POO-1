import 'package:flutter/material.dart';

class NewNavBar extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final void Function(int) onItemSelected;

  NewNavBar({
    required this.icons,
    required this.labels,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onItemSelected,
      items: icons.asMap().entries.map((entry) {
        final index = entry.key;
        final icon = entry.value;
        final label = labels[index];
        return BottomNavigationBarItem(
          icon: Icon(icon),
          label: label,
        );
      }).toList(),
    );
  }
}

class NovoEscafold extends StatelessWidget {
  NovoEscafold();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // adiciona centralização horizontal
      children: [
        Expanded(
          child: Center(
            child: Text("La Fin Du Monde - Bock - 65 ibu"),
          ),
        ),
        Expanded(
          child: Center(
            child: Text("Sapporo Premiume - Sour Ale - 54 ibu"),
          ),
        ),
        Expanded(
          child: Center(
            child: Text("Duvel - Pilsner - 82 ibu"),
          ),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  final List<IconData> navBarIcons = [
    Icons.coffee_outlined,
    Icons.local_drink_outlined,
    Icons.flag_outlined,
  ];
  final List<String> navBarLabels = [
    'Café',
    'Bebidas',
    'Países',
  ];

  MyApp();

  void _onNavBarItemSelected(int index) {
    print("Outlier: $index");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tudo sobre',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tudo sobre'),
        ),
        body: NovoEscafold(),
        bottomNavigationBar: NewNavBar(
          icons: navBarIcons,
          labels: navBarLabels,
          onItemSelected: _onNavBarItemSelected,
        ),
      ),
    );
  }
}
