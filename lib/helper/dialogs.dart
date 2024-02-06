import 'package:flutter/material.dart';
class Dialogs{
   static void showSnackbar(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor: Colors.blue.withOpacity(.8), behavior: SnackBarBehavior.floating,));
   }
   static void showProgressbar(BuildContext context, String msg){
  showDialog(context: context, builder: (context) {
    return Center(child: CircularProgressIndicator());
  });
   }
}