import 'package:awesome_app_details/details/presentation/pages/details_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AwesomeAppDetails());

class AwesomeAppDetails extends StatelessWidget {
  const AwesomeAppDetails({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome App Details',
      theme: Themes.light,
      debugShowCheckedModeBanner: false,
      home: DetailsPage(photoId: 2014422),
    );
  }
}
