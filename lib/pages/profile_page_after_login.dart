import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/admin_pages/page1.dart';
import 'package:flutter_application_athar_project/admin_pages/page2.dart';
import 'package:flutter_application_athar_project/admin_pages/page3.dart';
import 'package:flutter_application_athar_project/admin_pages/page4.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_athar_project/admin_pages/custom_bottom_navbar_admin.dart'; 
import 'package:flutter_application_athar_project/admin_star/custom_navbar_admin3.dart'; 
import 'package:flutter_application_athar_project/admin_star/custom_navbar_admin1.dart'; 
import 'package:flutter_application_athar_project/admin_star/custom_navbar_admin2.dart'; 

import 'package:flutter_application_athar_project/beneficiary_pages/custom_bottom_navbar_beneficiary.dart'; 
import 'package:flutter_application_athar_project/donor_pages/custom_bottom_navbar_donor.dart'; 




class ProfilePageAfterLogin extends StatefulWidget {
    final Key? key;
  final String ? email;

  ProfilePageAfterLogin({required this.email, this.key}) : super(key: key);

  @override
  ProfilePageAfterLoginState createState() => ProfilePageAfterLoginState();
}

class ProfilePageAfterLoginState extends State<ProfilePageAfterLogin> {
String? selectedGender;
String? username;
String? userType;
String? adminName;

  @override
  void initState() {
    super.initState();
    fetchUsername();
    fetchUserType();
  }

  void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

Future<void> fetchAdminType(String adminName) async {
  final String apiUrl = 'http://192.168.1.140:3000/user/adminType'; 
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {'admin_name': adminName}, 
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        // Data retrieved successfully
        int fkRoleId = responseData['user']['fk_role_id'];
        
        // Navigate based on fk_role_id
        switch (fkRoleId) {
          case 1:
            // Navigate to page 1
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>custom_bottom_navbar_admin1(email: widget.email,)),
            );
            break;
          case 2:
            // Navigate to page 2
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>custom_bottom_navbar_admin3(email: widget.email,)),
            );
            break;
          case 3:

           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => custom_bottom_navbar_admin2(email: widget.email,)),
            );
            
            break;
          case 4:
            // Navigate to page 4
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page4()),
            );
            break;
          case 5:
            // Show a dialog indicating no access
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('No Access'),
                  content: Text('You do not have access to this page.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
            break;
          case 6:
            // Navigate to page 6
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => custom_bottom_navbar_admin(email:widget.email)),
            );
            break;
          default:
            // Handle unexpected role id
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Invalid role id for admin.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
        }
      } else {
        // Handle failure
        print('Error: ${responseData['message']}');
      }
    } else {
      // Handle other status codes
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions
    print('Exception: $e');
  }
}


Future<void> fetchUsername() async {
  final String apiUrl = 'http://192.168.1.140:3000/user/profile';
  //final String apiUrl = 'http://172.19.245.255:3000/user/profile';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body:json.encode( {'email': widget.email}),
      headers: {'Content-Type': 'application/json'},
    );


    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    // Check status code
    if (response.statusCode == 200) {
      
final responseData = json.decode(response.body);
final bool success = responseData['success'] ?? false;
      if (success) {
        setState(() {
username = responseData['user']['username'];
        });
      } else {
            _showErrorDialog(context, 'An error occurred during login. Please try again.');

      }
    } else {
          _showErrorDialog(context, 'An error occurred during login. Please try again.');

    }
  } catch (e) {
        _showErrorDialog(context, 'An error occurred during login. Please try again.');

  }
}



Future<void> fetchUserType() async {
  final String apiUrl = 'http://192.168.1.140:3000/user/userType';
 // final String apiUrl = 'http://172.19.245.255:3000/user/userType';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body:json.encode( {'email': widget.email}),
      headers: {'Content-Type': 'application/json'},
    );


    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    // Check status code
    if (response.statusCode == 200) {
      
final responseData = json.decode(response.body);
final bool success = responseData['success'] ?? false;
      if (success) {
        setState(() {
userType = responseData['user']['userType'];
        });
      } else {
            _showErrorDialog(context, 'An error occurred during login. Please try again.');

      }
    } else {
       _showErrorDialog(context, 'An error occurred during login. Please try again.');

    }
  } catch (e) {
        _showErrorDialog(context, 'An error occurred during login. Please try again.');

  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 255, 255, 255),
      
      appBar: AppBar(
        backgroundColor: Color.fromARGB(248, 255, 255, 255),
        title: Text(
          'الملف الشخصي',
          textDirection: TextDirection.rtl,
        ),
      ),
      body: Directionality(
                textDirection: TextDirection.rtl,

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 90,
                      right: 90,
                      child: Container(
                        width: 20,
                        height: 200,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey[200],
                        backgroundImage:
                            AssetImage('assets/imgs/2.jpeg'), // Replace with actual image
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                username != null
                    ? Text('مرحبًا, ${username}!', textDirection: TextDirection.rtl)
                    : CircularProgressIndicator(),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 2, 2, 88), // Button background color
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (userType == 'admin') {
                      fetchAdminType(username!);
                    } else if (userType == 'donor') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CustomBottomNavbardonor(email: widget.email),
                        ),
                      );
                    } else if (userType == 'beneficiary') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomBottomNavbarBeneficiary(
                            email: widget.email,
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('خطأ'),
                            content: Text(
                                'نوع مستخدم غير صالح. يرجى المحاولة مرة أخرى.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('حسنًا'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child:const Text('حسابي',
                  style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Color.fromARGB(255, 249, 249, 250),
                    ),
                  
              ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                   const Text(
                     textDirection: TextDirection.rtl,
                      'حول التطبيق',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'ElMessiri',
                        color: Color.fromARGB(255, 2, 2, 88),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 233, 233),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                              //leading: Icon(Icons.info, color: Color.fromARGB(255, 2, 2, 88)),
                              title:const Text(
                                'الزر الأول',
                                style: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 2, 2, 88)),
                              onTap: () {
                                // Add functionality for the first button
                              },
                            ),
                            Divider(),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                              //leading: Icon(Icons.info_outline, color: Color.fromARGB(255, 2, 2, 88)),
                              title:const Text(
                                'الزر الثاني',
                                style: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                           trailing: Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 2, 2, 88)),
                              onTap: () {
                                // Add functionality for the second button
                              },
                            ),
                            Divider(),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                             // leading: Icon(Icons.help, color: Color.fromARGB(255, 2, 2, 88)),
                              title:const Text(
                                'الزر الثالث',
                                style: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 2, 2, 88)),
                              onTap: () {
                                // Add functionality for the third button
                              },
                            ),
                            Divider(),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                             // leading: Icon(Icons.settings, color: Color.fromARGB(255, 2, 2, 88)),
                              title:const Text(
                                'الزر الرابع',
                                style: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 2, 2, 88)),
                              onTap: () {
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
