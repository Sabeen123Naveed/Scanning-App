import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:scanning/scandocument/documentdisplay.dart';
import 'package:scanning/scandocument/documentsave.dart';
import 'package:share_plus/share_plus.dart';

import '../scancnic/modelclass.dart';





class NewScreen1 extends StatelessWidget {


   String? imageU;
 // File imageU;

  NewScreen1({
    required this.imageU,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(" Document Detail"),
          actions: [

            Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                  icon: Icon(Icons.picture_as_pdf),
                  onPressed: () async{
                    Doc ob1 = Doc(
                        imageU: imageU.toString(),
                        );

                    File pdfFile1 =
                    await PdfData1.generate(ob1, "Document PDF.pdf");

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => DocDispaly(pdfFile1:pdfFile1 )));

                  }),
            )

          ],

        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Image.file(File(imageU.toString()),
                    fit: BoxFit.contain,
                    width: 300.0,
                    height: 300.0,
                  ),
                ),

              ],
            )),
      ),
    );
  }

}


