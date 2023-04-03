import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:share_plus/share_plus.dart';

class DocDispaly extends StatefulWidget {
  final File pdfFile1;
  const DocDispaly({required this.pdfFile1});

  @override
  State<DocDispaly> createState() => _DocDispalyState();
}

class _DocDispalyState extends State<DocDispaly> {
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
                    XFile('${widget.pdfFile1.path}',)
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
        body: widget.pdfFile1 != null
            ? PdfViewer.openFile(widget.pdfFile1.path)
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

