import 'dart:ui';
import 'package:flutter/material.dart';


class BlurryDialog extends StatelessWidget {

  String title;
  String content;
  VoidCallback? continueCallBack;
  int? pop;

  BlurryDialog(this.title, this.content, this.continueCallBack, [this.pop]);
  TextStyle textStyle = TextStyle (color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          title: new Text(title,style: textStyle,),
          content: new Text(content, style: textStyle,),
          actions: <Widget>[
            FlatButton(
              child: const Text("Oke"),
              onPressed: () {
                if(continueCallBack != null){
                  continueCallBack!();
                }else{
                  pop ??= 2;
                  int count = 0; Navigator.of(context).popUntil((_)=> count++>= pop!);
                }
              },
            ),
          ],
        ));
  }
}