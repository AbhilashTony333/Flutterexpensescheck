import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  String tex;
  final Function fun;

  AdaptiveButton(this.tex, this.fun);


  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(tex, style: TextStyle(color: Colors.white)),
            onPressed: () => fun,
            color: Colors.yellow)
        : ElevatedButton(
            onPressed: () => fun,
            child: Text(tex),
            style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey, onPrimary: Colors.white),
          );
  }
}
