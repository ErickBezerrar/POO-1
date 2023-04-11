import 'package:flutter/material.dart';

class NewNavBar extends StatelessWidget {
  NewNavBar();

  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(onTap: botaoFoiTocado, items: const [

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

      )
    ]);
  }
}

class NovoEscafold extends StatelessWidget {
  NovoEscafold();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // adiciona centralização horizontal
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
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tudo sobre',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tudo sobre'),
        ),
        body: NovoEscafold(),
        bottomNavigationBar: NewNavBar(),
      ),
    );
  }
}
