
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



///global nav function
navigate(BuildContext context, Widget widget, bool isRemoveUntill){
 if(isRemoveUntill){
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=> widget),
          (route) => false);
 }else {
   Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
 }
}

///styles
/// create style for eleveated button
ButtonStyle createElevatedButtonStyle({double? width, Color? color}){
  return
    ElevatedButton.styleFrom(
        minimumSize: Size(width ?? 88, 48),
        backgroundColor: Colors.black,
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        )
    );
}