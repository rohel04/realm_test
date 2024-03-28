import 'package:flutter/material.dart';

class UiHelper {
  static showSnachBar(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
