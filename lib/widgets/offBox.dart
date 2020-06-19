import 'package:flutter/material.dart';

class OffBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    );
  }
}
