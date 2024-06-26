
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DonationDetailsPage extends StatelessWidget {
  final int doneDonationsId;
  final String personName;
  final String doneDonationsName;
  final DateTime startDate;
  final DateTime endDate;
  final int targetAmount;
  final VoidCallback onGenerateReport; // New callback

  DonationDetailsPage({
    required this.doneDonationsId,
    required this.personName,
    required this.doneDonationsName,
    required this.startDate,
    required this.endDate,
    required this.targetAmount,
    required this.onGenerateReport, // Initialize callback
  });

  Future<void> generatePDF(BuildContext context) async {
    final url = Uri.parse('http://192.168.1.140:3000/user/generate-pdf');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'doneDonationsId': doneDonationsId,
        'personName': personName,
        'doneDonationsName': doneDonationsName,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'targetAmount': targetAmount,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print('PDF generated successfully: ${responseBody['filePath']}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إنشاء التقرير بنجاح'),
          duration: Duration(seconds: 3),
        ),
      );
      onGenerateReport(); // Call the callback to show the button
    } else {
      print('Failed to generate PDF');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('فشل إنشاء التقرير'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'تفاصيل التبرع',
          style: TextStyle(
            fontFamily: 'ElMessiri',
            fontSize: 18,
            color: Color.fromARGB(255, 241, 241, 241),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 2, 88),
        elevation: 0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: const Color.fromARGB(255, 236, 233, 233),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'رقم التبرع:',
                            style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                          Text(
                            '$doneDonationsId',
                            style: const TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'اسم التبرع:',
                            style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                          Text(
                            '$doneDonationsName',
                            style: const TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                color: const Color.fromARGB(255, 236, 233, 233),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'تاريخ البداية:',
                            style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                          Text(
                            '${startDate.day}/${startDate.month}/${startDate.year}',
                            style: const TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'تاريخ الانتهاء:',
                            style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                          Text(
                            '${endDate.day}/${endDate.month}/${endDate.year}',
                            style: const TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                color: const Color.fromARGB(255, 236, 233, 233),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'اسم الشخص:',
                            style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                          Text(
                            '$personName',
                            style: const TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'المبلغ المستهدف:',
                            style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                          Text(
                            '$targetAmount',
                            style: const TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/imgs/docum.jpeg',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    generatePDF(context);
                  },
                  child: const Text(
                    'انشاء تقرير',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 2, 2, 88),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DonationDetailsPage extends StatelessWidget {
//   final int doneDonationsId;
//   final String personName;
//   final String doneDonationsName;
//   final DateTime startDate;
//   final DateTime endDate;
//   final int targetAmount;

//   DonationDetailsPage({
//     required this.doneDonationsId,
//     required this.personName,
//     required this.doneDonationsName,
//     required this.startDate,
//     required this.endDate,
//     required this.targetAmount,
//   });

//   Future<void> generatePDF(BuildContext context) async {
//     final url = Uri.parse('http://192.168.1.140:3000/user/generate-ppdf');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'doneDonationsId': doneDonationsId,
//         'personName': personName,
//         'doneDonationsName': doneDonationsName,
//         'startDate': startDate.toIso8601String(),
//         'endDate': endDate.toIso8601String(),
//         'targetAmount': targetAmount,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final responseBody = json.decode(response.body);
//       print('PDF generated successfully: ${responseBody['filePath']}');
//        // Show a SnackBar to indicate success
//     ScaffoldMessenger.of(context).showSnackBar(
//    const   SnackBar(
//         content: Text('تم إنشاء التقرير بنجاح'),
//         duration: Duration(seconds: 3), // Adjust the duration as needed
//       ),
//     );
//   } else {
//     print('Failed to generate PDF');
//     // Optionally, show a SnackBar for failure
//     ScaffoldMessenger.of(context).showSnackBar(
//      const SnackBar(
//         content: Text('فشل إنشاء التقرير'),
//         duration: Duration(seconds: 3), // Adjust the duration as needed
//       ),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(248, 255, 255, 255),
//       appBar: AppBar(
//         title:const Text(
//           'تفاصيل التبرع',
//           style: TextStyle(
//             fontFamily: 'ElMessiri',
//             fontSize: 18,
//             color: Color.fromARGB(255, 241, 241, 241),
//           ),
//         ),
//         backgroundColor: Color.fromARGB(255, 2, 2, 88),
//         elevation: 0,
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 color: const Color.fromARGB(255, 236, 233, 233),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                          const Text(
//                             'رقم التبرع:',
//                             style: TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                           Text(
//                             '$doneDonationsId',
//                             style:const TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                         const  Text(
//                             'اسم التبرع:',
//                             style: TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                           Text(
//                             '$doneDonationsName',
//                             style:const TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Card(
//                 elevation: 5,
//                 color: const Color.fromARGB(255, 236, 233, 233),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'تاريخ البداية:',
//                             style: TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                           Text(
//                             '${startDate.day}/${startDate.month}/${startDate.year}',
//                             style:const TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                         const  Text(
//                             'تاريخ الانتهاء:',
//                             style: TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                           Text(
//                             '${endDate.day}/${endDate.month}/${endDate.year}',
//                             style:const TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Card(
//                 elevation: 5,
//                 color: const Color.fromARGB(255, 236, 233, 233),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'اسم الشخص:',
//                             style: TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                           Text(
//                             '$personName',
//                             style:const TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                          const Text(
//                             'المبلغ المستهدف:',
//                             style: TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                           Text(
//                             '$targetAmount',
//                             style:const TextStyle(
//                               fontFamily: 'ElMessiri',
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 alignment: Alignment.center,
//                 child: Image.asset(
//                   'assets/imgs/docum.jpeg',
//                   fit: BoxFit.cover,
//                   width: 200,
//                   height: 200,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     generatePDF( context);
//                   },
//                   child: Text(
//                     'انشاء تقرير',
//                     style: TextStyle(
//                       fontFamily: 'ElMessiri',
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 2, 2, 88),
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


