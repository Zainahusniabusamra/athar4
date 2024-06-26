import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DonorProfilePage extends StatefulWidget {
  final String? email;

  DonorProfilePage({required this.email});

  @override
  DonorProfilePageState createState() => DonorProfilePageState();
}

class DonorProfilePageState extends State<DonorProfilePage> {
  Map<String, dynamic>? _userData;
  List<dynamic>? _userHistory;
  int? _selectedYear; // State variable to hold the selected year for filtering
  int? _selectedMonth; // State variable to hold the selected month for filtering
  List<dynamic>? _filteredUserHistory; // State variable to hold filtered donation history

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.140:3000/user/combinedData'), // Replace with your API endpoint
        body: {'email': widget.email!},
      );

      if (response.statusCode == 200) {
        setState(() {
          _userData = json.decode(response.body)['user_history'][0];
          _userHistory = json.decode(response.body)['user_history']; // Update the user history data
          _filteredUserHistory = _userHistory; // Initialize filtered history with all data
        });
      } else {
        throw Exception('فشل في تحميل بيانات المستخدم');
      }
    } catch (e) {
      print('خطأ في جلب بيانات المستخدم: $e');
    }
  }

  void filterByYearAndMonth(int? year, int? month) {
    setState(() {
      _selectedYear = year;
      _selectedMonth = month;
      _filteredUserHistory = _userHistory;

      if (_selectedYear != null && _selectedYear != 0) {
        _filteredUserHistory = _filteredUserHistory!.where((donation) {
          return donation['data_of_donation'].startsWith('$_selectedYear');
        }).toList();
      }

      if (_selectedMonth != null && _selectedMonth != 0) {
        _filteredUserHistory = _filteredUserHistory!.where((donation) {
          return DateTime.parse(donation['data_of_donation']).month == _selectedMonth;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dropdown to select year for filtering
    Widget yearFilterDropdown() {
      List<int> years = _userHistory != null
          ? _userHistory!
              .map((donation) => int.parse(donation['data_of_donation'].split('-')[0]))
              .toSet()
              .toList()
          : [];
      years.sort(); // Sort years in ascending order

      return DropdownButton<int>(
        hint: const Text('اختر السنة' ,  style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 2, 88),
                      ),),
        value: _selectedYear,
        items: [
          const DropdownMenuItem<int>(
            value: 0,
            child: Text('كل السنوات' ,  style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 2, 88),
                      ),),
          ),
          ...years.map((year) {
            return DropdownMenuItem<int>(
              value: year,
              child: Text(year.toString()),
            );
          }).toList(),
        ],
        onChanged: (int? year) {
          filterByYearAndMonth(year, _selectedMonth);
        },
      );
    }

    // Dropdown to select month for filtering
    Widget monthFilterDropdown() {
      List<int> months = List.generate(12, (index) => index + 1);

      return DropdownButton<int>(
        hint: const Text('اختر الشهر' ,  style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 2, 88),
                      ),),
        value: _selectedMonth,
        items: [
          const DropdownMenuItem<int>(
            value: 0,
            child: Text('كل الشهور' ,  style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 2, 88),
                      ),),
          ),
          ...months.map((month) {
            return DropdownMenuItem<int>(
              value: month,
              child: Text(month.toString()),
            );
          }).toList(),
        ],
        onChanged: (int? month) {
          filterByYearAndMonth(_selectedYear, month);
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'ملف المتبرع',
          style: TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromARGB(255, 2, 2, 88),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/imgs/2.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/imgs/2.jpeg'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _userData != null ? _userData!['userName'] : '',
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'المعلومات الشخصية',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 2, 88),
                      ),
                    ),
                    Card(
                      color: const Color.fromARGB(255, 236, 233, 233),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'البريد الإلكتروني: ${_userData != null ? _userData!['user_email'] : ''}',
                                style: const TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'الهاتف: ${_userData != null ? _userData!['phone'] : ''}',
                                style: const TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Color.fromARGB(255, 2, 2, 88),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'تاريخ التبرعات',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 2, 88),
                      ),
                    ),
                    yearFilterDropdown(), // Add the year filter dropdown
                    monthFilterDropdown(), // Add the month filter dropdown
                    _filteredUserHistory != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _filteredUserHistory!.length,
                            itemBuilder: (context, index) {
                              var donation = _filteredUserHistory![index];
                              return Card(
                                color: const Color.fromARGB(255, 236, 233, 233),
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: ListTile(
                                    leading: const Icon(Icons.favorite, color: Colors.red),
                                    title: Text(
                                      donation['donation_name'],
                                      style: const TextStyle(
                                        fontFamily: 'ElMessiri',
                                        color: Color.fromARGB(255, 2, 2, 88),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'التاريخ: ${donation['data_of_donation'].split('T')[0]}',
                                          style: const TextStyle(
                                            fontFamily: 'ElMessiri',
                                            color: Color.fromARGB(255, 2, 2, 88),
                                          ),
                                        ),
                                        Text(
                                          'المبلغ: ${donation['amount_of_donation']}',
                                          style: const TextStyle(
                                            fontFamily: 'ElMessiri',
                                            color: Color.fromARGB(255, 2, 2, 88),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const ListTile(
                            title: Text(
                              'لا يوجد تاريخ تبرعات متاح',
                              style: TextStyle(
                                fontFamily: 'ElMessiri',
                                color: Color.fromARGB(255, 2, 2, 88),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    const Text(
                      'معلومات الدفع',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 2, 88),
                      ),
                    ),
                    Card(
                      color: const Color.fromARGB(255, 236, 233, 233),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: ListTile(
                          title: Text(
                            'طريقة الدفع: ${_userData != null ? _userData!['payment_method'] : ''}',
                            style: const TextStyle(
                              fontFamily: 'ElMessiri',
                              color: Color.fromARGB(255, 2, 2, 88),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'الرسائل',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 2, 88),
                      ),
                    ),
                    Card(
                      color: const Color.fromARGB(255, 236, 233, 233),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: const Text(
                          'إرسال رسالة',
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            color: Color.fromARGB(255, 2, 2, 88),
                          ),
                        ),
                        onTap: () {
                          // Handle message sending
                        },
                      ),
                    ),
                  ],
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

// class DonorProfilePage extends StatefulWidget {
//   final String? email;

//   DonorProfilePage({required this.email});

//   @override
//   DonorProfilePageState createState() => DonorProfilePageState();
// }

// class DonorProfilePageState extends State<DonorProfilePage> {
//   Map<String, dynamic>? _userData;
//   List<dynamic>? _userHistory;
//   int? _selectedYear; // State variable to hold the selected year for filtering
//   List<dynamic>? _filteredUserHistory; // State variable to hold filtered donation history

//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }

//   Future<void> fetchUserData() async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.1.140:3000/user/combinedData'), // Replace with your API endpoint
//         body: {'email': widget.email!},
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           _userData = json.decode(response.body)['user_history'][0];
//           _userHistory = json.decode(response.body)['user_history']; // Update the user history data
//           _filteredUserHistory = _userHistory; // Initialize filtered history with all data
//         });
//       } else {
//         throw Exception('فشل في تحميل بيانات المستخدم');
//       }
//     } catch (e) {
//       print('خطأ في جلب بيانات المستخدم: $e');
//     }
//   }

//   void filterByYear(int? year) {
//     setState(() {
//       _selectedYear = year;
//       if (_selectedYear != null && _selectedYear != 0) {
//         _filteredUserHistory = _userHistory!.where((donation) {
//           // Filter donations by year
//           return donation['data_of_donation'].startsWith('$_selectedYear');
//         }).toList();
//       } else {
//         _filteredUserHistory = _userHistory; // Reset to show all if no year selected
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Dropdown to select year for filtering
//     Widget yearFilterDropdown() {
//       List<int> years = _userHistory != null
//           ? _userHistory!
//               .map((donation) => int.parse(donation['data_of_donation'].split('-')[0]))
//               .toSet()
//               .toList()
//           : [];
//       years.sort(); // Sort years in ascending order

//       return DropdownButton<int>(
//         hint: const Text('اختر السنة' ,  style: TextStyle(
//                         fontFamily: 'ElMessiri',
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 2, 2, 88),
//                       ),),
//         value: _selectedYear,
//         items: [
//           const DropdownMenuItem<int>(
//             value: 0,
//             child: Text('كل السنوات' ,  style: TextStyle(
//                         fontFamily: 'ElMessiri',
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 2, 2, 88),
//                       ),),
//           ),
//           ...years.map((year) {
//             return DropdownMenuItem<int>(
//               value: year,
//               child: Text(year.toString()),
//             );
//           }).toList(),
//         ],
//         onChanged: (int? year) {
//           filterByYear(year);
//         },
//       );
//     }

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(248, 255, 255, 255),
//       appBar: AppBar(
//         title: const Text(
//           'ملف المتبرع',
//           style: TextStyle(
//             fontFamily: 'ElMessiri',
//             color: Color.fromARGB(255, 2, 2, 88),
//           ),
//         ),
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 250,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/imgs/2.jpeg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const CircleAvatar(
//                       radius: 60,
//                       backgroundColor: Colors.white,
//                       backgroundImage: AssetImage('assets/imgs/2.jpeg'),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       _userData != null ? _userData!['userName'] : '',
//                       style: const TextStyle(
//                         fontFamily: 'ElMessiri',
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//                     const Text(
//                       'المعلومات الشخصية',
//                       style: TextStyle(
//                         fontFamily: 'ElMessiri',
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 2, 2, 88),
//                       ),
//                     ),
//                     Card(
//                       color: const Color.fromARGB(255, 236, 233, 233),
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: Column(
//                           children: [
//                             ListTile(
//                               title: Text(
//                                 'البريد الإلكتروني: ${_userData != null ? _userData!['user_email'] : ''}',
//                                 style: const TextStyle(
//                                   fontFamily: 'ElMessiri',
//                                   color: Color.fromARGB(255, 2, 2, 88),
//                                 ),
//                               ),
//                             ),
//                             ListTile(
//                               title: Text(
//                                 'الهاتف: ${_userData != null ? _userData!['phone'] : ''}',
//                                 style: const TextStyle(
//                                   fontFamily: 'ElMessiri',
//                                   color: Color.fromARGB(255, 2, 2, 88),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'تاريخ التبرعات',
//                       style: TextStyle(
//                         fontFamily: 'ElMessiri',
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 2, 2, 88),
//                       ),
//                     ),
//                     yearFilterDropdown(), // Add the year filter dropdown
//                     _filteredUserHistory != null
//                         ? ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: _filteredUserHistory!.length,
//                             itemBuilder: (context, index) {
//                               var donation = _filteredUserHistory![index];
//                               return Card(
//                                 color: const Color.fromARGB(255, 236, 233, 233),
//                                 margin: const EdgeInsets.symmetric(vertical: 10),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(15),
//                                   child: ListTile(
//                                     leading: const Icon(Icons.favorite, color: Colors.red),
//                                     title: Text(
//                                       donation['donation_name'],
//                                       style: const TextStyle(
//                                         fontFamily: 'ElMessiri',
//                                         color: Color.fromARGB(255, 2, 2, 88),
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     subtitle: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'التاريخ: ${donation['data_of_donation'].split('T')[0]}',
//                                           style: const TextStyle(
//                                             fontFamily: 'ElMessiri',
//                                             color: Color.fromARGB(255, 2, 2, 88),
//                                           ),
//                                         ),
//                                         Text(
//                                           'المبلغ: ${donation['amount_of_donation']}',
//                                           style: const TextStyle(
//                                             fontFamily: 'ElMessiri',
//                                             color: Color.fromARGB(255, 2, 2, 88),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           )
//                         : const ListTile(
//                             title: Text(
//                               'لا يوجد تاريخ تبرعات متاح',
//                               style: TextStyle(
//                                 fontFamily: 'ElMessiri',
//                                 color: Color.fromARGB(255, 2, 2, 88),
//                               ),
//                             ),
//                           ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'معلومات الدفع',
//                       style: TextStyle(
//                         fontFamily: 'ElMessiri',
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 2, 2, 88),
//                       ),
//                     ),
//                     Card(
//                       color: const Color.fromARGB(255, 236, 233, 233),
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: ListTile(
//                           title: Text(
//                             'طريقة الدفع: ${_userData != null ? _userData!['payment_method'] : ''}',
//                             style: const TextStyle(
//                               fontFamily: 'ElMessiri',
//                               color: Color.fromARGB(255, 2, 2, 88),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'الرسائل',
//                       style: TextStyle(
//                         fontFamily: 'ElMessiri',
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 2, 2, 88),
//                       ),
//                     ),
//                     Card(
//                       color: const Color.fromARGB(255, 236, 233, 233),
//                       margin: EdgeInsets.symmetric(vertical: 10),
//                       child: ListTile(
//                         title: const Text(
//                           'إرسال رسالة',
//                           style: TextStyle(
//                             fontFamily: 'ElMessiri',
//                             color: Color.fromARGB(255, 2, 2, 88),
//                           ),
//                         ),
//                         onTap: () {
//                           // Handle message sending
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



