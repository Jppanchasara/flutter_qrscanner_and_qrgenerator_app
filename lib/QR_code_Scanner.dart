// ignore: file_names
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qrscanner/Tomessage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final qrQury = GlobalKey(debugLabel: "QR");

  List<String> storedList = [];
  // List? list = [];

  @override
  void initState() {
    super.initState();
    getStoredList();
  }

  Future<void> getStoredList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedListString = prefs.getString('storedList');
    if (storedListString != null) {
      List<dynamic> storedListDynamic = jsonDecode(storedListString);
      setState(() {
        storedList = List<String>.from(storedListDynamic);
      });
    }
  }

  Future<void> storeList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedList = jsonEncode(list);
    await prefs.setString('storedList', encodedList);
  }

  QRViewController? controller;

  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // ignore: annotate_overrides
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backwardsCompatibility: false,
        title: const Text("QR Code Scanner"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: SizedBox(
                height: 400,
                width: 400,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned.fill(child: BuildQrView(context)),
                    Positioned(top: 10, child: childBuildButton()),
                    Positioned(bottom: 10, child: ScanButton()),
                  ],
                )),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'History',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemCount: storedList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {
                        storedList[index];
                      }),
                      children: const [
                        SlidableAction(
                          onPressed: doNothing,
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    endActionPane: const ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: doNothing,
                          backgroundColor: Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: Icons.save,
                          label: 'Save',
                        ),
                      ],
                    ),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                            trailing: IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                          ClipboardData(text: barcode!.code))
                                      .then((value) {
                                    Utils.ToMessage('Text copy! ');
                                  });
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.black,
                                )),
                            title: Text(
                              storedList[index].toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                              maxLines: 3,
                            ))),
                  );
                }),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget BuildQrView(BuildContext context) => QRView(
        key: qrQury,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderLength: 20,
            borderRadius: 10,
            borderWidth: 20,
            cutOutSize: MediaQuery.of(context).size.width * 0.6,
            borderColor: Colors.green),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((barcode) => this.barcode = barcode);
  }

  buildResulte() => Container(
        height: 50,
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.black54),
        child: Center(
          child: Row(
            children: [
              Text(
                barcode != null ? 'Result:${barcode!.code}' : 'Scan a code!',
                maxLines: 3,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      );

  childBuildButton() => Container(
        height: 40,
        width: 130,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue.shade200),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                icon: FutureBuilder<bool?>(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    // ignore: unnecessary_null_comparison
                    if (snapshot.hasData != null) {
                      return Icon(
                          snapshot.data! ? Icons.flash_on : Icons.flash_off);
                    } else {
                      return Container();
                    }
                  },
                )),
            IconButton(
                onPressed: () async {
                  await controller?.flipCamera();
                },
                icon: FutureBuilder(
                  future: controller?.getCameraInfo(),
                  builder: (context, snapshot) {
                    // ignore: unnecessary_null_comparison
                    if (snapshot.hasData != null) {
                      return const Icon(Icons.switch_camera);
                    } else {
                      return Container();
                    }
                  },
                ))
          ],
        ),
      );

  ScanButton() => InkWell(
        onTap: () {
          setState(() {
            storedList.add('${barcode!.code}');
            storeList(storedList);
            barcode = null;
          });
          // list!.add(barcode!.code);
          // setState(() {});
          // barcode = null;
        },
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue.shade200),
          child: const Center(
              child: Text(
            "Scan",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          )),
        ),
      );
}

void doNothing(BuildContext context) {
  
}
