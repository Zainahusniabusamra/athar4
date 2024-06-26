import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteEmployeesPage extends StatefulWidget {
  final String title;

  DeleteEmployeesPage({required this.title});

  @override
  _DeleteEmployeesPageState createState() => _DeleteEmployeesPageState();
}

class _DeleteEmployeesPageState extends State<DeleteEmployeesPage> {
  List<String> admins = [];

  @override
  void initState() {
    super.initState();
    fetchAdmins();
  }

  Future<void> fetchAdmins() async {
    try {
      var response = await http.get(
        Uri.parse('http://192.168.1.140:3000/user/admins?title=${widget.title}'),
        //        Uri.parse('http://172.19.245.255:3000/user/admins?title=${widget.title}'),

      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          admins = List<String>.from(data['admins']);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch admins: ${response.reasonPhrase}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch admins: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Employees'),
      ),
      body: ListView.builder(
        itemCount: admins.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                admins[index],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _showConfirmationDialog(context, admins[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String adminName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete admin: $adminName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteAdmin(adminName);
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteAdmin(String adminName) async {
    try {
      var url = Uri.parse('http://192.168.1.140:3000/user/admin/updateRole');
      var response = await http.put(
        url,
        body: {
          'adminName': adminName,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Admin $adminName deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
        // Update UI after successful deletion if needed
        fetchAdmins();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete admin $adminName: ${response.reasonPhrase}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete admin $adminName: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
