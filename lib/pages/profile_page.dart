import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/pages/login_page.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 255, 255, 255),
      appBar: AppBar(
        
        backgroundColor: Color.fromARGB(248, 255, 255, 255),
        title:const Text(
          'تسجيل الدخول',
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromARGB(255, 2, 2, 88),
          ),
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
                        color:const Color.fromARGB(255, 236, 233, 233),
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
                      child: ClipOval(
  child: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/imgs/athar_logo.jpg'),
        fit: BoxFit.fill,
      ),
    ),
  ),
),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  
                  onPressed: () {
                    LoginModalWidget modalWidget = LoginModalWidget();
                    modalWidget.showLoginModal(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 2, 2, 88), // Button background color
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: 
                  Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Color.fromARGB(255, 249, 249, 250),
                    ),
                  ),
                ),
                
                
                
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
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
                            title: Text(
                              'عن أثر',
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
                            title: Text(
                              'مركز التواصل',
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
                            title: Text(
                              'شروط القبول',
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
                            title: Text(
                              'الاسئلة الشائعة',
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
