
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGeneretor extends StatefulWidget {
  const QrCodeGeneretor({super.key});

  @override
  State<QrCodeGeneretor> createState() => _QrCodeGeneretorState();
}

class _QrCodeGeneretorState extends State<QrCodeGeneretor> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const  Text("QR code Generetor"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              QrImageView(
                data: controller.text,
                size: 200,
                backgroundColor: Colors.white,

              ),
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  
                  controller: controller,
                  
                  decoration: InputDecoration(
                    labelText: 'Enter your text',
                    
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade200,width: 5),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    suffixIcon: TextButton(
                      
                      onPressed: (){
                        setState(() {
                          
                        });
              
                      }, child: CircleAvatar(backgroundColor: Colors.blue.shade200,child: const Icon(Icons.done,color: Colors.black,)))
                  ),
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
