import 'package:flutter/material.dart';

void snackbarcomman(BuildContext context, String message,
    {SnackBarAction? action}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    padding: EdgeInsets.all(15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: Colors.blue.shade900,
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    action: action,
    duration: Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
