import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_application_athar_project/our_program_pages/bloodDonation.dart';
import 'package:flutter_application_athar_project/our_program_pages/creatGift.dart';
import 'package:flutter_application_athar_project/our_program_pages/view_recipient.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class Details_of_the_recipient extends StatefulWidget {
  const Details_of_the_recipient({super.key});

  @override
  State<Details_of_the_recipient> createState() => _Details_of_the_recipientState();
}

class _Details_of_the_recipientState extends State<Details_of_the_recipient> {
  List <String> titels =[
    "إضافة مهدى إليه",
    "بيانات المهدى إليهم",
  ];
  GlobalKey <FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 113, 224),
        elevation: 0.0,
         title: Text('بيانات المهدى إليهم'),
          centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize:25.0 ,
          fontWeight: FontWeight.bold,
          

        ),
            automaticallyImplyLeading: false,
                  actions: [
              Container(
                margin: EdgeInsets.only(right: 16), // Adjust right margin for position
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 208, 113, 224), 
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  color: Colors.white,
                  iconSize: 25.0,
                  onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>creatGift()),
                    );
                  },
                ),
              ),
            ],
                ),

                body: SingleChildScrollView( 
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 30.0,),
           Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to page 1
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Details_of_the_recipient()),
            );
          },
          child: Container(
            height: 70,
            width: 160,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 157, 126, 161),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  color: Color.fromARGB(255, 180, 150, 184),
                ),
              ],
            ),
            child: Center(
              child: Text(
                titels[0], // Assuming titels[0] corresponds to the first title
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to page 2
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => view_recipient()),
            );
          },
          child: Container(
            height: 70,
            width: 160,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 157, 126, 161),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  color: Color.fromARGB(255, 180, 150, 184),
                ),
              ],
            ),
            child: Center(
              child: Text(
                titels[1], // Assuming titels[1] corresponds to the second title
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ],
),

            SizedBox(height: 30.0,),
             Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "اسم المُهدى إليه",
                style: TextStyle(
                  fontSize: 18.0,
                  
                ),
              ),
             ),
              SizedBox(height: 10.0,),
              Container(
  padding: EdgeInsets.fromLTRB(20, 8, 20, 8), // Add padding to the container
  child: TextField(
    textAlign: TextAlign.right, // Align input text to the right
    decoration: InputDecoration(
      hintTextDirection: TextDirection.rtl, // Set hint text direction to right-to-left
        //labelText: 'اسم المُهدى إليه', // Empty label text
      hintText: 'اسم المُهدى إليه', // Placeholder text when the field is empty
      suffixIcon: Icon(Icons.person), // Icon displayed at the end of the input field
      border: OutlineInputBorder(), // Border around the text field
    ),
    onChanged: (value) {
      // Handle the text change
    },
  ),
),
    SizedBox(height: 5.0,),
             Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "رقم جوال المهدى إليه",
                style: TextStyle(
                  fontSize: 18.0,
                  
                ),
              ),
             ),
              SizedBox(height: 10.0,),
              Container(
  padding: EdgeInsets.fromLTRB(20, 8, 20, 8), // Add padding to the container
  child: Form(
    key: _formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
//        IntlPhoneField(
//   textAlign: TextAlign.right,
//   keyboardType: TextInputType.phone, // Set the input type to phone number
//   decoration: InputDecoration(
//     hintTextDirection: TextDirection.rtl,
//     //labelText: 'رقم الهاتف',
//     hintText: 'رقم الهاتف',
//     suffixIcon: Icon(Icons.phone),
//     border: OutlineInputBorder(),
//   ),
//   onChanged: (value) {
//     // Handle the text change
//   },
// )

      ],
    ),
),

),
          SizedBox(height: 5.0,),
             Container(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Text(
                "مبلغ التبرع",
                style: TextStyle(
                  fontSize: 18.0,
                  
                ),
              ),
             ),
              SizedBox(height: 10.0,),
              Container(
  padding: EdgeInsets.fromLTRB(20, 8, 20, 8), // Add padding to the container
  child: TextField(
    textAlign: TextAlign.right, // Align input text to the right
    decoration: InputDecoration(
      hintTextDirection: TextDirection.rtl, // Set hint text direction to right-to-left
        //labelText: 'اسم المُهدى إليه', // Empty label text
      hintText: 'ادخل مبلغ التبرع', // Placeholder text when the field is empty
      suffixIcon: Icon(Icons.currency_exchange), // Icon displayed at the end of the input field
      border: OutlineInputBorder(), // Border around the text field
    ),
    onChanged: (value) {
      // Handle the text change
    },
  ),
),
SizedBox(height: 15.0,),
       Center(
       child:  InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 150.0),
            decoration: BoxDecoration(
             color:Color.fromARGB(255, 157, 126, 161),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  color: Color.fromARGB(255, 180, 150, 184),
                ),
              ], 
              ),
              child: Text(
                "إضافة",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
          ),
          

        ),),
          ],

                  ),
                ),        
    );
  }
}