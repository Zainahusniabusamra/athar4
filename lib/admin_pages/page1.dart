import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'request_detailes_page.dart';
import 'dart:typed_data'; // Import typed_data for Uint8List
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math'; // Add this import statement

class DonationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق التبرعات',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ElMessiri', // Set default font family for the app
      ),
      home: DocumentRole(),
    );
  }
}

class DocumentRole extends StatefulWidget {
  @override
  _DocumentRoleState createState() => _DocumentRoleState();
}

class _DocumentRoleState extends State<DocumentRole>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Map<String, dynamic>> _pendingRequests = [];
  late List<Map<String, dynamic>> _acceptedRequests = [];
  late List<Map<String, dynamic>> _rejectedRequests = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchDataFromBackend();
  }

  Future<void> _fetchDataFromBackend() async {
    final response = await http.get(Uri.parse('http://192.168.1.140:3000/user/beneficiary_documents'));
    //final response = await http.get(Uri.parse('http://172.19.245.255:3000/user/beneficiary_documents'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _pendingRequests = [];
        _acceptedRequests = [];
        _rejectedRequests = [];
        for (var item in data) {
          final request = {
            'beneficiary_id': item['beneficiary_id'],
            'id': item['document_id'],
            'name': item['beneficiary_name'],
            'email': item['email'],
            'phone': item['phone'],
            'photo': 'https://via.placeholder.com/150', // Placeholder photo
            'description': item['document_description'],
            'status': item['is_accepted'],
            'documentName': item['document_name'],
            'uploadDate': item['upload_date'],
            'targetAmount': item['target_amount'],
            'document_content': item['document_content'],
            'beneficiaryDescription': item['beneficiary_description'],
            'age': item['age'],
            'password': item['password'],
            'userType': item['pending_userType'],
            'pending_status': item['pending_status'],
            'registeredAt': item['registeredAt'],
          };
          if (request['status'] == 'pending') {
            _pendingRequests.add(request);
          } else if (request['status'] == 'accepted') {
            _acceptedRequests.add(request);
          } else if (request['status'] == 'rejected') {
            _rejectedRequests.add(request);
          }
        }
      });
    } else {
      throw Exception('Failed to load data from backend');
    }
  }

  Future<void> _updateRequestStatus(int requestId, String newStatus) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.140:3000/user/update_request_status'),
        // Uri.parse('http://172.19.245.255:3000/user/update_request_status'),

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'requestId': requestId,
          'newStatus': newStatus,
        }),
      );

      if (response.statusCode == 200) {
        // Update request locally
        setState(() {
          final requestIndex = _pendingRequests.indexWhere((req) => req['id'] == requestId);
          if (requestIndex != -1) {
            _pendingRequests[requestIndex]['status'] = newStatus;
            if (newStatus == 'تم القبول') {
              _acceptedRequests.add(_pendingRequests.removeAt(requestIndex));
            } else {
              _rejectedRequests.add(_pendingRequests.removeAt(requestIndex));
            }
          }
        });
      } else {
        throw Exception('Failed to update request status');
      }
    } catch (e) {
      print('Error updating request status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor:const Color.fromARGB(248, 255, 255, 255),
        appBar: AppBar(
          backgroundColor:const Color.fromARGB(248, 255, 255, 255),
          title: Text('دور المستند' ,style:TextStyle( color:const Color.fromARGB(255, 2, 2, 88), ) ),
          bottom: TabBar(
            labelColor:  const Color.fromARGB(255, 2, 2, 88), 
            indicatorColor: const Color.fromARGB(255, 2, 2, 88), 
            controller: _tabController,
            tabs: [
              Tab(text: 'قيد الانتظار'),
              Tab(text: 'تم القبول'),
              Tab(text: 'تم الرفض'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            RequestsScreen(
              requests: _getRequestsByStatus('pending'),
              updateRequestStatus: _updateRequestStatus,
            ),
            RequestsScreen(
              requests: _getRequestsByStatus('accepted'),
              updateRequestStatus: _updateRequestStatus,
            ),
            RequestsScreen(
              requests: _getRequestsByStatus('rejected'),
              updateRequestStatus: _updateRequestStatus,
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getRequestsByStatus(String status) {
    switch (status) {
      case 'pending':
        return _pendingRequests;
      case 'accepted':
        return _acceptedRequests;
      case 'rejected':
        return _rejectedRequests;
      default:
        return [];
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class RequestsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> requests;
  final Function(int, String) updateRequestStatus;

  const RequestsScreen({
    Key? key,
    required this.requests,
    required this.updateRequestStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return RequestCard(
          name: requests[index]['name'],
          photo: requests[index]['photo'],
          description: requests[index]['description'],
          status: requests[index]['status'],
          onTap: () {
            // Navigate to request details page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RequestDetailsScreen(
                  request: requests[index],
                  //documents: requests[index]['documents'],
                ),
              ),
            );
          },
          onUpdateStatus: (newStatus) {
            updateRequestStatus(requests[index]['id'], newStatus);
          },
        );
      },
    );
  }
}

class RequestCard extends StatelessWidget {
  static const Color customColor = Color.fromARGB(255, 2, 2, 88);

  final String name;
  final String photo;
  final String description;
  final String status;
  final VoidCallback onTap;
  final Function(String) onUpdateStatus;

  const RequestCard({
    Key? key,
    required this.name,
    required this.photo,
    required this.description,
    required this.status,
    required this.onTap,
    required this.onUpdateStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 236, 233, 233),
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _generateRandomColor(),
                    ),
                    child: Center(
                      child: Text(
                        name.substring(0, 1), // Display first letter of name
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontFamily: 'ElMessiri', // Apply font family
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ElMessiri', // Apply font family
                            color: customColor, // Apply custom color
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: customColor, // Apply custom color
                            fontFamily: 'ElMessiri', // Apply font family
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'الحالة: $status',
                style: TextStyle(
                  fontSize: 14.0,
                  color: _getStatusColor(status),
                  fontFamily: 'ElMessiri', // Apply font family
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _generateRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'تم القبول':
        return Colors.green;
      case 'تم الرفض':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showConfirmationDialog(
    BuildContext context,
    String action,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد $action'),
          content: Text('هل أنت متأكد أنك تريد $action هذا الطلب؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('لا'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text('نعم'),
            ),
          ],
        );
      },
    );
  }
}






// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'request_detailes_page.dart';
// import 'dart:typed_data'; // Import typed_data for Uint8List
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:math'; // Add this import statement

// class DonationApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'تطبيق التبرعات',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
        
//         fontFamily: 'ElMessiri', // Set default font family for the app
//       ),
//       home: DocumentRole(),
//     );
//   }
// }

// class DocumentRole extends StatefulWidget {
//   @override
//   _DocumentRoleState createState() => _DocumentRoleState();
// }

// class _DocumentRoleState extends State<DocumentRole>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   late List<Map<String, dynamic>> _pendingRequests = [];
//   late List<Map<String, dynamic>> _acceptedRequests = [];
//   late List<Map<String, dynamic>> _rejectedRequests = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _fetchDataFromBackend();
//   }

//   Future<void> _fetchDataFromBackend() async {
//     final response = await http.get(Uri.parse('http://192.168.1.140:3000/user/beneficiary_documents'));
//     //final response = await http.get(Uri.parse('http://172.19.245.255:3000/user/beneficiary_documents'));

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       setState(() {
//         _pendingRequests = [];
//         _acceptedRequests = [];
//         _rejectedRequests = [];
//         for (var item in data) {
//           final request = {
//             'beneficiary_id': item['beneficiary_id'],
//             'id': item['document_id'],
//             'name': item['beneficiary_name'],
//             'email': item['email'],
//             'phone': item['phone'],
//             'photo': 'https://via.placeholder.com/150', // Placeholder photo
//             'description': item['document_description'],
//             'status': item['is_accepted'],
//             'documentName': item['document_name'],
//             'uploadDate': item['upload_date'],
//             'targetAmount': item['target_amount'],
//             'document_content': item['document_content'],
//             'beneficiaryDescription': item['beneficiary_description'],
//             'age': item['age'],
//             'password': item['password'],
//             'userType': item['pending_userType'],
//             'pending_status': item['pending_status'],
//             'registeredAt': item['registeredAt'],
//           };
//           if (request['status'] == 'pending') {
//             _pendingRequests.add(request);
//           } else if (request['status'] == 'accepted') {
//             _acceptedRequests.add(request);
//           } else if (request['status'] == 'rejected') {
//             _rejectedRequests.add(request);
//           }
//         }
//       });
//     } else {
//       throw Exception('Failed to load data from backend');
//     }
//   }

//   Future<void> _updateRequestStatus(int requestId, String newStatus) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.1.140:3000/user/update_request_status'),
//         // Uri.parse('http://172.19.245.255:3000/user/update_request_status'),

//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{
//           'requestId': requestId,
//           'newStatus': newStatus,
//         }),
//       );

//       if (response.statusCode == 200) {
//         // Update request locally
//         setState(() {
//           final requestIndex = _pendingRequests.indexWhere((req) => req['id'] == requestId);
//           if (requestIndex != -1) {
//             _pendingRequests[requestIndex]['status'] = newStatus;
//             if (newStatus == 'تم القبول') {
//               _acceptedRequests.add(_pendingRequests.removeAt(requestIndex));
//             } else {
//               _rejectedRequests.add(_pendingRequests.removeAt(requestIndex));
//             }
//           }
//         });
//       } else {
//         throw Exception('Failed to update request status');
//       }
//     } catch (e) {
//       print('Error updating request status: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('دور المستند'),
//           bottom: TabBar(
//             controller: _tabController,
//             tabs: [
//               Tab(text: 'قيد الانتظار'),
//               Tab(text: 'تم القبول'),
//               Tab(text: 'تم الرفض'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           controller: _tabController,
//           children: [
//             RequestsScreen(
//               requests: _getRequestsByStatus('pending'),
//               updateRequestStatus: _updateRequestStatus,
//             ),
//             RequestsScreen(
//               requests: _getRequestsByStatus('accepted'),
//               updateRequestStatus: _updateRequestStatus,
//             ),
//             RequestsScreen(
//               requests: _getRequestsByStatus('rejected'),
//               updateRequestStatus: _updateRequestStatus,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Map<String, dynamic>> _getRequestsByStatus(String status) {
//     switch (status) {
//       case 'pending':
//         return _pendingRequests;
//       case 'accepted':
//         return _acceptedRequests;
//       case 'rejected':
//         return _rejectedRequests;
//       default:
//         return [];
//     }
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
// }

// class RequestsScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> requests;
//   final Function(int, String) updateRequestStatus;

//   const RequestsScreen({
//     Key? key,
//     required this.requests,
//     required this.updateRequestStatus,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: requests.length,
//       itemBuilder: (context, index) {
//         return RequestCard(
//           name: requests[index]['name'],
//           photo: requests[index]['photo'],
//           description: requests[index]['description'],
//           status: requests[index]['status'],
//           onTap: () {
//             // Navigate to request details page
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => RequestDetailsScreen(
//                   request: requests[index],
//                   //documents: requests[index]['documents'],
//                 ),
//               ),
//             );
//           },
//           onUpdateStatus: (newStatus) {
//             updateRequestStatus(requests[index]['id'], newStatus);
//           },
//         );
//       },
//     );
//   }
// }

// class RequestCard extends StatelessWidget {
//   final String name;
//   final String photo;
//   final String description;
//   final String status;
//   final VoidCallback onTap;
//   final Function(String) onUpdateStatus;

//   const RequestCard({
//     Key? key,
//     required this.name,
//     required this.photo,
//     required this.description,
//     required this.status,
//     required this.onTap,
//     required this.onUpdateStatus,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: InkWell(
//         onTap: onTap,
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 70,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: _generateRandomColor(),
//                     ),
//                     child: Center(
//                       child: Text(
//                         name.substring(0, 1), // Display first letter of name
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 24.0,
//                           fontFamily: 'ElMessiri', // Apply font family
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           name,
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'ElMessiri', // Apply font family
//                           ),
//                         ),
//                         SizedBox(height: 4.0),
//                         Text(
//                           description,
//                           style: TextStyle(
//                             fontSize: 14.0,
//                             color: Colors.grey[600],
//                             fontFamily: 'ElMessiri', // Apply font family
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'الحالة: $status',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   color: _getStatusColor(status),
//                   fontFamily: 'ElMessiri', // Apply font family
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Color _generateRandomColor() {
//     final random = Random();
//     return Color.fromRGBO(
//       random.nextInt(256),
//       random.nextInt(256),
//       random.nextInt(256),
//       1,
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'تم القبول':
//         return Colors.green;
//       case 'تم الرفض':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   void _showConfirmationDialog(
//     BuildContext context,
//     String action,
//     VoidCallback onConfirm,
//   ) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('تأكيد $action'),
//           content: Text('هل أنت متأكد أنك تريد $action هذا الطلب؟'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('لا'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 onConfirm();
//               },
//               child: Text('نعم'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
