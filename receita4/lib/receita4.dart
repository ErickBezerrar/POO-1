import 'package:flutter/material.dart';


class DataBodyWidget extends StatelessWidget {

  List objects;

  DataBodyWidget( {this.objects = const [] });



  @override

  Widget build(BuildContext context) {

    var columnNames = ["Nome","Estilo","IBU"],

        propertyNames = ["name", "style", "ibu"];

  
    return DataTable(

      columns: columnNames.map( 

                (name) => DataColumn(

                  label: Expanded(

                    child: Text(name, style: TextStyle(fontStyle: FontStyle.italic))

                  )

                )

              ).toList()       

      ,
      rows: objects.map( 

        (obj) => DataRow(

            cells: propertyNames.map(

              (propName) => DataCell(Text(obj[propName]))

            ).toList()

          )

        ).toList());

  }

}