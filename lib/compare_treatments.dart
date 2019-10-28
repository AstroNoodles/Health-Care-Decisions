import 'package:flutter/material.dart';

class TreatmentCompare extends StatelessWidget {

  final String title;
  TreatmentCompare(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text(
          title,
          textAlign: TextAlign.center,
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).appBarTheme.color),
      body:
        Container(color: Colors.blue[500],)
    );
  }

}