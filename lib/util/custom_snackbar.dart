import 'package:flutter/material.dart';

class CustomSnackbar {
  // show snackbar
  static void pushSnackbar(
    BuildContext context,
    String message, {
    bool error = false,
    SnackBarAction? snackBarAction,
  }) {
    // push a new snackbar with message
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
          backgroundColor: error ? Colors.red : Colors.blue,
          action: snackBarAction,
        ),
      );
    }
  }

  // clear snackbar
  static void clearSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
