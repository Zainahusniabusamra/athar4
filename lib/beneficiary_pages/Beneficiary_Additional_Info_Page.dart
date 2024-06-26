import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class BeneficiaryAdditionalInfoPage extends StatefulWidget {
  final String userName;
  final String email;
  final String password;
  final String userType;
  final int age;
  final int phone;

  BeneficiaryAdditionalInfoPage({
    required this.userName,
    required this.email,
    required this.password,
    required this.userType,
    required this.age,
    required this.phone,
  });

  @override
  _BeneficiaryAdditionalInfoPageState createState() =>
      _BeneficiaryAdditionalInfoPageState();
}

class _BeneficiaryAdditionalInfoPageState
    extends State<BeneficiaryAdditionalInfoPage> {
  final List<XFile> _imageFiles = [];
  final List<XFile> _fileDocuments = [];
  final TextEditingController cityController = TextEditingController();
  final TextEditingController descriptionPersonController =
      TextEditingController();
  final TextEditingController descriptionNeedController =
      TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> _getImage(ImageSource source) async {
    final pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 80,
    );
    if (pickedFiles != null) {
      setState(() {
        _imageFiles.addAll(pickedFiles);
      });
    }
  }

  Future<void> _getDocument(ImageSource source) async {
    final pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 80,
    );
    if (pickedFiles != null) {
      setState(() {
        _fileDocuments.addAll(pickedFiles);
      });
    }
  }

  void submitForm() async {
    // Prepare form data
    var formData = {
      'userName': widget.userName,
      'email': widget.email,
      'password': widget.password,
      'userType': widget.userType,
      'age': widget.age.toString(),
      'phone': widget.phone.toString(),
      'city': cityController.text,
      'address': addressController.text,
      'bio': descriptionPersonController.text,
      'title': titleController.text,
      'amount': amountController.text,
      'description': descriptionNeedController.text,
    };

    // Prepare the request
    var url = Uri.parse('http://192.168.1.140:3000/user/submit-form-pending');
    var request = http.MultipartRequest('POST', url);

    // Attach image files if available
    for (var image in _imageFiles) {
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
    }

    // Attach document files if available
    for (var document in _fileDocuments) {
      request.files
          .add(await http.MultipartFile.fromPath('file', document.path));
    }

    // Add form fields
    request.fields.addAll(formData);

    // Send the request
    var response = await request.send();


    if (response.statusCode == 200) {
    // Request successful
    print('Form submitted successfully');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم التسجيل بنجاح', style: TextStyle(color: Color.fromARGB(255, 2, 2, 88), fontFamily: 'ElMessiri')),
      ),
    );
  } else {
    // Request failed
    print('Failed to submit form');
    print(response.reasonPhrase);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('فشل التسجيل: ${response.reasonPhrase}', style: TextStyle(color: Color.fromARGB(255, 2, 2, 88), fontFamily: 'ElMessiri')),
      ),
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('معلومات إضافية للمستفيد', style: TextStyle(fontFamily: 'ElMessiri')),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'معلومات المستخدم:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 2, 88), fontFamily: 'ElMessiri'),
              ),
              SizedBox(height: 10),
              Text('اسم المستخدم: ${widget.userName}', style: TextStyle(color: Color.fromARGB(255, 2, 2, 88), fontFamily: 'ElMessiri')),
              SizedBox(height: 20),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'المدينة',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'العنوان',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: descriptionPersonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'نبذة/وصف (عن نفسك)',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
              ),
              SizedBox(height: 20),
              Text(
                'معلومات احتياج التبرع:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 2, 88), fontFamily: 'ElMessiri'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'عنوان الحاجة',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'المبلغ المستهدف للتبرع',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: descriptionNeedController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'الوصف',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _getDocument(ImageSource.camera),
                      child: Text('الكاميرا', style: TextStyle(fontFamily: 'ElMessiri')),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _getDocument(ImageSource.gallery),
                      child: Text('المعرض', style: TextStyle(fontFamily: 'ElMessiri')),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _imageFiles.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    File(_imageFiles[index].path),
                    width: 100,
                    height: 100,
                  );
                },
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _fileDocuments.length,
                itemBuilder: (context, index) {
                  return Text(_fileDocuments[index].path.split('/').last, style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)));
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: Text('إرسال', style: TextStyle(fontFamily: 'ElMessiri')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// class BeneficiaryAdditionalInfoPage extends StatefulWidget {
//   final String userName;
//   final String email;
//   final String password;
//   final String userType;
//   final int age;
//   final int phone;

//   BeneficiaryAdditionalInfoPage({
//     required this.userName,
//     required this.email,
//     required this.password,
//     required this.userType,
//     required this.age,
//     required this.phone,
//   });

//   @override
//   _BeneficiaryAdditionalInfoPageState createState() =>
//       _BeneficiaryAdditionalInfoPageState();
// }

// class _BeneficiaryAdditionalInfoPageState
//     extends State<BeneficiaryAdditionalInfoPage> {
//   final List<XFile> _imageFiles = [];
//   final List<XFile> _fileDocuments = [];
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController descriptionPersonController =
//       TextEditingController();
//   final TextEditingController descriptionNeedController =
//       TextEditingController();
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   Future<void> _getImage(ImageSource source) async {
//     final pickedFiles = await ImagePicker().pickMultiImage(
//       imageQuality: 80,
//     );
//     if (pickedFiles != null) {
//       setState(() {
//         _imageFiles.addAll(pickedFiles);
//       });
//     }
//   }

//   Future<void> _getDocument(ImageSource source) async {
//     final pickedFiles = await ImagePicker().pickMultiImage(
//       imageQuality: 80,
//     );
//     if (pickedFiles != null) {
//       setState(() {
//         _fileDocuments.addAll(pickedFiles);
//       });
//     }
//   }

//   void submitForm() async {
//     // Prepare form data
//     var formData = {
//       'userName': widget.userName,
//       'email': widget.email,
//       'password': widget.password,
//       'userType': widget.userType,
//       'age': widget.age.toString(),
//       'phone': widget.phone.toString(),
//       'city': cityController.text,
//       'address': addressController.text,
//       'bio': descriptionPersonController.text,
//       'title': titleController.text,
//       'amount': amountController.text,
//       'description': descriptionNeedController.text,
//     };

//     // Prepare the request
//     var url = Uri.parse('http://192.168.1.140:3000/user/submit-form-pending');
//     var request = http.MultipartRequest('POST', url);

//     // Attach image files if available
//     for (var image in _imageFiles) {
//       request.files.add(await http.MultipartFile.fromPath('file', image.path));
//     }

//     // Attach document files if available
//     for (var document in _fileDocuments) {
//       request.files
//           .add(await http.MultipartFile.fromPath('file', document.path));
//     }

//     // Add form fields
//     request.fields.addAll(formData);

//     // Send the request
//     var response = await request.send();


//     if (response.statusCode == 200) {
//     // Request successful
//     print('Form submitted successfully');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('تم التسجيل بنجاح'),
//       ),
//     );
//   } else {
//     // Request failed
//     print('Failed to submit form');
//     print(response.reasonPhrase);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('فشل التسجيل: ${response.reasonPhrase}'),
//       ),
//     );
//   }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('معلومات إضافية للمستفيد'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'معلومات المستخدم:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text('اسم المستخدم: ${widget.userName}'),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: cityController,
//               decoration: InputDecoration(
//                 labelText: 'المدينة',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: addressController,
//               decoration: InputDecoration(
//                 labelText: 'العنوان',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: descriptionPersonController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: 'نبذة/وصف (عن نفسك)',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'معلومات احتياج التبرع:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: titleController,
//               decoration: InputDecoration(
//                 labelText: 'عنوان الحاجة',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'المبلغ المستهدف للتبرع',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: descriptionNeedController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: 'الوصف',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _getDocument(ImageSource.camera),
//                     child: Text('الكاميرا'),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _getDocument(ImageSource.gallery),
//                     child: Text('المعرض'),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: _imageFiles.length,
//               itemBuilder: (context, index) {
//                 return Image.file(
//                   File(_imageFiles[index].path),
//                   width: 100,
//                   height: 100,
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: _fileDocuments.length,
//               itemBuilder: (context, index) {
//                 return Text(_fileDocuments[index].path.split('/').last);
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: submitForm,
//               child: Text('إرسال'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// class BeneficiaryAdditionalInfoPage extends StatefulWidget {
//   final String userName;
//   final String email;
//   final String password;
//   final String userType;
//   final int age;
//   final int phone;

//   BeneficiaryAdditionalInfoPage({
//     required this.userName,
//     required this.email,
//     required this.password,
//     required this.userType,
//     required this.age,
//     required this.phone,
//   });

//   @override
//   _BeneficiaryAdditionalInfoPageState createState() =>
//       _BeneficiaryAdditionalInfoPageState();
// }

// class _BeneficiaryAdditionalInfoPageState
//     extends State<BeneficiaryAdditionalInfoPage> {
//   final List<XFile> _imageFiles = [];
//   final List<XFile> _fileDocuments = [];
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController descriptionPersonController =
//       TextEditingController();
//   final TextEditingController descriptionNeedController =
//       TextEditingController();
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   Future<void> _getImage(ImageSource source) async {
//     final pickedFiles = await ImagePicker().pickMultiImage(
//       imageQuality: 80,
//     );
//     if (pickedFiles != null) {
//       setState(() {
//         _imageFiles.addAll(pickedFiles);
//       });
//     }
//   }

//   Future<void> _getDocument(ImageSource source) async {
//     final pickedFiles = await ImagePicker().pickMultiImage(
//       imageQuality: 80,
//     );
//     if (pickedFiles != null) {
//       setState(() {
//         _fileDocuments.addAll(pickedFiles);
//       });
//     }
//   }

//   void submitForm() async {
//     // Prepare form data
//     var formData = {
//       'userName': widget.userName,
//       'email': widget.email,
//       'password': widget.password,
//       'userType': widget.userType,
//       'age': widget.age.toString(),
//       'phone': widget.phone.toString(),
//       'city': cityController.text,
//       'address': addressController.text,
//       'bio': descriptionPersonController.text,
//       'title': titleController.text,
//       'amount': amountController.text,
//       'description': descriptionNeedController.text,
//     };

//     // Prepare the request
//     var url = Uri.parse('http://192.168.1.140:3000/user/submit-form-pending');
//     var request = http.MultipartRequest('POST', url);

//     // Attach image files if available
//     for (var image in _imageFiles) {
//       request.files.add(await http.MultipartFile.fromPath('file', image.path));
//     }

//     // Attach document files if available
//     for (var document in _fileDocuments) {
//       request.files
//           .add(await http.MultipartFile.fromPath('file', document.path));
//     }

//     // Add form fields
//     request.fields.addAll(formData);

//     // Send the request
//     var response = await request.send();


//     if (response.statusCode == 200) {
//     // Request successful
//     print('Form submitted successfully');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Registration successful'),
//       ),
//     );
//   } else {
//     // Request failed
//     print('Failed to submit form');
//     print(response.reasonPhrase);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Failed to register: ${response.reasonPhrase}'),
//       ),
//     );
//   }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Beneficiary Additional Info'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'User Information:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text('Username: ${widget.userName}'),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: cityController,
//               decoration: InputDecoration(
//                 labelText: 'City',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: addressController,
//               decoration: InputDecoration(
//                 labelText: 'Address',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: descriptionPersonController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: 'Bio/Description (about yourself)',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Donation Need Information:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: titleController,
//               decoration: InputDecoration(
//                 labelText: 'Need Title',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Target Donation Amount',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: descriptionNeedController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _getDocument(ImageSource.camera),
//                     child: Text('Camera'),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _getDocument(ImageSource.gallery),
//                     child: Text('Gallery'),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: _imageFiles.length,
//               itemBuilder: (context, index) {
//                 return Image.file(
//                   File(_imageFiles[index].path),
//                   width: 100,
//                   height: 100,
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: _fileDocuments.length,
//               itemBuilder: (context, index) {
//                 return Text(_fileDocuments[index].path.split('/').last);
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: submitForm,
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
