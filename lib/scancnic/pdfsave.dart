import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'modelclass.dart';

class PdfData {
  static Future<File> generate(TodoModel ob, String pdf_name) async {
    final pdf = pw.Document();

    Uint8List ssss =   File(ob.imageUrl.toString()).readAsBytesSync();

    var image0 =  base64Encode(ssss);
    Uint8List ssss1 =   File(ob.imageUrl2.toString()).readAsBytesSync();

    var image1 =  base64Encode(ssss1);

    pdf.addPage(
      MultiPage(
          margin: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          pageFormat: PdfPageFormat.a4,
          build: (build) =>
          [
            Container(
              //  decoration: paid_decoration,
                width: 700,
                height: 700,
                color: PdfColors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Name : ${ob.name}",
                        style: TextStyle(fontSize: 25)),
                    Text("Cnic : ${ob.cnic}",
                        style: TextStyle(fontSize: 25)),
                    Text("Dob : ${ob.dob}",
                        style: TextStyle(fontSize: 25)),
                    Text("Doi : ${ob.doi}",
                        style: TextStyle(fontSize: 25)),
                    Text("Doe : ${ob.doe}",
                        style: TextStyle(fontSize: 25)),
                    //Image from string
                    pw.Image(ImageUtility.imageFromBase64String(image0),
                        fit: BoxFit.fill,
                      width: 250,
                      height: 250
                    ),
                    pw.SizedBox(
                      height: 15
                    ),
                    pw.Image(ImageUtility.imageFromBase64String(image1),
                        fit: BoxFit.fill,
                        width: 250,
                        height: 250
                    ),
                  ],
                ))
          ],
       //   footer: (context) => Container(child: Text("Footer"))
           ),
    );

    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$pdf_name');

    await file.writeAsBytes(bytes);

    return file;
  }

}
class ImageUtility {
  //Image from string
  // Image path_04 = ImageUtility.imageFromBase64String(modelData.path_04);

//String from image
//   String image_path01 = _image01 != null ? ImageUtility.base64String(File(_image01!.path).readAsBytesSync())
//Image From String
 static pw.MemoryImage imageFromBase64String(String base64String) {
    return pw.MemoryImage(
      base64Decode(base64String),
     // fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
