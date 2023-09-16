import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:qrscanner/QR_code_Scanner.dart';
import 'package:qrscanner/QRcodeGeneretor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
        title: const Text('QR code',),
      ),
      body: Center(
        child: Container(
          height: 180,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 3)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const QrCodeGeneretor()));
                      },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Image(
                      height: 100,
                      width: 100,
                      image: AssetImage('asset/qr.png')),
                    Text("QR Generetor",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                          
                  ],
                ),
              ),
              
               InkWell(
                onTap: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QRCodeScanner()));
                },
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                     Image(
                      height: 100,
                      width: 100,
                      image: AssetImage("asset/qr.png")),
                    Text("QR Scanner",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                         
                  ],
                             ),
               )
            ],
          ),
        ),
      ),
    );
  }
}
