import 'package:flutter/material.dart';
class donation_field_module {
  String? donationField;
  String? imagePath; // Path to the image asset
  bool isSelected; // Indicates if the card is selected

  donation_field_module(
    this.donationField,
    
    {this.imagePath,
    this.isSelected = false, // Default value for isSelected is false
  });
}