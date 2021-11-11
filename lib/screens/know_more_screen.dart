import 'package:flutter/material.dart';

class KnowMoreScreen extends StatelessWidget {
  const KnowMoreScreen({Key? key}) : super(key: key);
  static const String knowMoreScreenRoute = '/know-more-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Know More"),
      ),
      body: Center(
        child: Text("Details about us Page"),
      ),
    );
  }
}
