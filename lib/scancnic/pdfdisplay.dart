import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:share_plus/share_plus.dart';

class ScreenPdfData extends StatefulWidget {
  final File pdfFile;
  const ScreenPdfData({required this.pdfFile});

  @override
  State<ScreenPdfData> createState() => _ScreenPdfDataState();
}

class _ScreenPdfDataState extends State<ScreenPdfData> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context, false);
            },
            child: Icon(Icons.arrow_back, color: Colors.black87),
          ),
          actions: [
            InkWell(
              onTap: () {
                Share.shareXFiles(
                  [
                     XFile('${widget.pdfFile.path}',)
                  ],
                );

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.share, size: 25, color: Colors.black87),
              ),
            )
          ],
        ),
        body: widget.pdfFile != null
            ? PdfViewer.openFile(widget.pdfFile.path)
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

