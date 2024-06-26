// gift type module for creat gift 
import 'package:flutter/material.dart';

class GiftTypeModule{
String? GiftType;
IconData? icon;
 String? imagePath; 
bool? isSelected;
  GiftTypeModule(this.GiftType, this.icon, {this.imagePath, this.isSelected = false});
}