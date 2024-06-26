import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/admin_pages/create_new_admin_page.dart';
import 'package:flutter_application_athar_project/admin_pages/delete_employees_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DocumentManagementPage extends StatefulWidget {
  @override
  _DocumentManagementPageState createState() => _DocumentManagementPageState();
}

class _DocumentManagementPageState extends State<DocumentManagementPage> {
  List<String> admins = [];


  Future<void> fetchAdmins() async {
    try {
      var response = await http.get(
        Uri.parse('http://192.168.1.140:3000/user/admins?title=${'إدارة الوثائق'}'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          admins = List<String>.from(data['admins']);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch admins: ${response.reasonPhrase}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch admins: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }



  @override
  void initState() {
    super.initState();
    fetchAdmins();
  }

  int acceptanceCases = 10;
  int nonAcceptanceCases = 3;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(248, 255, 255, 255),
        title: Text(
          'إدارة الوثائق',
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromARGB(255, 2, 2, 88),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 16),
                  color: const Color.fromARGB(255, 236, 233, 233),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مسؤوليات الموظف:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ElMessiri',
                            color: Color.fromARGB(255, 2, 2, 88),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'الموظف مسؤول عن مراجعة طلبات المستفيدين واتخاذ القرار بقبول أو رفض الحالات استنادًا إلى الوثائق المقدمة. في حال تم قبول الحالة، يقوم بإنشاء حساب للمستفيد، وإرسال تأكيد عبر البريد الإلكتروني، ونشر الحالة على التطبيق.',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'ElMessiri',
                            color: Color.fromARGB(255, 2, 2, 88),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                const Text(
                  'الموظفون:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri',
                    color: Color.fromARGB(255, 2, 2, 88),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: admins.length,
                  itemBuilder: (context, index) {
                    String employeeName = admins[index];
                    String initials = employeeName.isNotEmpty
                        ? employeeName.trim().split(' ').map((e) => e[0]).join('')
                        : '';

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: Text(
                          initials,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ElMessiri',
                            color: Color.fromARGB(255, 2, 2, 88),
                          ),
                        ),
                      ),
                      title: Text(
                        employeeName,
                        style: TextStyle(
                          fontFamily: 'ElMessiri',
                          color: Color.fromARGB(255, 2, 2, 88),
                        ),
                      ),
                      onTap: () {
                        // Handle tapping on employee name (if needed)
                        // Example: Navigate to employee details page
                      },
                      visualDensity: VisualDensity.comfortable,
                    );
                  },
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to CreateNewAdminPage when Add button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateNewAdminPage()),
                          );
                        },
                        child: Text(
                          'إضافة',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 3, 151, 3),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to DeleteEmployeesPage and pass the title
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DeleteEmployeesPage(title: 'إدارة الوثائق'),
                            ),
                          );
                        },
                        child: Text(
                          'حذف',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 2, 2, 88),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                const Text(
                  'إحصاءات إدارة الوثائق',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri',
                    color: Color.fromARGB(255, 2, 2, 88),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 16),
                ListTile(
                  title: const Text(
                    'الحالات المقبولة:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 2, 88),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ElMessiri',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  subtitle: Text(
                    '$acceptanceCases حالة',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 2, 2, 88),
                      fontSize: 16,
                      fontFamily: 'ElMessiri',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                ListTile(
                  title: const Text(
                    'الحالات غير المقبولة:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 2, 88),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ElMessiri',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  subtitle: Text(
                    '$nonAcceptanceCases حالة',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 2, 2, 88),
                      fontSize: 16,
                      fontFamily: 'ElMessiri',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_application_athar_project/admin_pages/create_new_admin_page.dart';
// import 'package:flutter_application_athar_project/admin_pages/delete_employees_page.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// class DocumentManagementPage extends StatefulWidget {
//   @override
//   _DocumentManagementPageState createState() => _DocumentManagementPageState();
// }

// class _DocumentManagementPageState extends State<DocumentManagementPage> {


// List<String> admins = [];


// Future<void> fetchAdmins() async {
//     try {
//       var response = await http.get(
//         Uri.parse('http://192.168.1.140:3000/user/admins?title=${widget.title}'),
//         //        Uri.parse('http://172.19.245.255:3000/user/admins?title=${widget.title}'),

//       );

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         setState(() {
//           admins = List<String>.from(data['admins']);
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to fetch admins: ${response.reasonPhrase}'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to fetch admins: $error'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

// @override
//   void initState() {
//     super.initState();
//     fetchAdmins();
//   }

//   String employer = 'جون دو';
//   int acceptanceCases = 10;
//   int nonAcceptanceCases = 3;
//   List<String> nonAcceptanceReasons = [
//     'المستندات غير كاملة',
//     'برهان الهوية غير صالح',
//     'معلومات غير صحيحة'
//   ];
//   List<String> employeeNames = [
//     'أليس جونسون',
//     'بوب سميث',
//     'تشارلي براون',
//     'ديفيد لي',
//     'إيما وايت',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
     
//       backgroundColor: Color.fromARGB(248, 255, 255, 255),
      
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(248, 255, 255, 255),
//         title: Text(
         
//           'إدارة الوثائق',
//           style: TextStyle(fontFamily: 'ElMessiri' , color:  Color.fromARGB(255, 2, 2, 88)),
//         ),
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Card(
//                   elevation: 4,
//                   margin: EdgeInsets.only(bottom: 16),
//                    color: const Color.fromARGB(255, 236, 233, 233),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
                    
//                   ),
//                   child:const Padding(
                      
//                     padding: EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'مسؤوليات الموظف:',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'ElMessiri',
//                             color:  Color.fromARGB(255, 2, 2, 88),
//                           ),
//                           textDirection: TextDirection.rtl,
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'الموظف مسؤول عن مراجعة طلبات المستفيدين واتخاذ القرار بقبول أو رفض الحالات استنادًا إلى الوثائق المقدمة. في حال تم قبول الحالة، يقوم بإنشاء حساب للمستفيد، وإرسال تأكيد عبر البريد الإلكتروني، ونشر الحالة على التطبيق.',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: 'ElMessiri',
//                              color:  Color.fromARGB(255, 2, 2, 88),
//                           ),
//                           textDirection: TextDirection.rtl,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 24),
//                const Text(
//                   'الموظفون:',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'ElMessiri',
//                      color:  Color.fromARGB(255, 2, 2, 88),
//                   ),
//                   textDirection: TextDirection.rtl,
//                 ),
//                 SizedBox(height: 8),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: employeeNames.length,
//                   itemBuilder: (context, index) {
//                     String employeeName = employeeNames[index];
//                     String initials = employeeName.isNotEmpty
//                        ? employeeName.trim().split(' ').map((e) => e[0]).join('')
//                         : '';

//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Colors.blue[100],
//                         child: Text(
//                           initials,
//                           style:const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'ElMessiri',
//                              color:  Color.fromARGB(255, 2, 2, 88),
//                           ),
//                         ),
//                       ),
//                       title: Text(
//                         employeeName,
//                         style: TextStyle(fontFamily: 'ElMessiri' , color:  Color.fromARGB(255, 2, 2, 88),),
//                       ),
//                       onTap: () {
//                         // Handle tapping on employee name (if needed)
//                         // Example: Navigate to employee details page
//                       },
//                       visualDensity: VisualDensity.comfortable,
//                     );
//                   },
//                 ),
//                 SizedBox(height: 24),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Navigate to CreateNewAdminPage when Add button is pressed
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => CreateNewAdminPage()),
//                           );
//                         },
//                         child: 
//                         Text(
//                           'إضافة',
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             fontFamily: 'ElMessiri',
                            
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color.fromARGB(255, 3, 151, 3),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Navigate to DeleteEmployeesPage and pass the title
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => DeleteEmployeesPage(title: 'إدارة الوثائق'),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'حذف',
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             fontFamily: 'ElMessiri',
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color.fromARGB(255, 2, 2, 88),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24),
//                 const Text(
//                   'إحصاءات إدارة الوثائق',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'ElMessiri',
//                      color:  Color.fromARGB(255, 2, 2, 88),
//                   ),
//                   textDirection: TextDirection.rtl,
//                 ),
//                 SizedBox(height: 16),
//                 ListTile(
//                   title:const Text(
//                     'الحالات المقبولة:',
//                     style: TextStyle(
//                        color:  Color.fromARGB(255, 2, 2, 88),
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'ElMessiri',
//                     ),
//                     textDirection: TextDirection.rtl,
//                   ),
//                   subtitle: Text(
//                     '$acceptanceCases حالة',
//                     style:const TextStyle(
//                        color:  Color.fromARGB(255, 2, 2, 88),
//                       fontSize: 16,
//                       fontFamily: 'ElMessiri',
//                     ),
//                     textDirection: TextDirection.rtl,
//                   ),
//                 ),
//                 ListTile(
//                   title:const Text(
//                     'الحالات غير المقبولة:',
//                     style: TextStyle(
//                        color:  Color.fromARGB(255, 2, 2, 88),
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'ElMessiri',
//                     ),
//                     textDirection: TextDirection.rtl,
//                   ),
//                   subtitle: Text(
//                     '$nonAcceptanceCases حالة',
//                     style:const TextStyle(
//                        color:  Color.fromARGB(255, 2, 2, 88),
//                       fontSize: 16,
//                       fontFamily: 'ElMessiri',
//                     ),
//                     textDirection: TextDirection.rtl,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
