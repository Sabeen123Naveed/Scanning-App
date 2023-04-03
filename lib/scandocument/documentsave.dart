import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:scanning/scancnic/modelclass.dart';



class PdfData1 {
  static Future<File> generate(Doc ob1, String pdf_name) async {
    final pdf = pw.Document();

    Uint8List sss =   File(ob1.imageU.toString()).readAsBytesSync();
    var image =  base64Encode(sss);

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
                    pw.SizedBox(
                      height: 15
                    ),


                    //Image from string
                    pw.Image(ImageUtility.imageFromBase64String(image),
                        fit: BoxFit.fill,
                        width: 550,
                        height: 550
                    ),





                  ],
                ))
          ],
        //  footer: (context) => Container(child: Text("Footer"))
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
