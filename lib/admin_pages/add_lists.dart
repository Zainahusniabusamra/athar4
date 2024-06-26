
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddLists extends StatefulWidget {
  final Map<int, bool>? selectedProjects;
  const AddLists({required this.selectedProjects, Key? key}) : super(key: key);

  @override
  AddListsState createState() => AddListsState();
}

class AddListsState extends State<AddLists> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController tableController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? _selectedCategory; // sub or main
  String? _selectedMainCategory; // which main

  List<String> mainCategories = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.1.140:3000/user/getData'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        mainCategories = data.map((item) => item['category_table_name'].toString()).toList();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:const Text('خطأ', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
          content:const Text('فشل في جلب البيانات من الخادم', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:const Text('موافق', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _moveSelectedProjects() async {
    if (widget.selectedProjects == null || widget.selectedProjects!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا توجد مشاريع محددة', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)))),
      );
      return;
    }

    final String url = 'http://192.168.1.140:3000/user/moveSelectedProjects';

    try {
      final jsonCompatibleMap = widget.selectedProjects!.map((key, value) => MapEntry(key.toString(), value));
      final String tableName = tableController.text;

      final Map<String, dynamic> requestBody = {
        'selectedProjects': jsonCompatibleMap,
        'tableName': tableName,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('تم نقل المشاريع بنجاح', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)))),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في نقل المشاريع: ${response.body}', style:const TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)))),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في نقل المشاريع: $e', style:const TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)))),
      );
    }
  }

  Future<void> createTable() async {
    final String url = 'http://192.168.1.140:3000/user/create_table';

    String tableName = tableController.text;
    String desOfTheTable = descriptionController.text;

    Map<String, String> requestBody = {
      'table_name': tableName,
      'table_description': desOfTheTable,
      'selected_category': _selectedCategory ?? '',
      'main_category': _selectedMainCategory ?? '',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
        const  SnackBar(content: Text('تم إنشاء الجدول بنجاح', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)))),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في إنشاء الجدول: ${response.body}', style:const TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)))),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في إنشاء الجدول: $error', style:const TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)))),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:const Text('إضافة قائمة', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: tableController,
                  decoration:const InputDecoration(
                    labelText: 'أدخل اسم الجدول',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'يرجى إدخال اسم الجدول';
                    }
                    return null;
                  },
                  style:const TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  decoration:const InputDecoration(
                    labelText: 'أدخل وصفا قصيرا',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'يرجى إدخال وصف قصير';
                    }
                    return null;
                  },
                  style:const TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                ),
               const SizedBox(height: 20),
                Row(
                  children: [
                   const Text('اختر نوع الفئة: ', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
                   const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      items: <String>[
                        'الفئة الرئيسية',
                        'الفئة الفرعية',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style:const TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                if (_selectedCategory == 'الفئة الفرعية') ...[
                 const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedMainCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMainCategory = newValue;
                      });
                    },
                    items: mainCategories.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style:const TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
                      );
                    }).toList(),
                    decoration:const InputDecoration(
                      labelText: 'اختر الفئة الرئيسية',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى اختيار الفئة الرئيسية';
                      }
                      return null;
                    },
                    style:const TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                  ),
                ],
               const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      createTable();
                    }
                  },
                   child: Text('إنشاء القائمة',
                    style: TextStyle(fontFamily: 'ElMessiri' , 
                    color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 2, 2, 88),
                  ),
                ),
               const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _moveSelectedProjects,
                  child: Text('نقل المشاريع المحددة', style: TextStyle(fontFamily: 'ElMessiri' , color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color.fromARGB(255, 2, 2, 88),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
