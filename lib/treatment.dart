import 'package:flutter/material.dart';
import 'package:spider_chart/spider_chart.dart';


class MyTreatment extends StatefulWidget {
  MyTreatment({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyTreatmentState createState() => _MyTreatmentState();
}

class _MyTreatmentState extends State<MyTreatment> {
  int _counter = 0;
  double qualityScale = 2,
      clinicianScale = 2,
      patientScale = 2,
      effectScale = 2,
      pScale = 2;
  String effectOrdinal = "Medium",
      pOrdinal = "Statistically Significant (p < 0.05)",
      clinicianOrdinal = "Fair",
      patientOrdinal = "Fair";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.title),
      ),
      body: Align(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        alignment: Alignment.topLeft,
        child: Row(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text("Treatment Title",
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            SizedBox(width: 5, height: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10), child:
                Text("Evidence", style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold),),),
                Text("Quality", style: TextStyle(
                    fontSize: 15, decoration: TextDecoration.underline)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Slider(
                      value: qualityScale,
                      divisions: 4,
                      onChanged: (double newVal) {
                        setState(() {
                          qualityScale = newVal;
                        });
                      },
                      activeColor: Colors.cyan[100],
                      min: 1,
                      max: 5,
                      label: "${qualityScale.toInt()}",),
                    Text("${qualityScale.toInt()}"),
                    IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () => _showDialog(context),
                      iconSize: 30,)
                  ],
                ),
                Text("Effect Size", style: TextStyle(
                    fontSize: 15, decoration: TextDecoration.underline)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Slider(
                        value: effectScale,
                        divisions: 2,
                        onChanged: (double newVal) {
                          setState(() {
                            effectScale = newVal;
                            switch (effectScale.round()) {
                              case 1:
                                effectOrdinal = "Small";
                                break;
                              case 2:
                                effectOrdinal = "Medium";
                                break;
                              case 3:
                                effectOrdinal = "Large";
                                break;
                            }
                          });
                        },
                        activeColor: Colors.cyan[100],
                        min: 0,
                        max: 5,
                        label: effectOrdinal,),
                      Text(effectOrdinal),

                    ]
                ),
                Text("p Value", style: TextStyle(
                    fontSize: 15, decoration: TextDecoration.underline),),
                Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Slider(
                        value: pScale,
                        divisions: 2,
                        onChanged: (double newVal) {
                          setState(() {
                            pScale = newVal;
                            switch (pScale.round()) {
                              case 1:
                                pOrdinal =
                                "Not Very Significant (p > 0.05)";
                                break;
                              case 2:
                                pOrdinal =
                                "Statistically Significant (p < 0.05)";
                                break;
                              case 3:
                                pOrdinal =
                                "Very Statistically Significant (p < 0.01)";
                                break;
                            }
                          });
                        },
                        activeColor: Colors.cyan[100],
                        min: 0,
                        max: 5,
                        label: pOrdinal,),
                      Text(pOrdinal, softWrap: true,),
                    ]),
                SizedBox(width: 4, height: 50,),
                Text("Clinician Values", style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Slider(
                      value: clinicianScale,
                      divisions: 2,
                      onChanged: (double newVal) {
                        setState(() {
                          clinicianScale = newVal;
                          switch (clinicianScale.round()) {
                            case 1:
                              clinicianOrdinal = "Poor";
                              break;
                            case 2:
                              clinicianOrdinal = "Fair";
                              break;
                            case 3:
                              clinicianOrdinal = "Good";
                              break;
                          }
                        });
                      },
                      activeColor: Colors.cyan[100],
                      min: 0,
                      max: 5,
                      label: clinicianOrdinal,),
                    Text(clinicianOrdinal),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10), child:
                Text("Patient Values", style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold),),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Slider(
                      value: patientScale,
                      divisions: 2,
                      onChanged: (double newVal) {
                        setState(() {
                          patientScale = newVal;
                          switch (patientScale.round()) {
                            case 1:
                              patientOrdinal = "Poor";
                              break;
                            case 2:
                              patientOrdinal = "Fair";
                              break;
                            case 3:
                              patientOrdinal = "Good";
                              break;
                          }
                        });
                      },
                      activeColor: Colors.cyan[100],
                      min: 0,
                      max: 5,
                      label: patientOrdinal,),
                    Text(patientOrdinal),
                  ],
                ),
              ]
          ),
              Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                SpiderChart(size: Size(100, 200), data: [qualityScale, effectScale, pScale, clinicianScale, patientScale],
                    colors: [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple], maxValue: 5)
              ],)
        ]

        )
        ],

      )
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _showDialog(BuildContext ctx){
    return showDialog(context: ctx, builder: (BuildContext context) {
      return AlertDialog(title: Text("Quality of a Study"),
        content: Text("The quality of a study is defined by its validity, ability to be repeated and the amount of errors."),
      actions: <Widget>[
        FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text("Close"))
      ],);
    });
  }
}