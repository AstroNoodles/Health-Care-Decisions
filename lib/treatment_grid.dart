import 'package:flutter/material.dart';
import 'compare_treatments.dart';
import 'treatment.dart';
import 'package:spider_chart/spider_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TreatmentGrid extends StatefulWidget {
  TreatmentGrid({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TreatmentGridState createState() => _TreatmentGridState();
}

class _TreatmentGridState extends State<TreatmentGrid> {
  Color backgroundColor = Colors.white;
  static const TREATMENTS = 30;
  int numChecked = 0;
  List<bool> checkStates = List.generate(TREATMENTS, (i) => false);
  Color actionButtonColor = Colors.blue;
  double validityScale = 2, effectScale = 2, pScale = 2, externalScale = 2, patientScale = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChartVariables();
  }

  void getChartVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < TREATMENTS; i++){
        if(prefs.getDouble("validityScale$i") != null){
          validityScale = prefs.getDouble("validityScale${i}");
          break;
        } else validityScale = 2;
        if(prefs.getDouble("effectScale$i") != null){
          effectScale = prefs.getDouble("effectScale${i}");
          break;
        } else effectScale = 2;
        if(prefs.getDouble("pScale$i") != null){
          pScale = prefs.getDouble("pScale${i}");
          break;
        } else pScale = 2;
        if(prefs.getDouble("externalScale$i") != null){
          externalScale = prefs.getDouble("externalScale${i}");
          break;
        } else externalScale = 2;
        if(prefs.getDouble("patientScale$i") != null){
          patientScale = prefs.getDouble("patientScale${i}");
          break;
        } else patientScale = 2;

      print(validityScale);
      print(externalScale);
      print(effectScale);
      print(pScale);
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.title;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          elevation: 0,
          backgroundColor: Colors.lightBlue,
        ),
        body: Align(
            alignment: Alignment.topLeft,
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Select the treatments to review below",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold))),
              Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: .3,
                      ),
                      itemCount: TREATMENTS,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(border: Border.all()),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Treatment ${index + 1}",
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 12),
                                ),
                                Checkbox(
                                  value: checkStates[index],
                                  onChanged: (checkState) {
                                    this.setState(() {
                                      print("Before $numChecked");
                                      checkState ? numChecked++ : numChecked--;
                                      checkStates[index] = checkState;
                                      print("Now $numChecked");

                                      if (numChecked == 2) {
                                        actionButtonColor = Colors.amber;
                                      } else {
                                        actionButtonColor = Colors.blue[300];
                                      }
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                SpiderChart(
                                  data: [validityScale, effectScale, pScale, externalScale, patientScale],
                                  colors: [
                                    Colors.blue,
                                    Colors.red,
                                    Colors.orange,
                                    Colors.pink,
                                    Colors.black,
                                  ],
                                  maxValue: 3,
                                  size: Size(50, 50),
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),),
                                RaisedButton(
                                  onPressed: () => this.navigateTreatmentPage(
                                      widget.title, index),
                                  child: Text("Go to Treatment", style: TextStyle(fontSize: 14),),
                                  color: Colors.redAccent[100],
                                  focusElevation: 0,
                                  focusColor: Colors.redAccent[200],
                                )
                              ]),
                        );
                      })),
              FloatingActionButton(
                onPressed: () => toCompareState(title),
                backgroundColor: actionButtonColor,
                tooltip: 'Go to next page',
                child: Icon(Icons.arrow_forward),
              ),
            ])));
  }

  void navigateTreatmentPage(String title, int index) {
    if (numChecked != 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext builder) =>
                  MyTreatment(index, title: title)));
    }
  }

  void toCompareState(String title) {
    if (numChecked == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext builder) => TreatmentCompare(title)));
    }
  }
}
