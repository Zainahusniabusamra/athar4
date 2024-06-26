import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum JobType {
  DocumentManagement,
  FinancialOversight,
  CommunityEngagement,
  ReportingAndAnalytics,
}

class CreateNewAdminPage extends StatefulWidget {
  @override
  _CreateNewAdminPageState createState() => _CreateNewAdminPageState();
}

class _CreateNewAdminPageState extends State<CreateNewAdminPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  JobType _selectedJob = JobType.DocumentManagement; // Default selection

  Future<void> _createAdmin() async {
    // Retrieve input values
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String phone = _phoneController.text.trim();
    String age = _ageController.text.trim();
    String job = _jobTypeToString(_selectedJob); // Convert enum to string

    // Validate input fields
    if (username.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty || age.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    // Create a map with the data to send to the backend
    var data = {
      'userName': username,
      'email': email,
      'password': password,
      'phone': phone,
      'age': age,
      'status': 'active', // Assuming a default status
      'registeredAt': DateTime.now().toString(), // Current timestamp
      'job': job, // Add selected job
    };

    try {
      // Send a POST request to the backend API
      var response = await http.post(
        Uri.parse('http://192.168.1.140:3000/user/registerAdmin1'),
       //         Uri.parse('http://172.19.245.255:3000/user/registerAdmin1'),

        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Show success message
        _showSnackBar('Admin created successfully');
      } else {
        // Show error message
        _showSnackBar('Failed to create admin: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Show error message
      _showSnackBar('Failed to create admin: $error');
    }

    // Reset text controllers
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _phoneController.clear();
    _ageController.clear();
  }

  String _jobTypeToString(JobType jobType) {
    switch (jobType) {
      case JobType.DocumentManagement:
        return 'Document Management';
      case JobType.FinancialOversight:
        return 'Financial Oversight';
      case JobType.CommunityEngagement:
        return 'Community Engagement';
      case JobType.ReportingAndAnalytics:
        return 'Reporting and Analytics';
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Admin'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Phone',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Age',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter age',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Job Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              DropdownButton<JobType>(
                value: _selectedJob,
                onChanged: (JobType? newValue) {
                  setState(() {
                    _selectedJob = newValue!;
                  });
                },
                items: JobType.values.map((JobType jobType) {
                  return DropdownMenuItem<JobType>(
                    value: jobType,
                    child: Text(_jobTypeToString(jobType)),
                  );
                }).toList(),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _createAdmin();
                },
                child: Text('Create Admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
