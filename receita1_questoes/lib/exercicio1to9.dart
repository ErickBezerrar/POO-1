import 'package:flutter/material.dart';

void exercicio1to9() {
  MaterialApp app = MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue),
    home: Scaffold(
      appBar: AppBar(title: Text("Somewhere Only We Know - A love music")),
      body: Center(
        child: Column(
          children: [
            FadeInImage(
              placeholder: AssetImage('assets/placeholder_image.png'),
              image: NetworkImage(
                  "data:image/jpeg;base64,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"),
              height: 200,
              width: 200,
            ),
            const Text("I walked across an empty land", style: TextStyle(fontStyle: FontStyle.italic)),
            const Text("I knew the pathway like the back of my hand", style: TextStyle(fontStyle: FontStyle.italic)),
            const Text("I felt the earth beneath my feet", style: TextStyle(fontStyle: FontStyle.italic)),
            const Text("Sat by the river and it made me complete", style: TextStyle(fontStyle: FontStyle.italic)),
            const Text("-------------------------------------------------"),
            const Text("Oh simple thing where have you gone", style: TextStyle(fontStyle: FontStyle.italic)),
            const Text("I'm getting old", style: TextStyle(fontStyle: FontStyle.italic)),
            const Text("And I need something to rely on", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("So tell me when you're gonna let me in", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("I'm getting tired", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("And I need somewhere to begin", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("-------------------------------------------------"),
            const Text("I came across a fallen tree", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("I felt the branches of it looking at me", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("Is this the place we used to love?", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("Is this the place that I've been dreaming of?", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("-------------------------------------------------"),
            const Text("Oh simple thing where have you gone", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("I'm getting old", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("And I need something to rely on", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("So tell me when you're gonna let me in", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("I'm getting tired", style: TextStyle(fontStyle: FontStyle.italic)),     
            const Text("And I need somewhere to begin", style: TextStyle(fontStyle: FontStyle.italic)), 
          ]
        )
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            child: Row(
              children:[
                Icon(Icons.thumb_up),
                Text(' Gostei 1'),
              ],
            ),
            onPressed: () { 
            },
          ),
          ElevatedButton(
            child: Row(
              children:[
                Icon(Icons.thumb_up),
                Text(' Mais ou menos'),
              ],
            ),
            onPressed: () {
            },
          ),
          ElevatedButton(
            child: Row(
              children:[
                Icon(Icons.thumb_down),
                Text(' Deslike'),
              ],
            ),
            onPressed: () { 
            },
          ),
        ],
      ),
    ),
  );

  runApp(app);
}