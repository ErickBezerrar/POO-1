import 'package:flutter/material.dart';

void main() {
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
                  "https://i.ytimg.com/vi/G_zDUTFJfcY/maxresdefault.jpg"),
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