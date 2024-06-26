import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_athar_project/pages/register_page.dart'; // Import the RegisterPage
import 'package:flutter_application_athar_project/pages/profile_page_after_login.dart';

class LoginModalWidget extends StatefulWidget {
  @override
  _LoginModalWidgetState createState() => _LoginModalWidgetState();

  void showLoginModal(BuildContext context) {
    _LoginModalWidgetState state = _LoginModalWidgetState();
    state._showLoginModal(context);
  }
}

class _LoginModalWidgetState extends State<LoginModalWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showLoginModal(BuildContext context) {
    showModalBottomSheet(
            backgroundColor:  Color.fromARGB(248, 255, 255, 255),

      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'الرجاء إدخال البريد الإلكتروني';
                        }
                        return null;
                      },
                       textAlign: TextAlign.right, // Align hint text to the right
                    textDirection: TextDirection.rtl, 
                      decoration: InputDecoration(
                        hintText: 'أدخل البريد الإلكتروني',
                        border: OutlineInputBorder(),

                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'الرجاء إدخال كلمة المرور';
                        }
                        return null;
                      },
                       textAlign: TextAlign.right, // Align hint text to the right
                    textDirection: TextDirection.rtl, 
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'أدخل كلمة المرور',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Handle forgot password here
                      },
                      child: Text(
                        'نسيت كلمة المرور؟',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
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
                        _login(context);
                      },
                      child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Color.fromARGB(255, 249, 249, 250),
                    ),
                  ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('أو'),
                        ),
                        Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        RegisterModalWidget registerModalWidget =
                            RegisterModalWidget(
                          setStateFunction: (setState) {},
                        );

                        registerModalWidget.showRegisterModal(context);
                      },
                      child: Text(
                        'إنشاء حساب',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _login(BuildContext context) async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    const String apiUrl = 'http://192.168.1.140:3000/user/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final bool success = responseData['success'] ?? false;

        if (success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePageAfterLogin(email: email),
            ),
          );
        } else {
          _showErrorDialog(context, 'البريد الإلكتروني أو كلمة المرور غير صحيحة. الرجاء المحاولة مرة أخرى.');
        }
      } else {
        _showErrorDialog(context, 'حدث خطأ أثناء عملية تسجيل الدخول. الرجاء المحاولة مرة أخرى.');
      }
    } catch (error) {
      _showErrorDialog(context, 'حدث خطأ أثناء عملية تسجيل الدخول. الرجاء المحاولة مرة أخرى.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خطأ'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('حسناً'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}







