import 'package:flutter/material.dart';

ButtonStyle customButtonStyle () {
  return ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // Background color
      foregroundColor: Colors.white, // Text color
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Padding
  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Text style
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(8), // Rounded corners
  ));
}