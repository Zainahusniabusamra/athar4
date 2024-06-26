















// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_application_athar_project/pages/case_description.dart';
// import 'dart:typed_data';

// class adminPage extends StatefulWidget {
//   const adminPage({Key? key}) : super(key: key);

//   @override
//   State<adminPage> createState() => adminPageState();
// }

// class adminPageState extends State<adminPage> with SingleTickerProviderStateMixin {
//   List<Widget> projectCardsList = [];
//   List<String> buttonNames = [];
//   TabController? _tabController;
//   bool hasSubCategories = false;
//   List<String> subCategories = [];
//   int selectedSubCategoryIndex = -1;
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchMainCategoryData("مشاريع_عامه");
//     getColumnData().then((data) {
//       setState(() {
//         buttonNames = data.map((e) => e.toString()).toList();
//         _tabController = TabController(length: buttonNames.length, vsync: this);
//         _tabController!.addListener(() {
//           if (_tabController!.indexIsChanging) {
//             checkSubCategories(buttonNames[_tabController!.index]);
//           }
//         });
//       });
//     });
//   }

//   Future<void> loadSubCategoryData(String subCategoryName) async {
//     List<dynamic> data = await fetchData(subCategoryName);
//     setState(() {
//       projectCardsList.clear();
//       for (var item in data) {
//         projectCardsList.add(_buildCard(item, subCategoryName, context));
//       }
//       print('Number of cards added: ${projectCardsList.length}');
//     });
//   }

//   Future<dynamic> fetchData(String tableName) async {
//     final url = 'http://192.168.1.140:3000/user/fetchData';
//     final response = await http.post(
//       Uri.parse(url),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'name': tableName,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   Future<void> checkSubCategories(String categoryName) async {
//     final url = 'http://192.168.1.140:3000/user/has_a_sub';
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'name': categoryName}),
//     );

//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       setState(() {
//         hasSubCategories = responseData['hasSubCategories'];
//         if (hasSubCategories) {
//           fetchSubCategories(categoryName);
//         } else {
//           fetchMainCategoryData(categoryName);
//         }
//       });
//     } else {
//       throw Exception('Failed to load sub-categories');
//     }
//   }

//   Future<void> fetchSubCategories(String categoryName) async {
//     final url = 'http://192.168.1.140:3000/user/fetchSubCategories';
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'name': categoryName}),
//     );

//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       setState(() {
//         subCategories = List<String>.from(responseData['subCategories']);
//         selectedSubCategoryIndex = -1;
//       });
//     } else {
//       throw Exception('Failed to load sub-categories');
//     }
//   }

//   Future<void> fetchMainCategoryData(String categoryName) async {
//     List<dynamic> data = await fetchData(categoryName);
//     setState(() {
//       projectCardsList.clear();
//       for (var item in data) {
//         projectCardsList.add(_buildCard(item, categoryName, context));
//       }
//       subCategories.clear();
//       selectedSubCategoryIndex = -1;
//     });
//   }

//   Future<List<dynamic>> getColumnData() async {
//     final String url = 'http://192.168.1.140:3000/user/getColumnData';
//     final Map<String, String> queryParams = {
//       'columnName': 'category_table_name',
//       'tableName': 'donation_categories'
//     };
//     final uri = Uri.parse(url).replace(queryParameters: queryParams);

//     try {
//       final response = await http.get(uri);

//       if (response.statusCode == 200) {
//         final decodedData = json.decode(response.body);
//         final columnData = decodedData['columnData'];
//         return List.from(columnData);
//       } else {
//         print('Failed to load data: ${response.reasonPhrase}');
//         return [];
//       }
//     } catch (error) {
//       print('Error fetching data: $error');
//       return [];
//     }
//   }


//   int _selectedIndex = 0;

//   void _onItemTapped(int index) async {
//     setState(() {
//       _selectedIndex = index;
//     });

//     if (index < subCategories.length) {
//       String categoryOrSubCategory = subCategories[index];
//       if (hasSubCategories) {
//         await loadSubCategoryData(categoryOrSubCategory);
//       } else {
//         await fetchMainCategoryData(categoryOrSubCategory);
//       }
//     }
//   }


//   List<dynamic> donationDetails = [];
//   List<dynamic> searchResults = [];
// bool isSearching = false;
 
//   Future<void> fetchDonationDetails(String id) async {
//     String url = 'http://192.168.1.140:3000/user/donations2';
//     Map<String, String> headers = {"Content-type": "application/json"};
//     String jsonBody = json.encode({"id": id});

//     try {
//       final response = await http.post(Uri.parse(url), headers: headers, body: jsonBody);
      
//       if (response.statusCode == 200) {
//         setState(() {
//           searchResults = json.decode(response.body);
//           isSearching = true;
//         });
//       } else {
//         print('Failed to fetch donation details: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching donation details: $e');
//     }
//   }



// Widget buildCard2(Map<String, dynamic> donation) {
//   int remainingAmount = donation['donation_target'] - donation['current_donation'] ?? 0;
//   List<int>? imageData = donation['assetPath'] != null
//       ? (donation['assetPath']['data'] as List<dynamic>).cast<int>()
//       : null;

//   return GestureDetector(
//     onTap: () {
//       // Handle onTap functionality if needed
//     },
//     child: Card(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       color: const Color.fromARGB(255, 236, 233, 233),
//       child: Stack(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 3,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         donation['donation_name'],
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'ElMessiri',
//                           color: Color.fromARGB(255, 2, 2, 88),
//                         ),
//                         textAlign: TextAlign.right,
//                         textDirection: TextDirection.rtl,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Current Donation: ${donation['current_donation']}',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Color.fromARGB(255, 2, 2, 88),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   height: 200,
//                   decoration: imageData != null
//                       ? BoxDecoration(
//                           image: DecorationImage(
//                             image: MemoryImage(Uint8List.fromList(imageData!)),
//                             fit: BoxFit.cover,
//                           ),
//                         )
//                       : null,
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 8,
//             left: 8,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 206, 195, 192),
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   width: 95,
//                   height: 40,
//                   child: IconButton(
//                     onPressed: () {
//                       // Handle onPressed functionality for the shopping button
//                     },
//                     icon: const Icon(Icons.shopping_cart, color: Color.fromARGB(255, 2, 2, 88)),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle button press
//                   },
//                   child: const Text(
//                     "تبرع الآن",
//                     style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 8,
//             left: 130,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'المبلغ المتبقي:',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontFamily: 'ElMessiri',
//                     color: Color.fromARGB(255, 2, 2, 88),
//                   ),
//                   textAlign: TextAlign.right,
//                   textDirection: TextDirection.rtl,
//                 ),
//                 Text(
//                   '$remainingAmount',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontFamily: 'ElMessiri',
//                     color: Color.fromARGB(255, 2, 2, 88),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'رقم التبرع: ${donation['donation_id']}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontFamily: 'ElMessiri',
//                     color: Color.fromARGB(255, 2, 2, 88),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      backgroundColor:const Color.fromARGB(248, 255, 255, 255),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             color:const  Color.fromARGB(255, 2, 2, 88),
//             height: 128,
//             padding:const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   child: Row(
//                     children: [
//                       Container(
//                         margin:const EdgeInsets.fromLTRB(20, 30, 10, 10),
//                         child: IconButton(
//                           icon: const Icon(
//                             Icons.shopping_basket_rounded,
//                             color: Color.fromARGB(255, 255, 255, 255),
//                           ),
//                           onPressed: () {
//                             // Add onPressed functionality for the second icon button
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: 40,
//                   right: 10,
//                   child: Image.asset(
//                     'assets/imgs/donation.png',
//                     height: 35,
//                     width: 35,
//                   ),
//                 ),
//                 // TabBar setup
//                 buttonNames.isNotEmpty && _tabController != null
//                     ? Column(
//                         children: [
//                           Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Container(
//                               margin:const EdgeInsets.fromLTRB(5, 70, 5, 0),
//                               child: TabBar(
//                                 controller: _tabController,
//                                 isScrollable: true,
//                                 labelColor: Colors.white,
//                                 unselectedLabelColor: Colors.black,
//                                 indicator:const BoxDecoration(
//                                   color: Colors.transparent,
//                                 ),
//                                 tabs: buttonNames.map((buttonName) {
//                                   return Tab(
//                                     child: CustomTab(
//                                       text: buttonName,
//                                       isSelected: _tabController!.index == buttonNames.indexOf(buttonName),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     :const Center(child: CircularProgressIndicator()),
//               ],
//             ),
//           ),
//           // Centered sub-category buttons below TabBar
//           if (hasSubCategories)
//             Center(
//               child: Container(
//                 height: 40, // Adjust height as needed
//                 margin:const EdgeInsets.symmetric(vertical: 3),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: subCategories.asMap().entries.map((entry) {
//                       int index = entry.key;
//                       String subCategory = entry.value;
//                       bool isSelected = index == selectedSubCategoryIndex;
//                       return Container(
//                         margin:const EdgeInsets.symmetric(horizontal: 3),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 1,
//                               blurRadius: 7,
//                               offset:const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             setState(() {
//                               selectedSubCategoryIndex = index;
//                             });
//                             await loadSubCategoryData(subCategory);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: isSelected
//                                 ? const Color.fromARGB(255, 2, 2, 88)
//                                 :const Color.fromARGB(255, 255, 255, 255),
//                             foregroundColor: isSelected
//                                 ? Colors.white
//                                 : const Color.fromARGB(255, 2, 2, 88),
//                             elevation: 0,
//                             padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: Text(
//                             subCategory,
//                             textDirection: TextDirection.rtl,
//                             style:const TextStyle(fontSize: 14,fontFamily: 'ElMessiri'),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//            // Search bar below the sub-category buttons
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//             child: TextField(
//               controller: searchController,
//               textDirection: TextDirection.rtl,
//               decoration: InputDecoration(
//                 hintText: 'بحث',
//                 hintTextDirection: TextDirection.rtl,
//                 prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 2, 2, 88)),
//                 filled: true,
//                 fillColor: const Color.fromARGB(255, 236, 233, 233),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//               ),
//               onChanged: (value) {
//                 if (value.isEmpty) {
//                   setState(() {
//                     isSearching = false;
//                   });
//                 } else {
//                   fetchDonationDetails(value);
//                 }
//               },
//             ),
//           ),
//           Expanded(
//             child: isSearching
//                 ? ListView.builder(
//                     padding: EdgeInsets.only(bottom: 2),
//                     itemCount: searchResults.length,
//                     itemBuilder: (context, index) {
//                       return buildCard2(searchResults[index]);
//                     },
//                   )
//                 : ListView.builder(
//                     padding: EdgeInsets.only(bottom: 2),
//                     itemCount: projectCardsList.length,
//                     itemBuilder: (context, index) {
//                       return projectCardsList[index];
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }




// class CustomTab extends StatelessWidget {
//   final String text;
//   final bool isSelected;

//   CustomTab({required this.text, required this.isSelected});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
//       decoration: BoxDecoration(
//         color:const  Color.fromARGB(255, 2, 2, 88),
//         borderRadius: BorderRadius.circular(50),
//         border: isSelected
//             ? Border.all(
//                 color: Colors.white,
//                 width: 2,
//               )
//             : null,
//         boxShadow: isSelected
//             ? [
//                 BoxShadow(
//                   color: Colors.white.withOpacity(0.5),
//                   spreadRadius: 5,
//                   blurRadius: 10,
//                   offset:const Offset(0, 0),
//                 ),
//               ]
//             : [],
//       ),
//       child: Text(
//         text,
//         textDirection: TextDirection.rtl,
//         style:const TextStyle(
//           fontSize: 16,
//           fontFamily: 'ElMessiri',
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }



// Widget _buildCard(dynamic project, String buttonName, BuildContext context) {
//   String description ;
//   if(buttonName=='مشاريع_عامه'){
//       description = project['name'];
//   }
// else{
//    description = project['description'];

// }
//   int remainingAmount = project['donation_target'] - project['current_donation'] ?? 0;
//   List<int>? imageData = project['assetPath'] != null
//       ? (project['assetPath']['data'] as List<dynamic>).cast<int>()
//       : null;

//   return GestureDetector(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CaseDescription(project: project),
//         ),
//       );
//     },
//     child: Card(
//       margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       color: const Color.fromARGB(255, 236, 233, 233),
//       child: Stack(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 3,
                
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         description,
//                         style:const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'ElMessiri',
//                           color:  Color.fromARGB(255, 2, 2, 88)
//                         ),
//                         textAlign: TextAlign.right,
//                         textDirection: TextDirection.rtl,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   height: 200,
//                   decoration: imageData != null
//                       ? BoxDecoration(
//                           image: DecorationImage(
//                             image: MemoryImage(Uint8List.fromList(imageData!)),
//                             fit: BoxFit.cover,
//                           ),
//                         )
//                       : null,
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 8,
//             left: 8,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 206, 195, 192),
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   width: 95,
//                   height: 40,
//                   child: IconButton(
//                     onPressed: () {
//                       // Handle onPressed functionality for the shopping button
//                     },
//                     icon: Icon(Icons.shopping_cart ,color:  Color.fromARGB(255, 2, 2, 88)),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle button press
//                   },
//                   child:const Text(
//                     "تبرع الآن",
//                     style: TextStyle(fontFamily: 'ElMessiri', color:  Color.fromARGB(255, 2, 2, 88)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 8,
//             left: 130,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                const Text(
//                   'المبلغ المتبقي:',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontFamily: 'ElMessiri',
//                     color:  Color.fromARGB(255, 2, 2, 88)
//                   ),
//                   textAlign: TextAlign.right,
//                   textDirection: TextDirection.rtl,
//                 ),
//                 Text(
//                   '$remainingAmount',
//                   style:const TextStyle(
//                     fontSize: 14,
//                     fontFamily: 'ElMessiri',
//                     color:  Color.fromARGB(255, 2, 2, 88)
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }



















import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_athar_project/pages/case_description.dart';
import 'dart:typed_data';

class adminPage extends StatefulWidget {
  const adminPage({Key? key}) : super(key: key);

  @override
  State<adminPage> createState() => adminPageState();
}

class adminPageState extends State<adminPage> with SingleTickerProviderStateMixin {
  List<Widget> projectCardsList = [];
  List<String> buttonNames = [];
  TabController? _tabController;
  bool hasSubCategories = false;
  List<String> subCategories = [];
  int selectedSubCategoryIndex = -1;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMainCategoryData("مشاريع_عامه");
    getColumnData().then((data) {
      setState(() {
        buttonNames = data.map((e) => e.toString()).toList();
        _tabController = TabController(length: buttonNames.length, vsync: this);
        _tabController!.addListener(() {
          if (_tabController!.indexIsChanging) {
            checkSubCategories(buttonNames[_tabController!.index]);
          }
        });
      });
    });
  }

  Future<void> loadSubCategoryData(String subCategoryName) async {
    List<dynamic> data = await fetchData(subCategoryName);
    setState(() {
      projectCardsList.clear();
      for (var item in data) {
        projectCardsList.add(_buildCard(item, subCategoryName, context));
      }
      print('Number of cards added: ${projectCardsList.length}');
    });
  }

  Future<dynamic> fetchData(String tableName) async {
    final url = 'http://192.168.1.140:3000/user/fetchData';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': tableName,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> checkSubCategories(String categoryName) async {
    final url = 'http://192.168.1.140:3000/user/has_a_sub';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': categoryName}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        hasSubCategories = responseData['hasSubCategories'];
        if (hasSubCategories) {
          fetchSubCategories(categoryName);
        } else {
          fetchMainCategoryData(categoryName);
        }
      });
    } else {
      throw Exception('Failed to load sub-categories');
    }
  }

  Future<void> fetchSubCategories(String categoryName) async {
    final url = 'http://192.168.1.140:3000/user/fetchSubCategories';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': categoryName}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        subCategories = List<String>.from(responseData['subCategories']);
        selectedSubCategoryIndex = -1;
      });
    } else {
      throw Exception('Failed to load sub-categories');
    }
  }

  Future<void> fetchMainCategoryData(String categoryName) async {
    List<dynamic> data = await fetchData(categoryName);
    setState(() {
      projectCardsList.clear();
      for (var item in data) {
        projectCardsList.add(_buildCard(item, categoryName, context));
      }
      subCategories.clear();
      selectedSubCategoryIndex = -1;
    });
  }

  Future<List<dynamic>> getColumnData() async {
    final String url = 'http://192.168.1.140:3000/user/getColumnData';
    final Map<String, String> queryParams = {
      'columnName': 'category_table_name',
      'tableName': 'donation_categories'
    };
    final uri = Uri.parse(url).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final columnData = decodedData['columnData'];
        return List.from(columnData);
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
        return [];
      }
    } catch (error) {
      print('Error fetching data: $error');
      return [];
    }
  }


  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index < subCategories.length) {
      String categoryOrSubCategory = subCategories[index];
      if (hasSubCategories) {
        await loadSubCategoryData(categoryOrSubCategory);
      } else {
        await fetchMainCategoryData(categoryOrSubCategory);
      }
    }
  }


  List<dynamic> donationDetails = [];
  List<dynamic> searchResults = [];
bool isSearching = false;
 
  Future<void> fetchDonationDetails(String id) async {
    String url = 'http://192.168.1.140:3000/user/donations2';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = json.encode({"id": id});

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: jsonBody);
      
      if (response.statusCode == 200) {
        setState(() {
          searchResults = json.decode(response.body);
          isSearching = true;
        });
      } else {
        print('Failed to fetch donation details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching donation details: $e');
    }
  }



Widget buildCard2(Map<String, dynamic> donation) {
  int remainingAmount = donation['donation_target'] - donation['current_donation'] ?? 0;
  List<int>? imageData = donation['assetPath'] != null
      ? (donation['assetPath']['data'] as List<dynamic>).cast<int>()
      : null;

  return GestureDetector(
    onTap: () {
      // Handle onTap functionality if needed
    },
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: const Color.fromARGB(255, 236, 233, 233),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        donation['donation_name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ElMessiri',
                          color: Color.fromARGB(255, 2, 2, 88),
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Current Donation: ${donation['current_donation']}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 2, 2, 88),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 200,
                  decoration: imageData != null
                      ? BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(Uint8List.fromList(imageData!)),
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 206, 195, 192),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: 95,
                  height: 40,
                  child: IconButton(
                    onPressed: () {
                      // Handle onPressed functionality for the shopping button
                    },
                    icon: const Icon(Icons.shopping_cart, color: Color.fromARGB(255, 2, 2, 88)),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: const Text(
                    "تبرع الآن",
                    style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            left: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'المبلغ المتبقي:',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'ElMessiri',
                    color: Color.fromARGB(255, 2, 2, 88),
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  '$remainingAmount',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'ElMessiri',
                    color: Color.fromARGB(255, 2, 2, 88),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'رقم التبرع: ${donation['donation_id']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'ElMessiri',
                    color: Color.fromARGB(255, 2, 2, 88),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:const Color.fromARGB(248, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color:const  Color.fromARGB(255, 2, 2, 88),
            height: 128,
            padding:const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Row(
                    children: [
                      Container(
                        margin:const EdgeInsets.fromLTRB(20, 30, 10, 10),
                        child: IconButton(
                          icon: const Icon(
                            Icons.shopping_basket_rounded,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {
                            // Add onPressed functionality for the second icon button
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: Image.asset(
                    'assets/imgs/athar_dark2.jpg',
                    height: 45,
                    width: 55,
                  ),
                ),
                // TabBar setup
                buttonNames.isNotEmpty && _tabController != null
                    ? Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              margin:const EdgeInsets.fromLTRB(5, 70, 5, 0),
                              child: TabBar(
                                controller: _tabController,
                                isScrollable: true,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                indicator:const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                tabs: buttonNames.map((buttonName) {
                                  return Tab(
                                    child: CustomTab(
                                      text: buttonName,
                                      isSelected: _tabController!.index == buttonNames.indexOf(buttonName),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      )
                    :const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
          // Centered sub-category buttons below TabBar
          if (hasSubCategories)
            Center(
              child: Container(
                height: 40, // Adjust height as needed
                margin:const EdgeInsets.symmetric(vertical: 3),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: subCategories.asMap().entries.map((entry) {
                      int index = entry.key;
                      String subCategory = entry.value;
                      bool isSelected = index == selectedSubCategoryIndex;
                      return Container(
                        margin:const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              selectedSubCategoryIndex = index;
                            });
                            await loadSubCategoryData(subCategory);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected
                                ? const Color.fromARGB(255, 2, 2, 88)
                                :const Color.fromARGB(255, 255, 255, 255),
                            foregroundColor: isSelected
                                ? Colors.white
                                : const Color.fromARGB(255, 2, 2, 88),
                            elevation: 0,
                            padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            subCategory,
                            textDirection: TextDirection.rtl,
                            style:const TextStyle(fontSize: 14,fontFamily: 'ElMessiri'),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
           // Search bar below the sub-category buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: TextField(
              controller: searchController,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'بحث',
                hintTextDirection: TextDirection.rtl,
                prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 2, 2, 88)),
                filled: true,
                fillColor: const Color.fromARGB(255, 236, 233, 233),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    isSearching = false;
                  });
                } else {
                  fetchDonationDetails(value);
                }
              },
            ),
          ),
          Expanded(
            child: isSearching
                ? ListView.builder(
                    padding: EdgeInsets.only(bottom: 2),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return buildCard2(searchResults[index]);
                    },
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: 2),
                    itemCount: projectCardsList.length,
                    itemBuilder: (context, index) {
                      return projectCardsList[index];
                    },
                  ),
          ),
        ],
      ),
    );
  }
}




class CustomTab extends StatelessWidget {
  final String text;
  final bool isSelected;

  CustomTab({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color:const  Color.fromARGB(255, 2, 2, 88),
        borderRadius: BorderRadius.circular(50),
        border: isSelected
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset:const Offset(0, 0),
                ),
              ]
            : [],
      ),
      child: Text(
        text,
        textDirection: TextDirection.rtl,
        style:const TextStyle(
          fontSize: 16,
          fontFamily: 'ElMessiri',
          color: Colors.white,
        ),
      ),
    );
  }
}



Widget _buildCard(dynamic project, String buttonName, BuildContext context) {
  String description ;
  if(buttonName=='مشاريع_عامه'){
      description = project['name'];
  }
else{
   description = project['description'];

}
  int remainingAmount = project['donation_target'] - project['current_donation'] ?? 0;
  List<int>? imageData = project['assetPath'] != null
      ? (project['assetPath']['data'] as List<dynamic>).cast<int>()
      : null;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CaseDescription(project: project),
        ),
      );
    },
    child: Card(
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: const Color.fromARGB(255, 236, 233, 233),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        description,
                        style:const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ElMessiri',
                          color:  Color.fromARGB(255, 2, 2, 88)
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 200,
                  decoration: imageData != null
                      ? BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(Uint8List.fromList(imageData!)),
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 206, 195, 192),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: 95,
                  height: 40,
                  child: IconButton(
                    onPressed: () {
                      // Handle onPressed functionality for the shopping button
                    },
                    icon: Icon(Icons.shopping_cart ,color:  Color.fromARGB(255, 2, 2, 88)),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child:const Text(
                    "تبرع الآن",
                    style: TextStyle(fontFamily: 'ElMessiri', color:  Color.fromARGB(255, 2, 2, 88)),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            left: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const Text(
                  'المبلغ المتبقي:',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'ElMessiri',
                    color:  Color.fromARGB(255, 2, 2, 88)
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  '$remainingAmount',
                  style:const TextStyle(
                    fontSize: 14,
                    fontFamily: 'ElMessiri',
                    color:  Color.fromARGB(255, 2, 2, 88)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}



