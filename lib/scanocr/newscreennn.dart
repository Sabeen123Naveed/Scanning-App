import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
class NextScreen extends StatelessWidget {
  String scannedText1;
  NextScreen({required this.scannedText1});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Scanned Text"),

          ),
          body: Center(
            child: Container(
                child : Text(" ${scannedText1}" , style: TextStyle(fontSize: 10 , color: Colors.green),)
            ),
          )
      ),
    );
  }
}