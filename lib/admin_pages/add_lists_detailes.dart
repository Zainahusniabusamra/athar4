




import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; 
import 'package:flutter/material.dart';

class ImageUploadPage extends StatefulWidget {
  final Map<String, dynamic> request;

  ImageUploadPage({required this.request});

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController donationTargetController = TextEditingController();
  final TextEditingController currentDonationController = TextEditingController();
  final TextEditingController remainingAmountController = TextEditingController();
  final TextEditingController numOfDonationsController = TextEditingController();

  bool isMainCategorySelected = true;
  String? _selectedMainCategory;
  String? _selectedSubCategory;
  String? selectedCategory;
  List<String> _mainCategories = [];
  List<String> _subCategories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();

    if (widget.request.isNotEmpty) {
      nameController.text = widget.request['documentName'] ?? '';
      descriptionController.text = widget.request['description'] ?? '';
      donationTargetController.text = (widget.request['targetAmount'] ?? 0).toString();
    }
  }

  Future<void> _fetchCategories() async {
    List<dynamic> mainCategoriesData = await getColumnData();
    List<dynamic> subCategoriesData = await getColumnData2();

    setState(() {
      _mainCategories = mainCategoriesData.cast<String>();
      _subCategories = subCategoriesData.cast<String>();
    });
  }

  Future<List<dynamic>> getColumnData() async {
    final String url = 'http://192.168.1.140:3000/user/getColumnData';
    // final String url = 'http://172.19.245.255:3000/user/getColumnData';

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
        return List<String>.from(columnData);
      } else {
        print('فشل في تحميل البيانات: ${response.reasonPhrase}');
        return [];
      }
    } catch (error) {
      print('خطأ في جلب البيانات: $error');
      return [];
    }
  }

  Future<List<dynamic>> getColumnData2() async {
    final String url = 'http://192.168.1.140:3000/user/getColumnData';
    // final String url = 'http://172.19.245.255:3000/user/getColumnData';

    final Map<String, String> queryParams = {
      'columnName': 'sub_categories_name',
      'tableName': 'sub_categories'
    };

    final uri = Uri.parse(url).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final columnData = decodedData['columnData'];
        return List<String>.from(columnData);
      } else {
        print('فشل في تحميل البيانات: ${response.reasonPhrase}');
        return [];
      }
    } catch (error) {
      print('خطأ في جلب البيانات: $error');
      return [];
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    donationTargetController.dispose();
    currentDonationController.dispose();
    remainingAmountController.dispose();
    numOfDonationsController.dispose();
    super.dispose();
  }

  Future<void> uploadImage(File imageFile, String tableName) async {
    var uri = Uri.parse('http://192.168.1.140:3000/user/upload');
    // var uri = Uri.parse('http://172.19.245.255:3000/user/upload');

    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    request.fields['table_name'] = tableName;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('تم رفع الصورة بنجاح');
      } else {
        print('فشل في رفع الصورة');
      }
    } catch (e) {
      print('خطأ في رفع الصورة: $e');
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('لم يتم اختيار صورة.');
      }
    });
  }

  Future<void> sendDataToServer() async {
    final url = 'http://192.168.1.140:3000/user';
    // final url = 'http://172.19.245.255:3000/user';

    selectedCategory = isMainCategorySelected ? _selectedMainCategory ?? '' : _selectedSubCategory ?? '';

    Map<String, dynamic> data = {
      'table_name': selectedCategory,
      'name_controller': nameController.text,
      'assetPath_controller': _image != null ? _image!.path : '',
      'description_controller': descriptionController.text,
      'donation_target_controller': donationTargetController.text,
      'current_donation_controller': '0',
      'remaining_amount_controller': donationTargetController.text,
      'num_of_donations_controller': '0',
      'beneficiary_id': widget.request['beneficiary_id'],
    };

    try {
      final response = await http.post(
        Uri.parse('$url/insertion'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('تم إدخال البيانات بنجاح');
      } else {
        print('فشل في إدخال البيانات. رمز الحالة: ${response.statusCode}');
      }
    } catch (error) {
      print('خطأ في إرسال البيانات إلى الخادم: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('رفع الصورة', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _image == null
                    ? Text('لم يتم اختيار صورة.', style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)))
                    : Image.file(
                        _image!,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _getImage,
                  child: Text('اختر صورة', style: TextStyle(fontFamily: 'ElMessiri' ,  color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 2, 2, 88),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'أدخل اسم الحالة',
                    labelText: 'اسم الحالة',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال اسم الحالة';
                    }
                    return null;
                  },
                  style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'أدخل الوصف',
                    labelText: 'الوصف',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال الوصف';
                    }
                    return null;
                  },
                  style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: donationTargetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'أدخل هدف التبرع',
                    labelText: 'هدف التبرع',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال هدف التبرع';
                    }
                    return null;
                  },
                  style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'اختر نوع الفئة',
                      style: TextStyle(fontSize: 16.0, fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                    ),
                    Switch(
                      value: isMainCategorySelected,
                      onChanged: (value) {
                        setState(() {
                          isMainCategorySelected = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 25.0),
                isMainCategorySelected
                    ? DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'الفئة الرئيسية',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                        ),
                        value: _selectedMainCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedMainCategory = newValue!;
                          });
                        },
                        items: _mainCategories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category, style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
                          );
                        }).toList(),
                        style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                      )
                    : DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'الفئة الفرعية',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                        ),
                        value: _selectedSubCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSubCategory = newValue!;
                          });
                        },
                        items: _subCategories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category, style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88))),
                          );
                        }).toList(),
                        style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 2, 2, 88)),
                      ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendDataToServer();
                      uploadImage(
                        _image!,
                        isMainCategorySelected ? _selectedMainCategory ?? '' : _selectedSubCategory ?? '',
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('إضافة إلى الفئة', style: TextStyle(fontFamily: 'ElMessiri' ,  color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 2, 2, 88),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
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

