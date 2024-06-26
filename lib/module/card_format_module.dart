import 'package:flutter/material.dart';
class card_format_module {
  String? giftTo;
   String? cardTitle;
   String? messageContent;
   String? giftFrom;
   String? messageContent2;
   IconData? icon;
  String? imagePath; // Path to the image asset
  bool isSelected; // Indicates if the card is selected

  card_format_module(
    this.giftTo,
    this.cardTitle,
    this.messageContent,
    this.giftFrom,
    this.messageContent2,
    this.icon,
    {this.imagePath,
    this.isSelected = false, // Default value for isSelected is false
  });
}

