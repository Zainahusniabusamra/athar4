import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:flutter_application_athar_project/admin_pages/add_lists_detailes.dart';

class RequestDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> request;

  const RequestDetailsScreen({Key? key, required this.request}) : super(key: key);

  @override
  _RequestDetailsScreenState createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  late TextEditingController subjectController;
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    subjectController = TextEditingController();
    messageController = TextEditingController();
  }

  Future<void> submitFormData() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.140:3000/user/submit-form'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'beneficiary_id': widget.request['beneficiary_id'],
        'userName': widget.request['name'],
        'email': widget.request['email'],
        'password': widget.request['password'],
        'userType': widget.request['userType'],
        'age': widget.request['age'],
        'phone': widget.request['phone'],
      }),
    );

    if (response.statusCode == 200) {
      print('تم إرسال النموذج بنجاح');
      print(response.body); // Response from the backend
    } else {
      print('فشل في إرسال النموذج');
      print(response.body); // Error message from the backend
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

        title: Text('تفاصيل الطلب', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _generateRandomColor(),
                  ),
                  child: Center(
                    child: Text(
                      widget.request['name'].substring(0, 1), // Display first letter of name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  widget.request['name'],
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri',
                    color: Color.fromARGB(255, 2, 2, 88),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  widget.request['description'],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                    fontFamily: 'ElMessiri',
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  'الحالة: ${widget.request['status']}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _getStatusColor(widget.request['status']),
                    fontFamily: 'ElMessiri',
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'معلومات المستند:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                  color: Color.fromARGB(255, 2, 2, 88),
                ),
              ),
              SizedBox(height: 8.0),
              Card(
                color: const Color.fromARGB(255, 236, 233, 233),
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اسم المستند: ${widget.request['documentName']}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ElMessiri',
                          color: Color.fromARGB(255, 2, 2, 88),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'الوصف: ${widget.request['document_description']}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        height: 200.0,
                        child: Image.network(
                          'http://192.168.1.140:3000/uploads/${widget.request['document_content']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'تاريخ التحميل: ${widget.request['uploadDate']}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'المبلغ المستهدف: ${widget.request['targetAmount']}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              if (widget.request['status'].toLowerCase() == 'pending') // Render buttons only if status is pending
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _updateRequestStatus('تم القبول');
                        },
                        child: Text('قبول', style: TextStyle(fontFamily: 'ElMessiri')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _updateRequestStatus('تم الرفض');
                        },
                        child: Text('رفض', style: TextStyle(fontFamily: 'ElMessiri')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showEmailDialog(context);
                  },
                  child: Text('إرسال بريد إلكتروني', style: TextStyle(fontFamily: 'ElMessiri', color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 2, 2, 88),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageUploadPage(request: widget.request),
                      ),
                    );
                  },
                  child: Text('اختيار فئة', style: TextStyle(fontFamily: 'ElMessiri', color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 2, 2, 88),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}



  ElevatedButton _buildActionButton({required String text, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontFamily: 'ElMessiri', color: Colors.white)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
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

  void _showEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('إرسال بريد إلكتروني', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: subjectController,
                decoration: InputDecoration(labelText: 'الموضوع', labelStyle: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
              ),
              TextField(
                controller: messageController,
                decoration: InputDecoration(labelText: 'الرسالة', labelStyle: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
                maxLines: 3,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
            ),
            TextButton(
              onPressed: () {
                _sendEmail(context, subjectController.text, messageController.text);
              },
              child: Text('إرسال', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
            ),
          ],
        );
      },
    );
  }

  void _sendEmail(BuildContext context, String subject, String message) async {
    final String recipient = widget.request['email']; // Get recipient email from request
    final String response = await sendEmail(recipient, subject, message);

    // Display the response to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response, style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
      ),
    );
  }

  Future<String> sendEmail(String to, String subject, String text) async {
    final Uri uri = Uri.parse('http://192.168.1.140:3000/user/send-email');
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {
      'to': to,
      'subject': subject,
      'text': text
    };

    try {
      final http.Response response = await http.post(uri, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        return 'تم إرسال البريد الإلكتروني بنجاح';
      } else {
        return 'فشل في إرسال البريد الإلكتروني: ${response.statusCode}';
      }
    } catch (e) {
      return 'فشل في إرسال البريد الإلكتروني: $e';
    }
  }

  void _updateRequestStatus(String newStatus) async {
    final int requestId = widget.request['id'];
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('تأكيد $newStatus', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
            content: Text('هل أنت متأكد أنك تريد $newStatus هذا الطلب؟', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('لا', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (newStatus == 'تم القبول') {
                    // Call submitForm() when status is updated to "Accepted"
                    await submitFormData();
                  }
                  final response = await http.post(
                    Uri.parse('http://192.168.1.140:3000/user/update_request_status'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, dynamic>{
                      'requestId': requestId,
                      'newStatus': newStatus,
                    }),
                  );

                  if (response.statusCode == 200) {
                    setState(() {
                      widget.request['status'] = newStatus;
                    });
                  } else {
                    throw Exception('فشل في تحديث حالة الطلب');
                  }
                },
                child: Text('نعم', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error updating request status: $e');
    }
  }

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
