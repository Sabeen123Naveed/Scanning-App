import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanning/scancnic/pdfdisplay.dart';
import 'package:scanning/scancnic/pdfsave.dart';

import 'modelclass.dart';

class NewScreen extends StatelessWidget {
  String? name;
  String? cnic;
  String? dob;
  String?  doi;
  String?  doe;
  String? imageUrl;
  String? imageUrl2;
  NewScreen({ required this.name ,required this.cnic, required this.dob,required this.doi, required this.doe, required this.imageUrl,required this.imageUrl2,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail of Cnic"),
          actions: [

            Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                  icon: Icon(Icons.picture_as_pdf),
                  onPressed: () async{
                    TodoModel ob = TodoModel(
                        name: name.toString() ,cnic: cnic.toString(), dob:dob.toString(), doi: doi.toString(), imageUrl:imageUrl.toString(), doe: doe.toString(), imageUrl2: imageUrl2.toString());

                    print("object ${ob.imageUrl}");
                    File pdfFile =
                        await PdfData.generate(ob, "Cnic PDF.pdf");

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ScreenPdfData(pdfFile: pdfFile)));

                  }),
            )

          ],
        ),
        body: Center(
            child: Column(
              children: [
                ListTile(
                  title:Image.file(File(imageUrl.toString()),
                    fit: BoxFit.contain,
                    width: 300.0,
                    height: 150.0,
                  ),
                ),
                ListTile(
                  title:Image.file(File(imageUrl2.toString()),
                    fit: BoxFit.contain,
                    width: 400.0,
                    height: 150.0,
                  ),
                ),

                ListTile(
                  title: Text(name.toString() ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), ),
                ),

                ListTile(
                  title: Text(cnic.toString() ,style: TextStyle(fontSize: 15), ),
                ),


                ListTile(
                  title: Text(dob.toString() ,style: TextStyle(fontSize: 15), ),
                ),

                ListTile(
                  title: Text(doi.toString() ,style: TextStyle(fontSize: 15), ),
                ),


                ListTile(
                  title: Text(doe.toString() ,style: TextStyle(fontSize: 15), ),
                ),






              ],
            )),
      ),
    );
  }
}