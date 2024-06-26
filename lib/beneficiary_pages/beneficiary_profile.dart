// import 'package:flutter/material.dart';
// import 'package:flutter_application_athar_project/pages/notificationPage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:math';
// import 'package:image_picker/image_picker.dart';

// class BeneficiaryProfilePage extends StatefulWidget {
//   final String? email;

//   BeneficiaryProfilePage({required this.email});

//   @override
//   _BeneficiaryProfilePageState createState() => _BeneficiaryProfilePageState();
// }

// class _BeneficiaryProfilePageState extends State<BeneficiaryProfilePage> {
//   int notificationCount = 0;

//   Future<Map<String, dynamic>> fetchBeneficiary(String email) async {
//     final response = await http.get(
//         Uri.parse('http://192.168.1.140:3000/user/beneficiary?email=$email'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else if (response.statusCode == 404) {
//       throw Exception('Beneficiary not found');
//     } else {
//       throw Exception('Failed to load beneficiary');
//     }
//   }

//   Color getRandomColor() {
//     Random random = Random();
//     return Color.fromARGB(
//       255,
//       random.nextInt(256),
//       random.nextInt(256),
//       random.nextInt(256),
//     );
//   }

//   Future<void> uploadDocument(String donationId, String imagePath) async {
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('http://192.168.1.140:3000/user/upload3'),
//       );

//       request.fields['donationId'] = donationId;
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'file',
//           imagePath,
//         ),
//       );

//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         print('Document uploaded successfully');
//         // Handle success message or further action if needed
//       } else {
//         print('Failed to upload document: ${response.statusCode}');
//         // Handle error message or retry logic
//       }
//     } catch (e) {
//       print('Error uploading document: $e');
//       // Handle error message or retry logic
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(248, 255, 255, 255),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 236, 233, 233),
//         title: const Text(
//           'ملف المستفيد',
//           style: TextStyle(
//             fontFamily: 'ElMessiri',
//             color: Color.fromARGB(255, 2, 2, 88),
//           ),
//         ),
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.notifications),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => NotificationPage()),
//                   );
//                 },
//               ),
//               Positioned(
//                 top: 10,
//                 right: 10,
//                 child: Container(
//                   width: 20,
//                   height: 20,
//                   decoration: const BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       notificationCount.toString(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'ElMessiri',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: FutureBuilder<Map<String, dynamic>>(
//           future: fetchBeneficiary(widget.email!),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   'خطأ: ${snapshot.error}',
//                   style: const TextStyle(
//                     fontFamily: 'ElMessiri',
//                     color: Color.fromARGB(255, 2, 2, 88),
//                   ),
//                 ),
//               );
//             } else {
//               if (!snapshot.hasData || snapshot.data == null) {
//                 return const Center(
//                   child: Text(
//                     'لا توجد بيانات متاحة',
//                     style: TextStyle(
//                       fontFamily: 'ElMessiri',
//                       color: Color.fromARGB(255, 2, 2, 88),
//                     ),
//                   ),
//                 );
//               }

//               final beneficiaryData = snapshot.data!;
//               final donation = beneficiaryData['donation'];

//               if (donation == null) {
//                 return const Center(
//                   child: Text(
//                     'لا توجد بيانات تبرع متاحة',
//                     style: TextStyle(
//                       fontFamily: 'ElMessiri',
//                       color: Color.fromARGB(255, 2, 2, 88),
//                     ),
//                   ),
//                 );
//               }

//               double totalGoal =
//                   (donation['donation_target'] as int).toDouble();
//               double totalRaised =
//                   (donation['current_donation'] as int).toDouble();
//               double progress = totalRaised / totalGoal;

//               String beneficiaryName = beneficiaryData['beneficiary_name'];
//               String firstLetter =
//                   beneficiaryName.isNotEmpty ? beneficiaryName[0] : '';

//               return SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // صورة الملف الشخصي واسم المستفيد
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 60,
//                             backgroundColor: getRandomColor(),
//                             child: Text(
//                               firstLetter,
//                               style: const TextStyle(
//                                 fontSize: 40,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 fontFamily: 'ElMessiri',
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             beneficiaryName,
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                               fontFamily: 'ElMessiri',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // معلومات المستفيد
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 236, 233, 233),
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 16, horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'حول المستفيد',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'ElMessiri',
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               const Icon(Icons.location_city,
//                                   color: Color.fromARGB(255, 2, 2, 88)),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'المدينة: ${beneficiaryData['city']}',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontFamily: 'ElMessiri',
//                                   color: Color.fromARGB(255, 2, 2, 88),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               const Icon(Icons.home,
//                                   color: Color.fromARGB(255, 2, 2, 88)),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'العنوان: ${beneficiaryData['address']}',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontFamily: 'ElMessiri',
//                                   color: Color.fromARGB(255, 2, 2, 88),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               const Icon(Icons.phone,
//                                   color: Color.fromARGB(255, 2, 2, 88)),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'الهاتف: ${beneficiaryData['phone']}',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontFamily: 'ElMessiri',
//                                   color: Color.fromARGB(255, 2, 2, 88),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     // نظرة عامة موجزة
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 236, 233, 233),
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 16, horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'معلومات التبرع',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'ElMessiri',
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               const Icon(Icons.account_balance_wallet,
//                                   color: Color.fromARGB(255, 2, 2, 88)),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'الهدف: ${donation['donation_target']} ريال',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontFamily: 'ElMessiri',
//                                   color: Color.fromARGB(255, 2, 2, 88),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               const Icon(Icons.attach_money,
//                                   color: Color.fromARGB(255, 2, 2, 88)),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'المبلغ المجموع: ${donation['current_donation']} ريال',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontFamily: 'ElMessiri',
//                                   color: Color.fromARGB(255, 2, 2, 88),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           LinearProgressIndicator(
//                             value: progress,
//                             backgroundColor: Colors.grey.withOpacity(0.2),
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               const Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green,
//                                   foregroundColor: Colors.white,
//                                   elevation: 5,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                                onPressed: () async {
//   final ImagePicker _picker = ImagePicker();
//   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//   if (image != null) {
// if (donation != null && donation['donation_id'] != null) {
//   String donationId = donation['donation_id'].toString(); // Convert int to String if necessary
//   await uploadDocument(donationId, image.path);
// } else {
//   print('Donation ID is null or not available');
//   // Handle the case where donation['_id'] is null or not available
// }

//   } else {
//     // User canceled the picker
//     print('User canceled image picker');
//   }
// },
//                                 child: Text(
//                                   'تحميل المستند',
//                                   style: TextStyle(
//                                     fontFamily: 'ElMessiri',
//                                     color: Color.fromARGB(255, 2, 2, 88),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/pages/notificationPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import this for File class

class BeneficiaryProfilePage extends StatefulWidget {
  final String? email;

  BeneficiaryProfilePage({required this.email});

  @override
  _BeneficiaryProfilePageState createState() => _BeneficiaryProfilePageState();
}

class _BeneficiaryProfilePageState extends State<BeneficiaryProfilePage> {
  int notificationCount = 0;
  File? _image; // Variable to hold the selected image file

  Future<Map<String, dynamic>> fetchBeneficiary(String email) async {
    final response = await http.get(
        Uri.parse('http://192.168.1.140:3000/user/beneficiary?email=$email'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Beneficiary not found');
    } else {
      throw Exception('Failed to load beneficiary');
    }
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  Future<void> uploadDocument(String donationId, String imagePath) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.140:3000/user/upload3'),
      );

      request.fields['donationId'] = donationId;
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imagePath,
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Document uploaded successfully');
        // Handle success message or further action if needed
      } else {
        print('Failed to upload document: ${response.statusCode}');
        // Handle error message or retry logic
      }
    } catch (e) {
      print('Error uploading document: $e');
      // Handle error message or retry logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 233, 233),
        title: const Text(
          'ملف المستفيد',
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromARGB(255, 2, 2, 88),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                },
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchBeneficiary(widget.email!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'خطأ: ${snapshot.error}',
                  style: const TextStyle(
                    fontFamily: 'ElMessiri',
                    color: Color.fromARGB(255, 2, 2, 88),
                  ),
                ),
              );
            } else {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text(
                    'لا توجد بيانات متاحة',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Color.fromARGB(255, 2, 2, 88),
                    ),
                  ),
                );
              }

              final beneficiaryData = snapshot.data!;
              final donation = beneficiaryData['donation'];

              if (donation == null) {
                return const Center(
                  child: Text(
                    'لا توجد بيانات تبرع متاحة',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Color.fromARGB(255, 2, 2, 88),
                    ),
                  ),
                );
              }

              double totalGoal = (donation['donation_target'] as int).toDouble();
              double totalRaised = (donation['current_donation'] as int).toDouble();
              double progress = totalRaised / totalGoal;

              String beneficiaryName = beneficiaryData['beneficiary_name'];
              String firstLetter = beneficiaryName.isNotEmpty ? beneficiaryName[0] : '';

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // صورة الملف الشخصي واسم المستفيد
                    Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: getRandomColor(),
                            child: Text(
                              firstLetter,
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            beneficiaryName,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 2, 2, 88),
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // معلومات المستفيد
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 233, 233),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'حول المستفيد',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ElMessiri',
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.location_city, color: Color.fromARGB(255, 2, 2, 88)),
                              const SizedBox(width: 8),
                              Text(
                                'المدينة: ${beneficiaryData['city']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.home, color: Color.fromARGB(255, 2, 2, 88)),
                              const SizedBox(width: 8),
                              Text(
                                'العنوان: ${beneficiaryData['address']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: Color.fromARGB(255, 2, 2, 88)),
                              const SizedBox(width: 8),
                              Text(
                                'الهاتف: ${beneficiaryData['phone']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // نظرة عامة موجزة
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 233, 233),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'معلومات التبرع',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ElMessiri',
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.account_balance_wallet, color: Color.fromARGB(255, 2, 2, 88)),
                              const SizedBox(width: 8),
                              Text(
                                'الهدف: ${donation['donation_target']} ريال',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.attach_money, color: Color.fromARGB(255, 2, 2, 88)),
                              const SizedBox(width: 8),
                              Text(
                                'المبلغ المجموع: ${donation['current_donation']} ريال',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _image == null
                              ? const SizedBox.shrink()
                              : Image.file(_image!), // Display selected image if available
                          const SizedBox(height: 8),


Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    if (totalRaised == totalGoal)
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () async {
          final ImagePicker _picker = ImagePicker();
          final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

          if (image != null) {
            setState(() {
              _image = File(image.path);
            });

            try {
              final donation = beneficiaryData['donation'];
              if (donation != null && donation['donation_id'] != null) {
                String donationId = donation['donation_id'].toString(); // Convert int to String if necessary
                await uploadDocument(donationId, image.path);
              } else {
                print('Donation ID is null or not available');
                // Handle the case where donation['_id'] is null or not available
              }
            } catch (e) {
              print('Error uploading document: $e');
              // Handle error message or retry logic
            }
          } else {
            // User canceled the picker
            print('User canceled image picker');
          }
        },
        child: Text(
          'تحميل المستند',
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromARGB(255, 2, 2, 88),
          ),
        ),
      ),
  ],
)



//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                              ElevatedButton(
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.green,
//     foregroundColor: Colors.white,
//     elevation: 5,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//     ),
//   ),
//   onPressed: () async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         _image = File(image.path);
//       });

//       try {
//         final donation = beneficiaryData['donation'];
//         if (donation != null && donation['donation_id'] != null) {
//           String donationId = donation['donation_id'].toString(); // Convert int to String if necessary
//           await uploadDocument(donationId, image.path);
//         } else {
//           print('Donation ID is null or not available');
//           // Handle the case where donation['_id'] is null or not available
//         }
//       } catch (e) {
//         print('Error uploading document: $e');
//         // Handle error message or retry logic
//       }
//     } else {
//       // User canceled the picker
//       print('User canceled image picker');
//     }
//   },
//   child: Text(
//     'تحميل المستند',
//     style: TextStyle(
//       fontFamily: 'ElMessiri',
//       color: Color.fromARGB(255, 2, 2, 88),
//     ),
//   ),
// ),

//                             ],
//                           ),
                        
                        
                        
                        
                        
                        
                        
                        
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
