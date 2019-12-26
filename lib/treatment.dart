import 'package:flutter/material.dart';
import 'package:spider_chart/spider_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class MyTreatment extends StatefulWidget {
  MyTreatment(this.index, {Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final int index;

  @override
  _MyTreatmentState createState() => _MyTreatmentState();
}

class _MyTreatmentState extends State<MyTreatment> {
  double validityScale = 2, effectScale = 2, pScale = 2, externalScale = 2, patientScale = 2;
  String effectOrdinal = "Medium",
      pOrdinal = "(p < 0.05)",
      patientValues = "Neutral",
      externalValidity = "Neutral",
      internalLabel = "Medium Risk";

  void getOriginalStates() async {
    var prefs = await SharedPreferences.getInstance();
    setState((){
      validityScale = prefs.getDouble("validityScale${widget.index}" ?? 2);
      patientScale = prefs.getDouble("patientScale${widget.index}" ?? 2);
      effectScale = prefs.getDouble("effectScale${widget.index}" ?? 2) ;
      pScale = prefs.getDouble("pScale${widget.index}" ?? 2);
      externalScale = prefs.getDouble("externalScale${widget.index}" ?? 2);

      print(validityScale);
      print(externalScale);
      print(effectScale);
      print(pScale);
    });
}
  // TODO Implement screen size for Android
  // TODO double width = MediaQuery.of(context).size.width;
  // TODO double height = MediaQuery.of(context).size.height;
  @override
  void initState() {
    super.initState();
    getOriginalStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.assistant), onPressed: () => _showDialog(context))
      ]),
      body: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Treatment Title",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _createMainColumn(),
                SpiderChart(
                    size: Size(300, 200),
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
                    maxValue: 3),
              ]
                ,
          )]),
      // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }


  Column _createMainColumn(){
    TextStyle heading = new TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
    TextStyle subHeading = new TextStyle(fontSize: 17, decoration: TextDecoration.underline);


    return Column(mainAxisAlignment: MainAxisAlignment.center, children: <
        Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Evidence",
                    style: heading,
                  ),
                ),
                Text("Internal Validity",
                    style: subHeading),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    createValiditySlider(),
                  ],
                ),
                Text("Effect Size",
                    style: subHeading),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      createEffectScaleSlider(),
                    ]),
                Text(
                  "p Value",
                  style: subHeading,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      createPValueScale(),
                    ]),
                SizedBox(
                  width: 4,
                  height: 20,
                ),
                Text(
                  "Patient Values",
                  style: heading,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    createPatientValueScale()
                  ],
                ),
                SizedBox(
                  width: 4,
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "External Validity",
                    style: heading,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    createEffectSlider(),
                  ],
                ),
              ]),
        ],

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

  Slider createValiditySlider(){
    return Slider(
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
          _save(validityScale, "validityScale");
        });
      },
      activeColor: Colors.cyan[100],
      min: 0,
      max: 3,
      label: internalLabel,
    );
  }

  Slider createEffectSlider(){
    return Slider(
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
          _save(externalScale, "externalScale");
        });
      },
      activeColor: Colors.cyan[100],
      min: 0,
      max: 3,
      label: externalValidity,
    );
  }

  Slider createPatientValueScale(){
    return Slider(
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
          _save(patientScale, "patientScale");
        });
      },
      activeColor: Colors.cyan[100],
      min: 0,
      max: 3,
      label: patientValues,
    );
  }

  Slider createPValueScale(){
    return Slider(
      value: pScale,
      divisions: 3,
      onChanged: (double newVal) {
        setState(() {
          pScale = newVal;
          switch (pScale.round()) {
            case 0:
              pOrdinal = "Not Very Significant (p > 0.2)";
              break;
            case 1:
              pOrdinal = "Not Significant (p >= 0.05) ";
              break;
            case 2:
              pOrdinal = "Significant (0.05 > p)";
              break;
            case 3:
              pOrdinal = "Very Significant (0.01 > p)";
              break;
          }
          _save(pScale, "pScale");
        });
      },
      activeColor: Colors.cyan[100],
      min: 0,
      max: 3,
      label: pOrdinal,
    );
  }

  Slider createEffectScaleSlider(){
    return Slider(
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
          _save(effectScale, "effectScale");
        });
      },
      activeColor: Colors.blue[300],
      min: 0,
      max: 3,
      label: effectOrdinal,
    );
  }

  _saveData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs
      ..setDouble("validityScale${widget.index}", validityScale)
      ..setDouble("patientScale${widget.index}", patientScale)
      ..setDouble("effectScale${widget.index}", effectScale)
      ..setDouble("pScale${widget.index}", pScale)
      ..setDouble("externalScale${widget.index}", externalScale);
    print("Saved");
    print("externalScale${widget.index} - $externalScale}");
  }

  void _save(double sliderVal, String label) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setDouble("$label${widget.index}", sliderVal);
    print('Saved');
  }
}
