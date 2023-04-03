import 'dart:io';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../scancnic/modelclass.dart';





class Document extends StatefulWidget {
  const Document({Key? key}) : super(key: key);

  @override
  State<Document> createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  Box<Doc>? docBox;
  // File? _scannedDocumentFile;
  File? _scannedImage;
  final pdf = pw.Document();



  openImageScanner(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context,
        //  source: ScannerFileSource.CAMERA,
        labelsConfig: {
          ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Step",
          ScannerLabelsConfig.ANDROID_OK_LABEL: "Save"
        });
    if (image != null) {

      _scannedImage = image;
      setState(() {
        //  _scannedImage1 = image as Uint8List?;

      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      docBox = Hive.box<Doc>("doc box");
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Document Scanner'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
//      if (_scannedDocument != null || _scannedImage != null) ...[
              if (_scannedImage != null)
                Image.file(_scannedImage!,
                  width: 300, height: 300, fit: BoxFit.contain,
                  // filterQuality: FilterQuality.high,
                  //  color: Colors.grey[300],

                  colorBlendMode: BlendMode.difference,
                ),

              //     if (_scannedDocument != null)
              /*  Expanded(
                        child: PDFViewer(
                          document: _scannedDocument!,
                        )
                    ),*/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    _scannedImage?.path ?? ''),
              ),

              /* Center(
                  child: Builder(builder: (context) {
                    return ElevatedButton(
                        onPressed: () => openPdfScanner(context),
                        child: Text("PDF Scan"));
                  }),
                ),*/
              Center(
                child: Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () => openImageScanner(context),
                      child: Text("Image Scan"));
                }),
              ),
              Center(
                child: Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        docBox!.put("${DateTime.now().toString()}", Doc(
                          imageU: _scannedImage!.path.toString(),


                        ),
                        );
                        Navigator.of(context).pop();
                      },
                      child: Text("Save data"));
                }),
              )
            ],
          ),
        ),

    );
  }


   /* createPDF() async {
      final image = pw.MemoryImage(_scannedImage!.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
  savePDF() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/filename.pdf');
      await file.writeAsBytes(await pdf.save());
      showPrintedMessage('success', 'saved to documents');

    } catch (e) {
      showPrintedMessage('error', e.toString());
    }
  }

  showPrintedMessage(String title, String msg) {
    Flushbar(
      title: title,
      message: msg,
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.info,
        color: Colors.blue,
      ),
    )..show(context);
  }*/
}






/*import 'dart:io';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:flutter/material.dart';
//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  //PDFDocument? _scannedDocument;
  File? _scannedDocumentFile;
  File? _scannedImage;
  /*openPdfScanner(BuildContext context) async {
    var doc = await DocumentScannerFlutter.launchForPdf(
      context,
      labelsConfig: {
        ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Steps",
        ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_SINGLE: "Only 1 Page",
        ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_MULTIPLE:
        "Only {PAGES_COUNT} Page"
      },
      //source: ScannerFileSource.CAMERA
    );
    if (doc != null) {
     // _scannedDocument = null;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 100));
      _scannedDocumentFile = doc;
    //  _scannedDocument = await PDFDocument.fromFile(doc);
      setState(() {});
    }
  }*/
  openImageScanner(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context,
        source: ScannerFileSource.CAMERA,
        labelsConfig: {
          ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Step",
          ScannerLabelsConfig.ANDROID_OK_LABEL: "OK"
        });
    if (image != null) {
      _scannedImage = image;
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Document Scanner'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //      if (_scannedDocument != null || _scannedImage != null) ...[
              if (_scannedImage != null)
                Image.file(_scannedImage!,
                    width: 300, height: 300, fit: BoxFit.contain),
              //     if (_scannedDocument != null)
              /*  Expanded(
                      child: PDFViewer(
                        document: _scannedDocument!,
                      )
                  ),*/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    _scannedDocumentFile?.path ?? _scannedImage?.path ?? ''),
              ),
              /* Center(
                child: Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () => openPdfScanner(context),
                      child: Text("PDF Scan"));
                }),
              ),*/
              Center(
                child: Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () => openImageScanner(context),
                      child: Text("Image Scan"));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}*/