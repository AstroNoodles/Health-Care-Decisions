import 'package:flutter/material.dart';
import 'treatment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Care Decisions',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: "Health Care Decisions"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Align(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        alignment: Alignment.topLeft,
        child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.all(10), child:
          Text("Select the treatments to review below", textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold))),
          Expanded(child:
            GridView.count(crossAxisCount: 4, children: List.generate(100, (index) {
              return Center(
                child: Card(child: InkWell(splashColor: Colors.blue, onTap: () {print('Card Tapped');
                },
                child: Container(width: 400, height: 400, child: Column(children: <Widget>[
                  Checkbox(value: false, onChanged: null),
                  Text("Tap me, I am number $index")]
                )
                )
                ),
                ),
              );
          }),)),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext builder) => MyTreatment(title: title)));
            },
            tooltip: 'Go to next page',
            child: Icon(Icons.arrow_forward),
          ),
          ])
    )
    );
  }
}