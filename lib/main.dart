import 'package:flutter/material.dart';
import 'package:core/core.dart';

void main() => runApp(const AwesomeAppDetails());

class AwesomeAppDetails extends StatelessWidget {
  const AwesomeAppDetails({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome App Details',
      theme: Themes.light,
      home: Container(),
    );
  }
}