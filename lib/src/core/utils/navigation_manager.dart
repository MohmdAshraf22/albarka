import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class NavigationManager {
  static void pushAndRemove(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }

  static void push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static  void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
