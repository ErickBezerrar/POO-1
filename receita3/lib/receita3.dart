import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      theme: ThemeData(primarySwatch: Colors.deepPurple),

      debugShowCheckedModeBanner:false,

      home: Scaffold(

        appBar: CustomAppBar(title: 'Dicas', menuItems: <PopupMenuEntry<Color>>[

                PopupMenuItem<Color>(
                  value: Colors.black,
                  child: Text('Black'),
                ),
                PopupMenuItem<Color>(
                  value: Colors.green,
                  child: Text('Green'),
                ),
                PopupMenuItem<Color>(
                  value: Colors.red,
                  child: Text('Red'),
                ),
              ],
            ),

        body: DataBodyWidget(objects:[
          "La Fin Du Monde - Bock - 65 ibu",
          "Sapporo Premiume - Sour Ale - 54 ibu",
          "Duvel - Pilsner - 82 ibu"
        ]),

        bottomNavigationBar: NewNavBar(icons: [
          Icons.coffee_outlined,
          Icons.local_drink_outlined,
          Icons.flag_outlined,
        ]),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<PopupMenuEntry<Color>> menuItems;
  final AppBar appBar = AppBar();

  CustomAppBar({required this.title, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        PopupMenuButton<Color>(
          onSelected: (color) {
            // Faça algo com a cor selecionada
          },
          itemBuilder: (BuildContext context) => menuItems,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class NewNavBar extends StatelessWidget {
  final List<IconData> icons;

  NewNavBar({required this.icons});

  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: botaoFoiTocado,
      items: List.generate(
        icons.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(icons[index]),
          label: '',
        ),
      ),
    );
  }
}

class DataBodyWidget extends StatelessWidget {
  List<String> objects;

  DataBodyWidget({this.objects = const []});

  Expanded processarUmElemento(String obj) {
    return Expanded(
      child: Center(child: Text(obj)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: objects.map(
        (obj) => Expanded(
          child: Center(child: Text(obj)),
        ),
      ).toList(),
    );
  }
}