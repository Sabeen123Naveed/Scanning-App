import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hive/hive.dart';

import '../scancnic/modelclass.dart';


class Qrcodescan extends StatefulWidget {
  const Qrcodescan({Key? key}) : super(key: key);
  @override
  _QrcodescanState createState() => _QrcodescanState();
}
class _QrcodescanState extends State<Qrcodescan> {
  Box<Qr>? qrBox;
  String _scanBarcode = 'Unknown';

  /// For Continuous scan
  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen(
            (qrcode) => print(qrcode)

    );
  }

  Future<void> barcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // For Single Scan
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      qrBox = Hive.box<Qr>("qr box");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Qr code Scan'),
            centerTitle: true,
            automaticallyImplyLeading: false,

          ),
          body: Builder(builder: (BuildContext context) {
            return Container(
                alignment: Alignment.center,
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Text('Scan result : \n'
                            ' $_scanBarcode\n',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.cyan,
                            ),
                            onPressed: () => barcodeScan(),
                            child: const Text('QRcode Scan',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight
                                    .bold))),
                      ),
                      SizedBox(
                          height: 20
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                            ),
                            onPressed: () {
                              qrBox!.put("${DateTime.now().toString()}", Qr(
                                qrcode: _scanBarcode.toString(),


                              ),
                              );
                              Navigator.of(context).pop();
                            },
                            child: const Text('Save Data',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight
                                    .bold))),
                      ),
                    ]));
          })),
    );
  }
}