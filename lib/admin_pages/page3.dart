// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_application_athar_project/admin_pages/add_lists.dart';

// class Page3 extends StatefulWidget {
//   const Page3({Key? key}) : super(key: key);

//   @override
//   _Page3State createState() => _Page3State();
// }

// class _Page3State extends State<Page3> {
//   List<dynamic> _projects = [];
//   Map<int, bool> _selectedProjects = {};
//   late ScrollController _scrollController;
//   int _selectedCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _fetchGeneralProjects();
//   }

//   Future<void> _fetchGeneralProjects() async {
//     final response = await http.post(
//       Uri.parse('http://192.168.1.140:3000/user/fetchGeneralProjects'),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         _projects = json.decode(response.body);
//         // Initialize the selection map
//         _projects.forEach((project) {
//           _selectedProjects[project['id']] = false;
//         });
//       });
//     } else {
//       throw Exception('فشل في تحميل المشاريع');
//     }
//   }

//   Widget _buildProjectCard(dynamic project) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: ListTile(
//         leading: Checkbox(
//           value: _selectedProjects[project['id']],
//           onChanged: (bool? value) {
//             setState(() {
//               _selectedProjects[project['id']] = value!;
//               if (value == true) {
//                 _selectedCount++;
//               } else {
//                 _selectedCount--;
//               }
//             });
//           },
//         ),
//         title: Text(project['description']),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl, // Set text direction to RTL
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('المشاريع العامة'),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: _projects.isEmpty
//                   ? Center(child: CircularProgressIndicator())
//                   : Scrollbar(
//                       controller: _scrollController,
//                       thumbVisibility: true,
//                       thickness: 8.0,
//                       radius: Radius.circular(4.0),
//                       child: ListView.builder(
//                         controller: _scrollController,
//                         itemCount: _projects.length,
//                         itemBuilder: (context, index) {
//                           return _buildProjectCard(_projects[index]);
//                         },
//                       ),
//                     ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('المختار: $_selectedCount'),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => AddLists(selectedProjects:_selectedProjects)),
//                       );
//                     },
//                     child: Text('أضف إلى الفئة'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_athar_project/admin_pages/add_lists.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  List<dynamic> _projects = [];
  Map<int, bool> _selectedProjects = {};
  late ScrollController _scrollController;
  int _selectedCount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fetchGeneralProjects();
  }

  Future<void> _fetchGeneralProjects() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.140:3000/user/fetchGeneralProjects'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _projects = json.decode(response.body);
        // Initialize the selection map
        _projects.forEach((project) {
          _selectedProjects[project['id']] = false;
        });
      });
    } else {
      throw Exception('فشل في تحميل المشاريع');
    }
  }

  Widget _buildProjectCard(dynamic project) {
    return Card(
      color: const Color.fromARGB(255, 236, 233, 233),
      margin:const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Checkbox(
          value: _selectedProjects[project['id']],
          onChanged: (bool? value) {
            setState(() {
              _selectedProjects[project['id']] = value!;
              if (value == true) {
                _selectedCount++;
              } else {
                _selectedCount--;
              }
            });
          },
        ),
        title: Text(
          project['description'],
          style:const TextStyle(
            fontFamily: 'ElMessiri',
            color: Color.fromARGB(255, 2, 2, 88),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
         backgroundColor:const Color.fromARGB(248, 255, 255, 255),
        appBar: AppBar(
          backgroundColor:const Color.fromARGB(248, 255, 255, 255),
          title:const Text(
            'المشاريع العامة',
            style: TextStyle(
              fontFamily: 'ElMessiri',
              color: Color.fromARGB(255, 2, 2, 88),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: _projects.isEmpty
                  ?const Center(child: CircularProgressIndicator())
                  : Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      thickness: 8.0,
                      radius:const Radius.circular(4.0),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _projects.length,
                        itemBuilder: (context, index) {
                          return _buildProjectCard(_projects[index]);
                        },
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المختار: $_selectedCount',
                    style:const TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Color.fromARGB(255, 2, 2, 88),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddLists(selectedProjects: _selectedProjects),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 2, 2, 88),
                    ),
                    child:const Text(
                      'أضف إلى الفئة',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ElMessiri',
                      ),
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
}
