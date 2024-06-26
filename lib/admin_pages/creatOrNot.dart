import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_athar_project/admin_pages/add_lists_detailes.dart';
import 'dart:convert';
import 'package:flutter_application_athar_project/admin_pages/add_lists.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  Future<void> searchTable(String tableName) async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.140:3000/user/searchTable?name=$tableName'));
     // final response = await http.get(Uri.parse('http://172.19.245.255:3000/user/searchTable?name=$tableName'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final exists = jsonData['exists'];

        if (exists) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ImageUploadPage(tableName: tableName)),
          // );
        } else {
          // If table does not exist, show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Table does not exist.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter table name',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Perform search operation based on the entered table name
                String tableName = _searchController.text;
                // Perform search operation
                searchTable(tableName);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Add Case Details'),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                    //AddLists().addListsModal(context);
//  Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AddLists()),
//             );
              },
              child: Text(
                'Create a New List?',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


