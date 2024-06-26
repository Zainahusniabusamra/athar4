
import 'dart:typed_data';
import 'pdf_viewer_widget.dart'; // Import your PDF viewer widget
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_athar_project/admin_pages/reporting_and_analytics_page.dart';
import 'page6.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'ElMessiri',
        primarySwatch: Colors.blue,
      ),
      home: page2(),
    );
  }
}

class page2 extends StatefulWidget {
  const page2({Key? key}) : super(key: key);

  @override
  page2State createState() => page2State();
}

class page2State extends State<page2> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(248, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(248, 255, 255, 255),
          title: const Text(
            'التبرعات',
            style: TextStyle(
              fontFamily: 'ElMessiri',
              color: Color.fromARGB(255, 2, 2, 88),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            labelStyle: const TextStyle(
              fontFamily: 'ElMessiri',
              color: Color.fromARGB(255, 2, 2, 88),
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'ElMessiri',
              color: Color.fromARGB(255, 2, 2, 88),
            ),
            tabs: const [
              Tab(text: 'لم يتم التحقق'),
              Tab(text: 'معلق'),
              Tab(text: 'منتهي'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            DonationList(status: 'not_checked'),
            DonationList(status: 'pending'),
            DonationList(status: 'finished'),
          ],
        ),
      ),
    );
  }
}

class Donation {
  final int donationId;
  final String donationName;

  Donation({required this.donationId, required this.donationName});

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      donationId: json['donation_id'],
      donationName: json['donation_name'],
    );
  }
}

class DonationWithDocuments {
  final int doneDonationsId;
  final String personName;
  final String doneDonationsName;
  final Uint8List documents; // Assuming documents is an image
  final DateTime startDate; // Change type to DateTime
  final DateTime endDate; // Change type to DateTime
  final int targetAmount;
  bool showReportButton; // New field

  DonationWithDocuments({
    required this.doneDonationsId,
    required this.personName,
    required this.doneDonationsName,
    required this.documents,
    required this.startDate,
    required this.endDate,
    required this.targetAmount,
    this.showReportButton = false, // Initialize with false
  });

  factory DonationWithDocuments.fromJson(Map<String, dynamic> json) {
    Uint8List? docBytes;
    if (json['documents'] != null) {
      // Handle case where documents might not be a string
      if (json['documents'] is String) {
        docBytes = base64Decode(json['documents']);
      } else {
        // Handle unexpected type if needed
        print('Unexpected type for documents: ${json['documents'].runtimeType}');
      }
    }

    return DonationWithDocuments(
      doneDonationsId: json['done_donations_id'] ?? 0, // Provide default value if necessary
      personName: json['person_name'] ?? '',
      doneDonationsName: json['done_donations_name'] ?? '',
      documents: docBytes ?? Uint8List(0), // Handle null or empty case
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : DateTime.now(),
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : DateTime.now(),
      targetAmount: json['target_amount'] ?? 0, // Provide default value if necessary
      showReportButton: false, // Initialize with false
    );
  }
}

class DonationCard extends StatefulWidget {
  final Donation donation;
  final bool showButton;

  DonationCard({required this.donation, required this.showButton});

  @override
  _DonationCardState createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  bool buttonClicked = false;

  void _handleButtonClick() {
    _showConfirmationDialog();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Text(
            'تم الانتهاء من عملية التبرع ارجو ارسال وثائق اللازمة عند التوفر',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 2, 2, 88),
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'هل أنت متأكد أنك تريد إرسال هذه الرسالة للمستفيد؟',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  color: Color.fromARGB(255, 2, 2, 88),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'إلغاء',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'موافق',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                // Implement your donation processing logic here
                setState(() {
                  buttonClicked = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 236, 233, 233),
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showButton && !buttonClicked)
             
            Text(
              'رقم: ${widget.donation.donationId}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'ElMessiri',
                color: Color.fromARGB(255, 2, 2, 88),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'الحالة: ${widget.donation.donationName}',
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'ElMessiri',
                color: Color.fromARGB(255, 2, 2, 88),
              ),
            ),
             
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: _handleButtonClick,
                child: const Text('تم التبرع' ,style: TextStyle(
                      fontFamily: 'ElMessiri',
                      fontSize: 12,
                      color: Colors.white,
                    ),),
                
                 style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 2, 88),
                    padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                
              ),
          ],
        ),
      ),
    );
  }
}

class DonationWithDocumentsCard extends StatelessWidget {
  final DonationWithDocuments donation;
  final VoidCallback onGenerateReport; // Existing callback
  final VoidCallback onRemoveDonation; // New callback

  DonationWithDocumentsCard({
    required this.donation,
    required this.onGenerateReport,
    required this.onRemoveDonation,
  });

  void _handleButtonClick(BuildContext context) {
  
  }

 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonationDetailsPage(
              doneDonationsId: donation.doneDonationsId,
              personName: donation.personName,
              doneDonationsName: donation.doneDonationsName,
              startDate: donation.startDate,
              endDate: donation.endDate,
              targetAmount: donation.targetAmount,
              onGenerateReport: onGenerateReport,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: const Color.fromARGB(255, 236, 233, 233),
        margin: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'رقم التبرع المنتهي: ${donation.doneDonationsId}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                  color: Color.fromARGB(255, 2, 2, 88),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'اسم الشخص: ${donation.personName}',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'ElMessiri',
                  color: Color.fromARGB(255, 2, 2, 88),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'اسم التبرع المنتهي: ${donation.doneDonationsName}',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'ElMessiri',
                  color: Color.fromARGB(255, 2, 2, 88),
                ),
              ),
              const SizedBox(height: 8),
              if (donation.showReportButton)
                ElevatedButton(
                  onPressed: () {
                    _handleButtonClick(context);
                  },
                  child: const Text(
                    'تم انشاء التقرير',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 2, 88),
                    padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
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






// class DonationList extends StatefulWidget {
//   final String status;

//   DonationList({required this.status});

//   @override
//   _DonationListState createState() => _DonationListState();
// }

// class _DonationListState extends State<DonationList> {
//   late Future<List<dynamic>> _futureDonations;
//   List<DonationWithDocuments> _donations = []; // Store the donations

//   @override
//   void initState() {
//     super.initState();
//     _futureDonations = _fetchDonations();
//   }

//   static const String _baseUrl = 'http://192.168.1.140:3000/user';

//   Future<List<dynamic>> fetchDonationsWithDocuments() async {
//     final response = await http.get(Uri.parse('$_baseUrl/donations-with-documents'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load donations');
//     }
//   }

//   Future<List<dynamic>> _fetchDonations() async {
//     if (widget.status == 'pending') {
//       final response = await http.get(Uri.parse('$_baseUrl/donations-with-documents'));

//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body);
//         List<DonationWithDocuments> donations = data.map((json) => DonationWithDocuments.fromJson(json)).toList();
//         setState(() {
//           _donations = donations; // Update the donations state
//         });
//         return donations;
//       } else {
//         throw Exception('فشل تحميل التبرعات');
//       }
//     } else {
//       final response = await http.get(Uri.parse('$_baseUrl/donations'));

//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body)['donations'];
//         return data.map((json) => Donation.fromJson(json)).toList().where((donation) {
//           if (widget.status == 'not_checked') {
//             return true;
//           }
//           return false;
//         }).toList();
//       } else {
//         throw Exception('فشل تحميل التبرعات');
//       }
//     }
//   }

//   void _showReportButton(int id) {
//     setState(() {
//       for (var donation in _donations) {
//         if (donation.doneDonationsId == id) {
//           donation.showReportButton = true;
//         }
//       }
//     });
//   }

//   void _removeDonation(int id) {
//     setState(() {
//       _donations.removeWhere((donation) => donation.doneDonationsId == id);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<dynamic>>(
//       future: _futureDonations,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               'خطأ: ${snapshot.error}',
//               style: const TextStyle(
//                 fontFamily: 'ElMessiri',
//                 color: Color.fromARGB(255, 2, 2, 88),
//               ),
//             ),
//           );
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(
//             child: Text(
//               'لم يتم العثور على تبرعات',
//               style: TextStyle(
//                 fontFamily: 'ElMessiri',
//                 color: Color.fromARGB(255, 2, 2, 88),
//               ),
//             ),
//           );
//         } else {
//           return ListView(
//             children: snapshot.data!.map((donation) {
//               if (widget.status == 'pending') {
//                 return DonationWithDocumentsCard(
//                   donation: donation as DonationWithDocuments,
//                   onGenerateReport: () => _showReportButton(donation.doneDonationsId), // Pass the callback
//                   onRemoveDonation: () => _removeDonation(donation.doneDonationsId), // Pass the remove callback
//                 );
//               } else {
//                 return DonationCard(donation: donation as Donation, showButton: widget.status == 'not_checked');
//               }
//             }).toList(),
//           );
//         }
//       },
//     );
//   }
// }































// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_application_athar_project/admin_pages/reporting_and_analytics_page.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         fontFamily: 'ElMessiri',
//         primarySwatch: Colors.blue,
//       ),
//       home: page2(),
//     );
//   }
// }

// class page2 extends StatefulWidget {
//   const page2({Key? key}) : super(key: key);

//   @override
//   page2State createState() => page2State();
// }

// class page2State extends State<page2> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: const Color.fromARGB(248, 255, 255, 255),
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(248, 255, 255, 255),
//           title: const Text(
//             'التبرعات',
//             style: TextStyle(
//               fontFamily: 'ElMessiri',
//               color: Color.fromARGB(255, 2, 2, 88),
//             ),
//           ),
//           bottom: TabBar(
//             controller: _tabController,
//             labelStyle: const TextStyle(
//               fontFamily: 'ElMessiri',
//               color: Color.fromARGB(255, 2, 2, 88),
//             ),
//             unselectedLabelStyle: const TextStyle(
//               fontFamily: 'ElMessiri',
//               color: Color.fromARGB(255, 2, 2, 88),
//             ),
//             tabs: const [
//               Tab(text: 'لم يتم التحقق'),
//               Tab(text: 'معلق'),
//               Tab(text: 'منتهي'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           controller: _tabController,
//           children: [
//             DonationList(status: 'not_checked'),
//             DonationList(status: 'pending'),
//             DonationList(status: 'finished'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Donation {
//   final int donationId;
//   final String donationName;

//   Donation({required this.donationId, required this.donationName});

//   factory Donation.fromJson(Map<String, dynamic> json) {
//     return Donation(
//       donationId: json['donation_id'],
//       donationName: json['donation_name'],
//     );
//   }
// }

// class DonationWithDocuments {
//   final int doneDonationsId;
//   final String personName;
//   final String doneDonationsName;
//   final Uint8List documents; // Assuming documents is an image
//   final DateTime startDate; // Change type to DateTime
//   final DateTime endDate; // Change type to DateTime
//   final int targetAmount;

//   DonationWithDocuments({
//     required this.doneDonationsId,
//     required this.personName,
//     required this.doneDonationsName,
//     required this.documents,
//     required this.startDate,
//     required this.endDate,
//     required this.targetAmount,
//   });

//   factory DonationWithDocuments.fromJson(Map<String, dynamic> json) {
//   Uint8List? docBytes;
//   if (json['documents'] != null) {
//     // Handle case where documents might not be a string
//     if (json['documents'] is String) {
//       docBytes = base64Decode(json['documents']);
//     } else {
//       // Handle unexpected type if needed
//       print('Unexpected type for documents: ${json['documents'].runtimeType}');
//     }
//   }

//   return DonationWithDocuments(
//     doneDonationsId: json['done_donations_id'] ?? 0, // Provide default value if necessary
//     personName: json['person_name'] ?? '',
//     doneDonationsName: json['done_donations_name'] ?? '',
//     documents: docBytes ?? Uint8List(0), // Handle null or empty case
//     startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : DateTime.now(),
//     endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : DateTime.now(),
//     targetAmount: json['target_amount'] ?? 0, // Provide default value if necessary
//   );

//   }
// }

// class DonationList extends StatefulWidget {
//   final String status;

//   DonationList({required this.status});

//   @override
//   _DonationListState createState() => _DonationListState();
// }

// class _DonationListState extends State<DonationList> {
//   late Future<List<dynamic>> _futureDonations;

//   @override
//   void initState() {
//     super.initState();
//     _futureDonations = _fetchDonations();
//   }

//   static const String _baseUrl = 'http://192.168.1.140:3000/user';

//   Future<List<dynamic>> fetchDonationsWithDocuments() async {
//     final response = await http.get(Uri.parse('$_baseUrl/donations-with-documents'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load donations');
//     }
//   }

//   Future<List<dynamic>> _fetchDonations() async {
//     if (widget.status == 'pending') {
//       final response = await http.get(Uri.parse('$_baseUrl/donations-with-documents'));

//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => DonationWithDocuments.fromJson(json)).toList();
//       } else {
//         throw Exception('فشل تحميل التبرعات');
//       }
//     } else {
//       final response = await http.get(Uri.parse('$_baseUrl/donations'));

//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body)['donations'];
//         return data.map((json) => Donation.fromJson(json)).toList().where((donation) {
//           if (widget.status == 'not_checked') {
//             return true;
//           }
//           return false;
//         }).toList();
//       } else {
//         throw Exception('فشل تحميل التبرعات');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<dynamic>>(
//       future: _futureDonations,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               'خطأ: ${snapshot.error}',
//               style: const TextStyle(
//                 fontFamily: 'ElMessiri',
//                 color: Color.fromARGB(255, 2, 2, 88),
//               ),
//             ),
//           );
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(
//             child: Text(
//               'لم يتم العثور على تبرعات',
//               style: TextStyle(
//                 fontFamily: 'ElMessiri',
//                 color: Color.fromARGB(255, 2, 2, 88),
//               ),
//             ),
//           );
//         } else {
//           return ListView(
//             children: snapshot.data!.map((donation) {
//               if (widget.status == 'pending') {
//                 return DonationWithDocumentsCard(donation: donation as DonationWithDocuments);
//               } else {
//                 return DonationCard(donation: donation as Donation, showButton: widget.status == 'not_checked');
//               }
//             }).toList(),
//           );
//         }
//       },
//     );
//   }
// }

// class DonationCard extends StatefulWidget {
//   final Donation donation;
//   final bool showButton;

//   DonationCard({required this.donation, required this.showButton});

//   @override
//   _DonationCardState createState() => _DonationCardState();
// }

// class _DonationCardState extends State<DonationCard> {
//   bool buttonClicked = false;

//   void _handleButtonClick() {
//     _showConfirmationDialog();
//   }

//   void _showConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           title: const Text(
//             'تم الانتهاء من عملية التبرع ارجو ارسال وثائق اللازمة عند التوفر',
//             textDirection: TextDirection.rtl,
//             style: TextStyle(
//               fontFamily: 'ElMessiri',
//               fontWeight: FontWeight.bold,
//               color: Color.fromARGB(255, 2, 2, 88),
//             ),
//           ),
//           content: const Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'هل أنت متأكد أنك تريد إرسال هذه الرسالة للمستفيد؟',
//                 textDirection: TextDirection.rtl,
//                 style: TextStyle(
//                   fontFamily: 'ElMessiri',
//                   color: Color.fromARGB(255, 2, 2, 88),
//                 ),
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text(
//                 'إلغاء',
//                 style: TextStyle(
//                   fontFamily: 'ElMessiri',
//                   color: Colors.red,
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text(
//                 'موافق',
//                 style: TextStyle(
//                   fontFamily: 'ElMessiri',
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//               onPressed: () {
//                 // Implement your donation processing logic here
//                 setState(() {
//                   buttonClicked = true;
//                 });
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: const Color.fromARGB(255, 236, 233, 233),
//       margin: const EdgeInsets.all(10.0),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.showButton && !buttonClicked)
//               ElevatedButton(
//                 onPressed: _handleButtonClick,
//                 child: const Text('تم التبرع'),
//               ),
//             const SizedBox(height: 10),
//             Text(
//               'رقم: ${widget.donation.donationId}',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'ElMessiri',
//                 color: Color.fromARGB(255, 2, 2, 88),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               'الحالة: ${widget.donation.donationName}',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontFamily: 'ElMessiri',
//                 color: Color.fromARGB(255, 2, 2, 88),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class DonationWithDocumentsCard extends StatelessWidget {
//   final DonationWithDocuments donation;

//   DonationWithDocumentsCard({required this.donation});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DonationDetailsPage(
//               doneDonationsId: donation.doneDonationsId,
//               personName: donation.personName,
//               doneDonationsName: donation.doneDonationsName,
//               //documents: donation.documents,
//               startDate: donation.startDate,
//               endDate: donation.endDate,
//               targetAmount: donation.targetAmount,
//             ),
//           ),
//         );
//       },
//       child: Card(
//         color: const Color.fromARGB(255, 236, 233, 233),
//         margin: const EdgeInsets.all(10.0),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'رقم التبرع المنتهي: ${donation.doneDonationsId}',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'ElMessiri',
//                   color: Color.fromARGB(255, 2, 2, 88),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 'اسم الشخص: ${donation.personName}',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontFamily: 'ElMessiri',
//                   color: Color.fromARGB(255, 2, 2, 88),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 'اسم التبرع المنتهي: ${donation.doneDonationsName}',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontFamily: 'ElMessiri',
//                   color: Color.fromARGB(255, 2, 2, 88),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




    