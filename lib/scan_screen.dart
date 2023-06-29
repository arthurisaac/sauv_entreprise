import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sauvie_enrole/enrole_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = '';

  @override
  void reassemble() {
    if (Platform.isAndroid) {
      controller!.pauseCamera();
      //controller!.flipCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }

    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: qrText.isEmpty
                ? QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  )
                : Center(
                    child: SizedBox(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            qrText = "";
                          });
                        },
                        child: const Text("Relancer le scanner"),
                      ),
                    ),
                  ),
          ),
          /*Expanded(
            flex: 1,
            child: Center(
              child: Text(qrText),
            ),
          ),*/
          /*InkWell(
            onTap: () {
              */ /*showModalBottomSheet(
                enableDrag: true,
                isDismissible: true,
                context: context,
                builder: (context) => const EnroleScreen()
              );*/ /*

            },
            child: Expanded(
              flex: 1,
              child: Center(
                child: Text("Montrer"),
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code!;
      });
      if (scanData.code != null) {
        showMaterialModalBottomSheet(
          expand: false,
          context: context,
          builder: (context) => EnroleScreen(
            uniq: scanData.code.toString(), //'gdL5zcsKUf'
          ),
        );
      }
    });
  }
}
