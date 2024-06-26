
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pdf_viewer_widget.dart';
import 'page2.dart';

class DonationList extends StatefulWidget {
  final String status;

  DonationList({required this.status});

  @override
  _DonationListState createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  late Future<List<dynamic>> _futureDonations;
  List<DonationWithDocuments> _donations = [];
  Map<String, String> _donationNames = {};

  @override
  void initState() {
    super.initState();
    if (widget.status == 'finished') {
      _futureDonations = _fetchPDFs();
    } else {
      _futureDonations = _fetchDonations();
    }
  }

  static const String _baseUrl = 'http://192.168.1.140:3000/user';

  Future<List<dynamic>> _fetchDonations() async {
    if (widget.status == 'pending') {
      final response = await http.get(Uri.parse('$_baseUrl/donations-with-documents'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<DonationWithDocuments> donations = data.map((json) => DonationWithDocuments.fromJson(json)).toList();
        setState(() {
          _donations = donations;
        });
        return donations;
      } else {
        throw Exception('فشل تحميل التبرعات');
      }
    } else {
      final response = await http.get(Uri.parse('$_baseUrl/donations'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['donations'];
        return data.map((json) => Donation.fromJson(json)).toList().where((donation) {
          if (widget.status == 'not_checked') {
            return true;
          }
          return false;
        }).toList();
      } else {
        throw Exception('فشل تحميل التبرعات');
      }
    }
  }

  Future<List<String>> _fetchPDFs() async {
    final pdfDir = 'assets/pdfs/';
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final pdfPaths = manifestMap.keys
        .where((String key) => key.startsWith(pdfDir) && key.endsWith('.pdf'))
        .toList();

    for (var pdfPath in pdfPaths) {
      final pdfName = path.basename(pdfPath).replaceAll('.pdf', '');
      final donationName = await fetchDonationName(pdfName);
      setState(() {
        _donationNames[pdfName] = donationName;
      });
    }

    return pdfPaths;
  }

  Future<String> fetchDonationName(String doneDonationsId) async {
    final String baseUrl = 'http://192.168.1.140:3000/user/';
    final String endpoint = '/getDonationName';
    final Uri url = Uri.parse('$baseUrl$endpoint?done_donations_id=$doneDonationsId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['done_donations_name'];
    } else if (response.statusCode == 404) {
      throw Exception('Donation not found');
    } else {
      throw Exception('Failed to fetch donation name');
    }
  }

  void _showReportButton(int id) {
    setState(() {
      for (var donation in _donations) {
        if (donation.doneDonationsId == id) {
          donation.showReportButton = true;
        }
      }
    });
  }

  void _removeDonation(int id) {
    setState(() {
      _donations.removeWhere((donation) => donation.doneDonationsId == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _futureDonations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'لم يتم العثور على تبرعات',
              style: TextStyle(
                fontFamily: 'ElMessiri',
                color: Color.fromARGB(255, 2, 2, 88),
              ),
            ),
          );
        } else {
          if (widget.status == 'finished') {



return ListView(
  children: snapshot.data!.map((pdfPath) {
    final pdfName = path.basename(pdfPath).replaceAll('.pdf', '');
    final donationName = _donationNames[pdfName] ?? 'Loading...';

    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        leading: Icon(Icons.picture_as_pdf, color: Colors.red, size: 40.0),
        title: Text(
          'فرص مكتملة',
          style: TextStyle(
            fontFamily: 'ElMessiri',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 2, 2, 88),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              donationName,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              pdfName,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFViewerWidget(pdfPath: pdfPath),
            ),
          );
        },
      ),
    );
  }).toList(),
);

            // return ListView(
            //   children: snapshot.data!.map((pdfPath) {
            //     final pdfName = path.basename(pdfPath).replaceAll('.pdf', '');
            //     final donationName = _donationNames[pdfName] ?? 'Loading...';

            //     return Card(
            //       margin: EdgeInsets.all(10.0),
            //       child: ListTile(
            //         leading: Icon(Icons.picture_as_pdf, color: Colors.red, size: 40.0),
            //         title: Text(
            //           donationName,
            //           style: TextStyle(
            //             fontFamily: 'ElMessiri',
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.black87,
            //           ),
            //         ),
            //         subtitle: Text(
            //           pdfName,
            //           style: TextStyle(
            //             fontFamily: 'ElMessiri',
            //             fontSize: 14,
            //             color: Colors.black54,
            //           ),
            //         ),
            //         trailing: Icon(Icons.arrow_forward_ios),
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => PDFViewerWidget(pdfPath: pdfPath),
            //             ),
            //           );
            //         },
            //       ),
            //     );
            //   }).toList(),
            // );
          
          
          
          
          } else {
            return ListView(
              children: snapshot.data!.map((donation) {
                if (widget.status == 'pending') {
                  return DonationWithDocumentsCard(
                    donation: donation as DonationWithDocuments,
                    onGenerateReport: () => _showReportButton(donation.doneDonationsId),
                    onRemoveDonation: () => _removeDonation(donation.doneDonationsId),
                  );
                } else {
                  return DonationCard(donation: donation as Donation, showButton: widget.status == 'not_checked');
                }
              }).toList(),
            );
          }
        }
      },
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path/path.dart' as path;
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'pdf_viewer_widget.dart';
// import 'page2.dart';


// class DonationList extends StatefulWidget {
//   final String status;

//   DonationList({required this.status});

//   @override
//   _DonationListState createState() => _DonationListState();
// }

// class _DonationListState extends State<DonationList> {
//   late Future<List<dynamic>> _futureDonations;
//   List<DonationWithDocuments> _donations = [];

//   @override
//   void initState() {
//     super.initState();
//     if (widget.status == 'finished') {
//       _futureDonations = _fetchPDFs();
//     } else {
//       _futureDonations = _fetchDonations();
//     }
//   }

//   static const String _baseUrl = 'http://192.168.1.140:3000/user';

//   Future<List<dynamic>> _fetchDonations() async {
//     if (widget.status == 'pending') {
//       final response = await http.get(Uri.parse('$_baseUrl/donations-with-documents'));

//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body);
//         List<DonationWithDocuments> donations = data.map((json) => DonationWithDocuments.fromJson(json)).toList();
//         setState(() {
//           _donations = donations;
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

//   Future<List<String>> _fetchPDFs() async {
//     final pdfDir = 'assets/pdfs/';
//     final manifestContent = await rootBundle.loadString('AssetManifest.json');
//     final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//     final pdfPaths = manifestMap.keys
//         .where((String key) => key.startsWith(pdfDir) && key.endsWith('.pdf'))
//         .toList();
//     return pdfPaths;
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
//           if (widget.status == 'finished') {
//             return ListView(
//               children: snapshot.data!.map((pdfPath) {
//                 final pdfName = path.basename(pdfPath);
//                 return Card(
//                   margin: EdgeInsets.all(10.0),
//                   child: ListTile(
//                     title: Text(pdfName),
//                     trailing: Icon(Icons.picture_as_pdf),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PDFViewerWidget(pdfPath: pdfPath),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }).toList(),
//             );
//           } else {
//             return ListView(
//               children: snapshot.data!.map((donation) {
//                 if (widget.status == 'pending') {
//                   return DonationWithDocumentsCard(
//                     donation: donation as DonationWithDocuments,
//                     onGenerateReport: () => _showReportButton(donation.doneDonationsId),
//                     onRemoveDonation: () => _removeDonation(donation.doneDonationsId),
//                   );
//                 } else {
//                   return DonationCard(donation: donation as Donation, showButton: widget.status == 'not_checked');
//                 }
//               }).toList(),
//             );
//           }
//         }
//       },
//     );
//   }
// }



