import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoadingDialog(
      context, {required String message}){
    showDialog(context: context, builder: (builder){
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 12,),
            Text(message),
          ],
        ),
      );
    },
    barrierDismissible: false
    );
  }
   static void hideDialog(context){
    Navigator.pop(context);
   }
   static void showMessage (
       context,
       {
         String? message,
         String? postActionMessage,
     String? negActionMessage,
         VoidCallback? postAction,
         VoidCallback? negAction,
       }){
    List<Widget> actions=[];
    if(postActionMessage!=null){
      actions.add(
          TextButton(
          onPressed: (){
            Navigator.pop(context);
            postAction?.call();
          },
          child: Text(postActionMessage))
      );
      if(negActionMessage!=null){
        actions.add(TextButton(
            onPressed:(){
              Navigator.pop(context);
              negAction?.call();
            },
            child: Text(negActionMessage)
        ),
        );
      }
    }

    showDialog(context: context, builder: (builder){
      return AlertDialog(
        content: Text(message!),
        actions: actions,
      );
    });
   }
}
