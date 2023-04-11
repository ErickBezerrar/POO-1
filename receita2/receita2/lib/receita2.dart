import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: NewScaffold(),
    );
  }
}

class NewNavBar extends StatelessWidget {
  const NewNavBar();

  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: botaoFoiTocado,
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

class MyBodyBox extends StatelessWidget {
  final Widget child;

  const MyBodyBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

class NewScaffold extends StatelessWidget {
  const NewScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dicas")),
      body: Column(
        children: [
          Expanded(
            child: MyBodyBox(
              child: const Text("La Fin Du Monde - Bock - 65 ibu"),
            ),
          ),
          Expanded(
            child: MyBodyBox(
              child: const Text("Sapporo Premiume - Sour Ale - 54 ibu"),
            ),
          ),
          Expanded(
            child: MyBodyBox(
              child: const Text("Duvel - Pilsner - 82 ibu"),
            ),
          )
        ],
      ),
      bottomNavigationBar: const NewNavBar(),
    );
  }
}

void main() {
  runApp(MyApp());
}
