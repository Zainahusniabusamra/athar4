// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_application_athar_project/beneficiary_pages/Beneficiary_Additional_Info_Page.dart';
// import 'package:flutter_application_athar_project/pages/login_page.dart';

// class RegisterModalWidget extends StatefulWidget {
//   final void Function(void Function()) setStateFunction;

//   RegisterModalWidget({required this.setStateFunction});

//   @override
//   RegisterModalWidgetState createState() =>
//       RegisterModalWidgetState(setStateFunction: setStateFunction);

//   // Define a public method to show the modal
//   void showRegisterModal(BuildContext context) {
//     RegisterModalWidgetState state =
//         RegisterModalWidgetState(setStateFunction: setStateFunction);
//     state._showRegisterModal(context);
//   }
// }

// class RegisterModalWidgetState extends State<RegisterModalWidget> {
//   TextEditingController userNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPassController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   String? selectedGender;
//   String? selectedRole;
//   String? selectedUserType;


   
//   final void Function(void Function()) setStateFunction;

//   RegisterModalWidgetState({required this.setStateFunction});



// void _showRegisterModal(BuildContext context) {
//   Navigator.of(context).pop(); // Close the login modal

// showModalBottomSheet(
//   context: context,
//   isScrollControlled: true, // ensures full-height modal
//   builder: (BuildContext context) {
//    // bool isUserTypeSelected = selectedUserType != null;

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: StatefulBuilder(
//         builder: (BuildContext context, StateSetter modalStateSetter) {
//           return SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 55,
//                     backgroundColor: Colors.grey[200],
//                     // Replace with actual image
//                     backgroundImage: AssetImage('assets/imgs/1.jpeg'),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Create Account',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ListView(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       TextFormField(
//                         controller: userNameController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your username',
//                           labelText: 'Username',
//                           border: OutlineInputBorder(),
//                         ),
                        
//                       ),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your email',
//                           labelText: 'Email',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         controller: passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your password',
//                           labelText: 'Password',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('User Type:'),
//                           SizedBox(width: 10),
//                           Checkbox(
//                             value: selectedUserType == 'donor',
//                             onChanged: (bool? newValue) {
//                               if (newValue != null) {
//                                 modalStateSetter(() {
//                                   selectedUserType = newValue ? 'donor' : null;
//                                 });
//                               }
//                             },
//                           ),
//                           Text('Donor'),
//                           SizedBox(width: 10),
//                           Checkbox(
//                             value: selectedUserType == 'beneficiary',
//                             onChanged: (bool? newValue) {
//                               if (newValue != null) {
//                                 modalStateSetter(() {
//                                   selectedUserType = newValue ? 'beneficiary' : null;
//                                 });
//                               }
//                             },
//                           ),
//                           Text('Beneficiary'),
//                         ],
//                       ),
//                       // Display error message if no user type is selected
//                       // if (!isUserTypeSelected)
//                       //   Text(
                          
//                       //     'Please select a user type',
//                       //     decoration: InputDecoration(
//                       //       errorText:userTypeError,

//                       //     )
//                       //     style: TextStyle(
//                       //       color: Colors.red,
                            
//                       //     ),
//                       //   ),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         controller: ageController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your age',
//                           labelText: 'Age',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         controller: phoneController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your phone number',
//                           labelText: 'Phone',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Do you already have an account?'),
//                           SizedBox(width: 10),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                               LoginModalWidget loginModalWidget = LoginModalWidget();
//                               loginModalWidget.showLoginModal(context);
//                             },
//                             child: Text(
//                               'Login',
//                               style: TextStyle(
//                                 color: Colors.blue,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           _registerUser(context);
//                         },
//                         child: Text('Create Account'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   },
// );
// }



// Future<void> _registerUser(BuildContext context) async {
//   String userName = userNameController.text.trim();
//   String email = emailController.text.trim();
//   String password = passwordController.text.trim();
//  // String confirmPassword = confirmPassController.text.trim();
//   String userType = selectedUserType ?? ''; // Use selectedUserType if available
//   String status = "active"; // Assuming status is always 'active' during registration
//   DateTime registeredAt = DateTime.now(); // Get current date and time
//   int age = int.tryParse(ageController.text.trim()) ?? 0;
//   int phone = int.tryParse(phoneController.text.trim()) ?? 0;

//   if (userType == 'beneficiary') {
//     // Navigate to additional information page and pass user data
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BeneficiaryAdditionalInfoPage(
//           userName: userName,
//           email: email,
//           password: password,
//           userType: userType,
//           age: age,
//           phone: phone,
//         ),
//       ),
//     );
//     return; // Exit the method without making HTTP request
//   }


//   try {
//      var url = Uri.parse('http://192.168.1.140:3000/user/register');
//     //var url = Uri.parse('http://172.19.245.255:3000/user/register');

//     var response = await http.post(
//       url,
//       body: jsonEncode({
//         'user_name': userName,
//         'email': email,
//         'password': password,
//         'userType': userType,
//         'status': status,
//         'registeredAt': registeredAt.toIso8601String(),
//         'age': age.toString(),
//         'phone': phone.toString(),
//       }),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       // Registration successful
//       print('Registration successful!');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Registration Successful'),
//             content: Text('You have successfully registered.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } else if (response.statusCode == 409) {
//       // Registration failed due to conflict (phone or email already exists)
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final String message = responseData['message'];
//       print('Registration failed: $message');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Registration Failed'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Registration failed due to other reasons
//       print('Registration failed with status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Registration Failed'),
//             content: Text('Registration failed. Please try again.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   } catch (error) {
//     // Handle error
//     print('Error: $error');
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text('An error occurred. Please try again later.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }





//  @override
//   Widget build(BuildContext context) {
//     return Container(
//         // You can return any other widget here if needed
//         );
//   }
// }


















 



























import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_athar_project/beneficiary_pages/Beneficiary_Additional_Info_Page.dart';
import 'package:flutter_application_athar_project/pages/login_page.dart';

class RegisterModalWidget extends StatefulWidget {
  final void Function(void Function()) setStateFunction;

  RegisterModalWidget({required this.setStateFunction});

  @override
  RegisterModalWidgetState createState() =>
      RegisterModalWidgetState(setStateFunction: setStateFunction);

  // Define a public method to show the modal
  void showRegisterModal(BuildContext context) {
    RegisterModalWidgetState state =
        RegisterModalWidgetState(setStateFunction: setStateFunction);
    state._showRegisterModal(context);
  }
}

class RegisterModalWidgetState extends State<RegisterModalWidget> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? selectedGender;
  String? selectedRole;
  String? selectedUserType;

  final void Function(void Function()) setStateFunction;

  RegisterModalWidgetState({required this.setStateFunction});

  void _showRegisterModal(BuildContext context) {
    Navigator.of(context).pop(); // Close the login modal

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ensures full-height modal
      builder: (BuildContext context) {
        // bool isUserTypeSelected = selectedUserType != null;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: StatefulBuilder(
              builder: (BuildContext context, StateSetter modalStateSetter) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey[200],
                          // Replace with actual image
                          backgroundImage: AssetImage('assets/imgs/1.jpeg'),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'إنشاء حساب',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'ElMessiri',
                            color: Color.fromARGB(255, 2, 2, 88),
                          ),
                        ),
                        SizedBox(height: 20),
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            TextFormField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                hintText: 'أدخل اسم المستخدم',
                                labelText: 'اسم المستخدم',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'أدخل بريدك الإلكتروني',
                                labelText: 'البريد الإلكتروني',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'أدخل كلمة المرور',
                                labelText: 'كلمة المرور',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'نوع المستخدم:',
                                  style: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    color: Color.fromARGB(255, 2, 2, 88),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Checkbox(
                                  value: selectedUserType == 'donor',
                                  onChanged: (bool? newValue) {
                                    if (newValue != null) {
                                      modalStateSetter(() {
                                        selectedUserType =
                                            newValue ? 'donor' : null;
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  'متبرع',
                                  style: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    color: Color.fromARGB(255, 2, 2, 88),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Checkbox(
                                  value: selectedUserType == 'beneficiary',
                                  onChanged: (bool? newValue) {
                                    if (newValue != null) {
                                      modalStateSetter(() {
                                        selectedUserType =
                                            newValue ? 'beneficiary' : null;
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  'مستفيد',
                                  style: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    color: Color.fromARGB(255, 2, 2, 88),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: ageController,
                              decoration: InputDecoration(
                                hintText: 'أدخل عمرك',
                                labelText: 'العمر',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                hintText: 'أدخل رقم هاتفك',
                                labelText: 'رقم الهاتف',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'هل لديك حساب بالفعل؟',
                                  style: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    color: Color.fromARGB(255, 2, 2, 88),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    LoginModalWidget loginModalWidget =
                                        LoginModalWidget();
                                    loginModalWidget.showLoginModal(context);
                                  },
                                  child: Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      fontFamily: 'ElMessiri',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                _registerUser(context);
                              },
                              child: Text(
                                'إنشاء حساب',
                                style: TextStyle(
                                  fontFamily: 'ElMessiri',
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 2, 2, 88),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    String userName = userNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    // String confirmPassword = confirmPassController.text.trim();
    String userType = selectedUserType ?? ''; // Use selectedUserType if available
    String status = "active"; // Assuming status is always 'active' during registration
    DateTime registeredAt = DateTime.now(); // Get current date and time
    int age = int.tryParse(ageController.text.trim()) ?? 0;
    int phone = int.tryParse(phoneController.text.trim()) ?? 0;

    if (userType == 'beneficiary') {
      // Navigate to additional information page and pass user data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BeneficiaryAdditionalInfoPage(
            userName: userName,
            email: email,
            password: password,
            userType: userType,
            age: age,
            phone: phone,
          ),
        ),
      );
      return; // Exit the method without making HTTP request
    }

    try {
      var url = Uri.parse('http://192.168.1.140:3000/user/register');
      //var url = Uri.parse('http://172.19.245.255:3000/user/register');

      var response = await http.post(
        url,
        body: jsonEncode({
          'userName': userName,
          'email': email,
          'password': password,
          'userType': userType,
          'status': status,
          'registeredAt': registeredAt.toIso8601String(),
          'age': age.toString(),
          'phone': phone.toString(),
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Registration successful
        print('Registration successful!');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('تم التسجيل بنجاح'),
              content: Text('لقد تم تسجيلك بنجاح.'),
              actions: [
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
      } else if (response.statusCode == 409) {
        // Registration failed due to conflict (phone or email already exists)
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String message = responseData['message'];
        print('Registration failed: $message');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('فشل في التسجيل'),
              content: Text(message),
              actions: [
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
      } else {
        // Registration failed due to other reasons
        print('Registration failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('فشل في التسجيل'),
              content: Text('فشل التسجيل. يرجى المحاولة مرة أخرى.'),
              actions: [
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
    } catch (error) {
      // Handle error
      print('Error: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('خطأ'),
            content: Text('حدث خطأ. يرجى المحاولة مرة أخرى لاحقًا.'),
            actions: [
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // You can return any other widget here if needed
        );
  }
}








// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_application_athar_project/beneficiary_pages/Beneficiary_Additional_Info_Page.dart';
// import 'package:flutter_application_athar_project/pages/login_page.dart';

// class RegisterModalWidget extends StatefulWidget {
//   final void Function(void Function()) setStateFunction;

//   RegisterModalWidget({required this.setStateFunction});

//   @override
//   RegisterModalWidgetState createState() =>
//       RegisterModalWidgetState(setStateFunction: setStateFunction);

//   // Define a public method to show the modal
//   void showRegisterModal(BuildContext context) {
//     RegisterModalWidgetState state =
//         RegisterModalWidgetState(setStateFunction: setStateFunction);
//     state._showRegisterModal(context);
//   }
// }

// class RegisterModalWidgetState extends State<RegisterModalWidget> {
//   TextEditingController userNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPassController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   String? selectedGender;
//   String? selectedRole;
//   String? selectedUserType;

//   final void Function(void Function()) setStateFunction;

//   RegisterModalWidgetState({required this.setStateFunction});

//   void _showRegisterModal(BuildContext context) {
//     Navigator.of(context).pop(); // Close the login modal

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // ensures full-height modal
//       builder: (BuildContext context) {
//         // bool isUserTypeSelected = selectedUserType != null;

//         return Scaffold(
//           resizeToAvoidBottomInset: true,
//           body: StatefulBuilder(
//             builder: (BuildContext context, StateSetter modalStateSetter) {
//               return SingleChildScrollView(
//                 child: Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 55,
//                         backgroundColor: Colors.grey[200],
//                         // Replace with actual image
//                         backgroundImage: AssetImage('assets/imgs/1.jpeg'),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         'إنشاء حساب',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       ListView(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         children: [
//                           TextFormField(
//                             controller: userNameController,
//                             decoration: InputDecoration(
//                               hintText: 'أدخل اسم المستخدم',
//                               labelText: 'اسم المستخدم',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           TextFormField(
//                             controller: emailController,
//                             decoration: InputDecoration(
//                               hintText: 'أدخل بريدك الإلكتروني',
//                               labelText: 'البريد الإلكتروني',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           TextFormField(
//                             controller: passwordController,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               hintText: 'أدخل كلمة المرور',
//                               labelText: 'كلمة المرور',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('نوع المستخدم:'),
//                               SizedBox(width: 10),
//                               Checkbox(
//                                 value: selectedUserType == 'donor',
//                                 onChanged: (bool? newValue) {
//                                   if (newValue != null) {
//                                     modalStateSetter(() {
//                                       selectedUserType =
//                                           newValue ? 'donor' : null;
//                                     });
//                                   }
//                                 },
//                               ),
//                               Text('متبرع'),
//                               SizedBox(width: 10),
//                               Checkbox(
//                                 value: selectedUserType == 'beneficiary',
//                                 onChanged: (bool? newValue) {
//                                   if (newValue != null) {
//                                     modalStateSetter(() {
//                                       selectedUserType =
//                                           newValue ? 'beneficiary' : null;
//                                     });
//                                   }
//                                 },
//                               ),
//                               Text('مستفيد'),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           TextFormField(
//                             controller: ageController,
//                             decoration: InputDecoration(
//                               hintText: 'أدخل عمرك',
//                               labelText: 'العمر',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           TextFormField(
//                             controller: phoneController,
//                             decoration: InputDecoration(
//                               hintText: 'أدخل رقم هاتفك',
//                               labelText: 'رقم الهاتف',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('هل لديك حساب بالفعل؟'),
//                               SizedBox(width: 10),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.of(context).pop();
//                                   LoginModalWidget loginModalWidget =
//                                       LoginModalWidget();
//                                   loginModalWidget.showLoginModal(context);
//                                 },
//                                 child: Text(
//                                   'تسجيل الدخول',
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: () {
//                               _registerUser(context);
//                             },
//                             child: Text('إنشاء حساب'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _registerUser(BuildContext context) async {
//     String userName = userNameController.text.trim();
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     // String confirmPassword = confirmPassController.text.trim();
//     String userType = selectedUserType ?? ''; // Use selectedUserType if available
//     String status = "active"; // Assuming status is always 'active' during registration
//     DateTime registeredAt = DateTime.now(); // Get current date and time
//     int age = int.tryParse(ageController.text.trim()) ?? 0;
//     int phone = int.tryParse(phoneController.text.trim()) ?? 0;

//     if (userType == 'beneficiary') {
//       // Navigate to additional information page and pass user data
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BeneficiaryAdditionalInfoPage(
//             userName: userName,
//             email: email,
//             password: password,
//             userType: userType,
//             age: age,
//             phone: phone,
//           ),
//         ),
//       );
//       return; // Exit the method without making HTTP request
//     }

//     try {
//       var url = Uri.parse('http://192.168.1.140:3000/user/register');
//       //var url = Uri.parse('http://172.19.245.255:3000/user/register');

//       var response = await http.post(
//         url,
//         body: jsonEncode({
//           'user_name': userName,
//           'email': email,
//           'password': password,
//           'userType': userType,
//           'status': status,
//           'registeredAt': registeredAt.toIso8601String(),
//           'age': age.toString(),
//           'phone': phone.toString(),
//         }),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         // Registration successful
//         print('Registration successful!');
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('تم التسجيل بنجاح'),
//               content: Text('لقد تم تسجيلك بنجاح.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('حسنًا'),
//                 ),
//               ],
//             );
//           },
//         );
//       } else if (response.statusCode == 409) {
//         // Registration failed due to conflict (phone or email already exists)
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         final String message = responseData['message'];
//         print('Registration failed: $message');
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('فشل في التسجيل'),
//               content: Text(message),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('حسنًا'),
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         // Registration failed due to other reasons
//         print('Registration failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('فشل في التسجيل'),
//               content: Text('فشل التسجيل. يرجى المحاولة مرة أخرى.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('حسنًا'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (error) {
//       // Handle error
//       print('Error: $error');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('خطأ'),
//             content: Text('حدث خطأ. يرجى المحاولة مرة أخرى لاحقًا.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('حسنًا'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         // You can return any other widget here if needed
//         );
//   }
// }
