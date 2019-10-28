import 'package:flutter/material.dart';
import 'package:spider_chart/spider_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

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
  double validityScale = 2,
      patientScale = 2,
      externalScale = 2,
      effectScale = 2,
      pScale = 2;
  String effectOrdinal = "Medium",
      pOrdinal = "(p < 0.05)",
      patientValues = "Neutral",
      externalValidity = "Neutral",
      internalLabel = "Medium Risk";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.assistant), onPressed: () => _showDialog(context))
      ]),
      body: Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Treatment Title",
                      style:
                          TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 5,
                      height: 20,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Evidence",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("Internal Validity",
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Slider(
                                value: validityScale,
                                divisions: 3,
                                onChanged: (double newVal) {
                                  setState(() {
                                    validityScale = newVal;
                                    switch (validityScale.round()) {
                                      case 0:
                                        internalLabel = "None";
                                        break;
                                      case 1:
                                        internalLabel = "Low Risk";
                                        break;
                                      case 2:
                                        internalLabel = "Medium Risk";
                                        break;
                                      case 3:
                                        internalLabel = "High Risk";
                                        break;
                                    }
                                  });
                                },
                                activeColor: Colors.cyan[100],
                                min: 0,
                                max: 3,
                                label: internalLabel,
                              ),
                              Text("${validityScale.toInt()}"),
                            ],
                          ),
                          Text("Effect Size",
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Slider(
                                  value: effectScale,
                                  divisions: 3,
                                  onChanged: (double newVal) {
                                    setState(() {
                                      effectScale = newVal;
                                      switch (effectScale.round()) {
                                        case 0:
                                          effectOrdinal = "None";
                                          break;
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
                                  max: 3,
                                  label: effectOrdinal,
                                ),
                                Text(effectOrdinal),
                              ]),
                          Text(
                            "p Value",
                            style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Slider(
                                  value: pScale,
                                  divisions: 3,
                                  onChanged: (double newVal) {
                                    setState(() {
                                      pScale = newVal;
                                      switch (pScale.round()) {
                                        case 0:
                                          pOrdinal = "N/A";
                                          break;
                                        case 1:
                                          pOrdinal = "(p > 0.05)";
                                          break;
                                        case 2:
                                          pOrdinal = "(p < 0.05)";
                                          break;
                                        case 3:
                                          pOrdinal = "(p < 0.01)";
                                          break;
                                      }
                                    });
                                  },
                                  activeColor: Colors.cyan[100],
                                  min: 0,
                                  max: 3,
                                  label: pOrdinal,
                                ),
                                Text(pOrdinal),
                              ]),
                          SizedBox(
                            width: 4,
                            height: 10,
                          ),
                          Text(
                            "Patient Values",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Slider(
                                value: patientScale,
                                divisions: 3,
                                onChanged: (double newVal) {
                                  setState(() {
                                    patientScale = newVal;
                                    switch (patientScale.round()) {
                                      case 0:
                                        patientValues = "None";
                                        break;
                                      case 1:
                                        patientValues = "Negative";
                                        break;
                                      case 2:
                                        patientValues = "Neutral";
                                        break;
                                      case 3:
                                        patientValues = "Positive";
                                        break;
                                    }
                                  });
                                },
                                activeColor: Colors.cyan[100],
                                min: 0,
                                max: 3,
                                label: patientValues,
                              ),
                              Text(patientValues),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "External Validity",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Slider(
                                value: externalScale,
                                divisions: 3,
                                onChanged: (double newVal) {
                                  setState(() {
                                    externalScale = newVal;
                                    switch (externalScale.round()) {
                                      case 0:
                                        externalValidity = "None";
                                        break;
                                      case 1:
                                        externalValidity = "Low";
                                        break;
                                      case 2:
                                        externalValidity = "Neutral";
                                        break;
                                      case 3:
                                        externalValidity = "High";
                                        break;
                                    }
                                  });
                                },
                                activeColor: Colors.cyan[100],
                                min: 0,
                                max: 3,
                                label: externalValidity,
                              ),
                              Text(externalValidity),
                            ],
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ButtonTheme(
                            textTheme: ButtonTextTheme.normal,
                            buttonColor: Colors.lightBlueAccent,
                            focusColor: Colors.blueAccent,
                            child: FlatButton(
                                onPressed: () => _saveData(),
                                child: Text(
                                  "Save",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ))),
                        Padding(padding: EdgeInsets.only(right: 100)),
                        SpiderChart(
                            size: Size(100, 200),
                            data: [
                              validityScale,
                              effectScale,
                              pScale,
                              patientScale,
                              externalScale
                            ],
                            colors: [
                              Colors.red,
                              Colors.blue,
                              Colors.green,
                              Colors.orange,
                              Colors.purple
                            ],
                            maxValue: 3)
                      ],
                    )
                  ])
            ],
          )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  buildPortraitOrientation() {}

  _showDialog(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("Quality of a Study"),
            content: Text(
                "The quality of a study is defined by its validity, ability to be repeated and the amount of errors."),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Close"))
            ],
          );
        });
  }

  _saveData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs
      ..setDouble("internalValidity", validityScale)
      ..setDouble("patientScale", patientScale)
      ..setDouble("effectSize", effectScale)
      ..setDouble("pValue", pScale)
      ..setDouble("externalScale", externalScale);
  }
}
