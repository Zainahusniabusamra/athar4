import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/admin_pages/document_management_page.dart';
import 'package:flutter_application_athar_project/admin_pages/messages_Page.dart';
import 'package:flutter_application_athar_project/admin_pages/community_engagement_page.dart';
import 'package:flutter_application_athar_project/admin_pages/addListsJob.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminProfilePage extends StatefulWidget {
  
  final String ? email;

  AdminProfilePage({required this.email}) ;

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {

Future<String?> getUsername(String email) async {
  final url = Uri.parse('http://192.168.1.140:3000/user/get-username');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['userName'];
  } else if (response.statusCode == 404) {
    print('User not found');
    return null;
  } else {
    print('Error: ${response.statusCode}');
    print(response.body);
    return null;
  }
}


  // Admin Name
  String adminName = '';
  String email = '';
  // String contactNumber = '1234567890';
  // String address = 'عنوان المثال';

  // Manage App Operations
  List<String> activeJobs = [
    'إدارة الوثائق',
    'التقارير',
    'اضافة قوائم'
  ];

  // Communication Tools
  String lastDonorMessage = 'مرحبًا المانح، شكرًا لتبرعك الكريم!';


@override
void initState() {
  super.initState();
  email = widget.email ?? 'admin@example.com';
  _fetchAndSetUsername(email);
}

void _fetchAndSetUsername(String email) async {
  String? username = await getUsername(email);
  if (username != null) {
    setState(() {
      adminName = username;
    });
  } else {
    setState(() {
      adminName = 'User not found';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(248, 255, 255, 255),
        title: Text(
          'ملف المشرف',
          textDirection: TextDirection.rtl,
          style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/imgs/2.jpeg'),
              ),
              SizedBox(height: 16),
              buildSection(
                'المعلومات الشخصية',
                [
                  buildClickableListTile('اسم المشرف : $adminName', Icons.person, onTap: () {
                    _showEditDialog('تغيير اسم المشرف', 'الاسم الجديد', adminName, (newValue) {
                      setState(() {
                        adminName = newValue;
                      });
                    });
                  }),
                  buildClickableListTile('البريد الإلكتروني: $email', Icons.email, onTap: () {
                    _showEditDialog('تغيير البريد الإلكتروني', 'البريد الإلكتروني الجديد', email, (newValue) {
                      setState(() {
                        email = newValue;
                      });
                    });
                  }),
                  // buildClickableListTile('رقم الاتصال: $contactNumber', Icons.phone, onTap: () {
                  //   _showEditDialog('تغيير رقم الاتصال', 'رقم الاتصال الجديد', contactNumber, (newValue) {
                  //     setState(() {
                  //       contactNumber = newValue;
                  //     });
                  //   });
                  // }),
                  // buildClickableListTile('العنوان: $address', Icons.location_on, onTap: () {
                  //   _showEditDialog('تغيير العنوان', 'العنوان الجديد', address, (newValue) {
                  //     setState(() {
                  //       address = newValue;
                  //     });
                  //   });
                  // }),
                ],
                backgroundColor: const Color.fromARGB(255, 236, 233, 233),
              ),

              // Manage App Operations
              buildSection(
                'إدارة عمليات التطبيق',
                activeJobs.map((job) {
                  return buildClickableListTile2(job, onTap: () {
                    _navigateToOperationPage(context, job);
                  });
                }).toList(),
                backgroundColor: const Color.fromARGB(255, 236, 233, 233),
              ),

              // Communication Tools
              buildSection(
                'أدوات الاتصال',
                [
                  buildText('آخر رسالة من المانح', lastDonorMessage),
                ],
                backgroundColor: const Color.fromARGB(255, 236, 233, 233),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommunicationToolsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(String title, List<Widget> children, {Color? backgroundColor, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'ElMessiri',
            color: Color.fromARGB(255, 2, 2, 88),
          ),
          textDirection: TextDirection.rtl,
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: children,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildClickableListTile(String title, IconData icon, {required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Color.fromARGB(255, 2, 2, 88)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'ElMessiri',
          color: Color.fromARGB(255, 2, 2, 88),
        ),
        textDirection: TextDirection.rtl,
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 2, 2, 88)),
    );
  }

  Widget buildClickableListTile2(String title, {required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'ElMessiri',
          color: Color.fromARGB(255, 2, 2, 88),
        ),
        textDirection: TextDirection.rtl,
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 2, 2, 88)),
    );
  }

  void _showEditDialog(String title, String hint, String initialValue, Function(String) onSave) {
    TextEditingController textEditingController = TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'ElMessiri')),
          content: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: hint),
            textDirection: TextDirection.rtl,
            style: TextStyle(fontFamily: 'ElMessiri'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onSave(textEditingController.text);
                Navigator.pop(context);
              },
              child: Text('حفظ', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إلغاء', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
            ),
          ],
        );
      },
    );
  }

  Widget buildText(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'ElMessiri',
            color: Color.fromARGB(255, 2, 2, 88),
          ),
          textDirection: TextDirection.rtl,
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: 'ElMessiri',
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }

  void _navigateToOperationPage(BuildContext context, String job) {
    switch (job) {
      case 'إدارة الوثائق':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DocumentManagementPage()),
        );
        break;
      case 'اضافة قوائم':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Addlistsjob()),
        );
        break;
      case 'التقارير':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CommunityEngagementPage()),
        );
        break;
      // case 'التقارير والتحليلات':
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => ReportingAndAnalyticsPage()),
      //   );
      //   break;
      default:
        break;
    }
  }
}














// import 'package:flutter/material.dart';
// import 'package:flutter_application_athar_project/admin_pages/document_management_page.dart';
// import 'package:flutter_application_athar_project/admin_pages/financial_oversight_page.dart';
// import 'package:flutter_application_athar_project/admin_pages/reporting_and_analytics_page.dart';
// import 'package:flutter_application_athar_project/admin_pages/community_engagement_page.dart';

// class AdminProfilePage extends StatefulWidget {
//   @override
//   _AdminProfilePageState createState() => _AdminProfilePageState();
// }

// class _AdminProfilePageState extends State<AdminProfilePage> {
  
//   // Admin Name
//   String adminName = 'اسم المشرف';
//   String email = 'admin@example.com';
//   String contactNumber = '1234567890';
//   String address = 'عنوان المثال';

//   // Manage App Operations
//   List<String> activeJobs = [
//     'إدارة الوثائق',
//     'الرقابة المالية',
//     'المشاركة المجتمعية',
//     'التقارير والتحليلات',
//   ];

//   // Communication Tools
//   String lastDonorMessage = 'مرحبًا المانح، شكرًا لتبرعك الكريم!';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(248, 255, 255, 255),
//       appBar: AppBar(
//         title: Text(
//           'ملف المشرف',
//           textDirection: TextDirection.rtl,
//           style: TextStyle(fontFamily: 'ElMessiri' ,color:  Color.fromARGB(255, 2, 2, 88)),
          
//         ),
//       ),
//       body: Directionality(
//         textDirection:TextDirection.rtl,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage('assets/imgs/2.jpeg'),
//                 ),
//                 SizedBox(height: 16),
//                 buildSection(
                  
//                   'المعلومات الشخصية',
//                   [
//                     buildClickableListTile('اسم المشرف', Icons.person, onTap: () {
//                       _showEditDialog('تغيير اسم المشرف', 'الاسم الجديد', adminName, (newValue) {
//                         setState(() {
//                           adminName = newValue;
//                         });
//                       });
//                     }),
//                     buildClickableListTile('البريد الإلكتروني: $email', Icons.email, onTap: () {
//                       _showEditDialog('تغيير البريد الإلكتروني', 'البريد الإلكتروني الجديد', email, (newValue) {
//                         setState(() {
//                           email = newValue;
//                         });
//                       });
//                     }),
//                     buildClickableListTile('رقم الاتصال: $contactNumber', Icons.phone, onTap: () {
//                       _showEditDialog('تغيير رقم الاتصال', 'رقم الاتصال الجديد', contactNumber, (newValue) {
//                         setState(() {
//                           contactNumber = newValue;
//                         });
//                       });
//                     }),
//                     buildClickableListTile('العنوان: $address', Icons.location_on, onTap: () {
//                       _showEditDialog('تغيير العنوان', 'العنوان الجديد', address, (newValue) {
//                         setState(() {
//                           address = newValue;
//                         });
//                       });
//                     }),
//                   ],
//                   backgroundColor: const Color.fromARGB(255, 236, 233, 233),

//                 ),
        
//                 // Manage App Operations
//                 buildSection('إدارة عمليات التطبيق', 
//                 backgroundColor: const Color.fromARGB(255, 236, 233, 233), activeJobs.map((job) {
//                   return buildClickableListTile2(job, onTap: () {
//                     _navigateToOperationPage(context, job);
//                   });
//                 }).toList()),
        
//                 // Communication Tools
//                 buildSection('أدوات الاتصال',backgroundColor: const Color.fromARGB(255, 236, 233, 233), [
//                   buildText('آخر رسالة من المانح', lastDonorMessage),
//                 ], onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CommunicationToolsPage()),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildSection(String title, List<Widget> children, {Color? backgroundColor, VoidCallback? onTap}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         SizedBox(height: 16),
//         Text(
//           title,
//           style:const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'ElMessiri',
//             color:Color.fromARGB(255, 2, 2, 88)
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//         SizedBox(height: 8),
//         GestureDetector(
//           onTap: onTap,
//           child: Card(
//             elevation: 4,
//             child: backgroundColor != null
//                 ? Container(
//                     decoration: BoxDecoration(color: backgroundColor),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: children,
//                       ),
//                     ),
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: children,
//                     ),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildClickableListTile(String title, IconData icon, {required VoidCallback onTap}) {
//     return ListTile(
//       onTap: onTap,
//       leading: Icon(icon ,color:Color.fromARGB(255, 2, 2, 88)),
//       title: Text(
//         title,
//         style:const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'ElMessiri',
//           color:  Color.fromARGB(255, 2, 2, 88)
//         ),
//         textDirection: TextDirection.rtl,
//       ),
//       trailing: Icon(Icons.arrow_forward_ios ,color:  Color.fromARGB(255, 2, 2, 88)),
//     );
//   }


//  Widget buildClickableListTile2(String title, {required VoidCallback onTap}) {
//     return ListTile(
//       onTap: onTap,
//       //leading: Icon(icon ,color:Color.fromARGB(255, 2, 2, 88)),
//       title: Text(
//         title,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'ElMessiri',
//           color:  Color.fromARGB(255, 2, 2, 88)
//         ),
//         textDirection: TextDirection.rtl,
//       ),
//       trailing: Icon(Icons.arrow_forward_ios ,color:  Color.fromARGB(255, 2, 2, 88)),
//     );
//   }


//   void _showEditDialog(String title, String hint, String initialValue, Function(String) onSave) {
//     TextEditingController textEditingController = TextEditingController(text: initialValue);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title, textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'ElMessiri')),
//           content: TextFormField(
//             controller: textEditingController,
//             decoration: InputDecoration(hintText: hint),
//             textDirection: TextDirection.rtl,
//             style: TextStyle(fontFamily: 'ElMessiri'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 onSave(textEditingController.text);
//                 Navigator.pop(context);
//               },
//               child: Text('حفظ', style: TextStyle(fontFamily: 'ElMessiri')),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('إلغاء', style: TextStyle(fontFamily: 'ElMessiri')),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget buildText(String title, String text) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style:const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'ElMessiri',
//             color:  Color.fromARGB(255, 2, 2, 88)
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//         SizedBox(height: 4),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//             fontFamily: 'ElMessiri',
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//       ],
//     );
//   }

//   Widget buildRow(String title, String text) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'ElMessiri',
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//             fontFamily: 'ElMessiri',
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//       ],
//     );
//   }

//   void _navigateToOperationPage(BuildContext context, String job) {
//     switch (job) {
//       case 'إدارة الوثائق':
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => DocumentManagementPage()),
//         );
//         break;
//       case 'الرقابة المالية':
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => FinancialOversightPage()),
//         );
//         break;
//       case 'المشاركة المجتمعية':
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => CommunityEngagementPage()),
//         );
//         break;
//       case 'التقارير والتحليلات':
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ReportingAndAnalyticsPage()),
//         );
//         break;
//       default:
//         break;
//     }
//   }
// }

// class CommunicationToolsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'أدوات الاتصال',
//           style: TextStyle(fontFamily: 'ElMessiri'),
//         ),
//       ),
//       body: Center(
//         child: Text(
//           'هذه هي صفحة أدوات الاتصال',
//           style: TextStyle(fontFamily: 'ElMessiri'),
//         ),
//       ),
//     );
//   }
// }

