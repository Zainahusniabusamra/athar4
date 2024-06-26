import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/admin_pages/create_new_admin_page.dart';
import 'package:flutter_application_athar_project/admin_pages/delete_employees_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class CommunityEngagementPage extends StatefulWidget {
  @override
  _CommunityEngagementPageState createState() => _CommunityEngagementPageState();
}

class _CommunityEngagementPageState extends State<CommunityEngagementPage> {






 List<String> admins = [];


  Future<void> fetchAdmins() async {
    try {
      var response = await http.get(
        Uri.parse('http://192.168.1.140:3000/user/admins?title=${'التقارير'}'),
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
        title:const Text(
           'التقارير',
          style: TextStyle(fontFamily: 'ElMessiri' , color:  Color.fromARGB(255, 2, 2, 88)),
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
                  child:const Padding(
                      
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
                            color:  Color.fromARGB(255, 2, 2, 88),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'الموظف مسؤول عن مراجعة طلبات المستفيدين واتخاذ القرار بقبول أو رفض الحالات استنادًا إلى الوثائق المقدمة. في حال تم قبول الحالة، يقوم بإنشاء حساب للمستفيد، وإرسال تأكيد عبر البريد الإلكتروني، ونشر الحالة على التطبيق.',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'ElMessiri',
                             color:  Color.fromARGB(255, 2, 2, 88),
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
                     color:  Color.fromARGB(255, 2, 2, 88),
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
                          style:const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ElMessiri',
                             color:  Color.fromARGB(255, 2, 2, 88),
                          ),
                        ),
                      ),
                      title: Text(
                        employeeName,
                        style: TextStyle(fontFamily: 'ElMessiri' , color:  Color.fromARGB(255, 2, 2, 88),),
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
                            MaterialPageRoute(builder: (context) => CreateNewAdminPage()),
                          );
                        },
                        child: 
                        Text(
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
                              builder: (context) => DeleteEmployeesPage(title:'التقارير'),
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
                
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_athar_project/admin_pages/create_new_admin_page.dart';
// import 'package:flutter_application_athar_project/admin_pages/delete_employees_page.dart';

// class CommunityEngagementPage extends StatefulWidget {
//   @override
//   _CommunityEngagementPageState createState() => _CommunityEngagementPageState();
// }

// class _CommunityEngagementPageState extends State<CommunityEngagementPage> {

//   String employer = 'John Doe'; // Initial employer




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community Engagement'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Employer:',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       GestureDetector(
//                         onTap: () {
//                           _showEditDialog('Change Employer', 'New Employer', employer, (newValue) {
//                             setState(() {
//                               employer = newValue;
//                             });
//                           });
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.grey),
//                           ),
//                           child: Text(
//                             employer,
//                             style: TextStyle(
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                   IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     // Navigate to CreateNewAdminPage when IconButton is pressed
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => CreateNewAdminPage()),
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//     // Navigate to DeleteEmployeesPage and pass the title
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DeleteEmployeesPage(title: 'Community Engagement'),
//       ),
//     );
//   },
//                 ),
//               ],
//             ),
            
           
//           ],
//         ),
//       ),
//     );
//   }

//  void _showEditDialog(String title, String hint, String initialValue, Function(String) onSave) {
//     TextEditingController textEditingController = TextEditingController(text: initialValue);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: TextFormField(
//             controller: textEditingController,
//             decoration: InputDecoration(hintText: hint),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 onSave(textEditingController.text);
//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
  
// }
