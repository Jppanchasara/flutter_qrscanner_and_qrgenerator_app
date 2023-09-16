import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  // ignore: non_constant_identifier_names
  static ToMessage(String titile){
    Fluttertoast.showToast(
        msg: titile,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 14
    );
  }
}