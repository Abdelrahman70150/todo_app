import 'package:flutter/material.dart';

import '../styles/colors.dart';

class DialogUtils{
  static void showLoadingDialog(
      context, {required String message}){
    showDialog(context: context, builder: (builder){
      return AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 12,),
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
       required String message,
        required String title,
        Icon? icon,
        String? postActionMessage,
        String? negActionMessage,
        VoidCallback? postAction,
        VoidCallback? negAction,
         required bool isDismissible,
      }){
    List<Widget> actions=[];
    if(postActionMessage!=null){
      actions.add(
          ElevatedButton(
            onPressed: (){
            Navigator.pop(context);
          postAction?.call();
          },
            style: ElevatedButton.styleFrom(backgroundColor: primary),
            child: Text(postActionMessage,style: const TextStyle(color: Colors.white),) ,
          )

      );
      if(negActionMessage!=null){
        actions.add(
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
               negAction?.call();
              },
              style: ElevatedButton.styleFrom(backgroundColor: primary),
              child: Text(negActionMessage,style: const TextStyle(color: Colors.white),) ,
            )
        );
      }
    }

    showDialog(
      barrierDismissible:isDismissible,
        context: context, builder: (builder){
      return AlertDialog(
        content: Text(message,style: Theme.of(context).textTheme.titleSmall,),
        actions: actions,
        icon: icon,
        title:Text(title),
      );
    });
  }
}