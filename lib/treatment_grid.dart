import 'package:flutter/material.dart';
import 'compare_treatments.dart';
import 'treatment.dart';
import 'package:spider_chart/spider_chart.dart';

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
                          crossAxisCount: 4,childAspectRatio: .3,), itemCount: TREATMENTS,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Container(padding: EdgeInsets.all(1), decoration: BoxDecoration(border: Border.all()),
                            child: GestureDetector(
                                child: Center(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
                                        Text(
                                          "Treatment ${index + 1}",
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 12),
                                        ), Checkbox(value: checkStates[index], onChanged: (checkState) {
                                          this.setState(() {
                                            print("Before $numChecked");
                                            checkState ? numChecked++ : numChecked--;
                                            checkStates[index] = checkState;
                                            print("Now $numChecked");

                                            if(numChecked == 2){
                                              actionButtonColor = Colors.amber;
                                            } else {
                                              actionButtonColor = Colors.blue[300];
                                            }
                                          });
                                        }, activeColor: Colors.blue,),
                                  SpiderChart(data: [
                                    1,
                                    2,
                                    3,
                                    2,
                                    1
                                  ], colors: [
                                    Colors.blue,
                                    Colors.red,
                                    Colors.orange,
                                    Colors.pink,
                                    Colors.black,
                                  ], maxValue: 3, size: Size(50, 50),)
                                ])), onTap: () => this.navigateTreatmentPage(title)));
                      })),
              FloatingActionButton(onPressed: () => toCompareState(title),
                backgroundColor: actionButtonColor,
                tooltip: 'Go to next page',
                child: Icon(Icons.arrow_forward),
              ),
            ])));
  }

  void navigateTreatmentPage(String title){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext builder) =>
                MyTreatment(title: title)));
  }

  void toCompareState(String title) {
    if (numChecked == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext builder) =>
          TreatmentCompare(title)));
    }
  }

}

