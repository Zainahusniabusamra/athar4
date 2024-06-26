import 'package:flutter/material.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('السلة'),
         backgroundColor: Color.fromARGB(255, 12, 124, 124),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize:25.0 ,
          fontWeight: FontWeight.bold,
      ),
     
    ),
    );
  }
}