import 'package:flutter/material.dart';

class Committee extends StatelessWidget {
  const Committee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "COMMITTEE",
        ),
        centerTitle: true,
      ),
    );
  }
}