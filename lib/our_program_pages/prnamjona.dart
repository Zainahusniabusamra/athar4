// lib/our_program_pages/pramijona.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/our_program_pages/CartPage.dart';
import 'package:flutter_application_athar_project/our_program_pages/GiftPage.dart';
import 'package:flutter_application_athar_project/our_program_pages/bloodDonation.dart';
import 'package:flutter_application_athar_project/our_program_pages/searchPage.dart';
import 'package:flutter_application_athar_project/our_program_pages/periodicDonation.dart';
import 'package:flutter_application_athar_project/our_program_pages/zakat.dart';
import 'package:flutter_application_athar_project/module/pramijona_page_module.dart';

class Pramijona extends StatefulWidget {
  const Pramijona({super.key});

  @override
  State<Pramijona> createState() => _PramijonaState();
}

class _PramijonaState extends State<Pramijona> {
  static List<PramijonaPageModule> mainPramijonaList = [
    PramijonaPageModule("الهدية", Icons.card_giftcard),
    PramijonaPageModule("التبرع الدوري", Icons.repeat),
    PramijonaPageModule("الزكاة", Icons.card_giftcard),
    PramijonaPageModule("التبرع بالدم", Icons.card_giftcard),
  ];

  void navigateToPage(int index) {
    Widget page;
    switch (index) {
      case 0:
        page = GiftPage();
        break;
      case 1:
        page = periodicDonation();
        break;
      case 2:
        page = zakat();
        break;
      case 3:
        page = bloodDonation();
        break;
      default:
        page = Pramijona();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD071E0),
        elevation: 0.0,
        title: const Text(
          'برامجنا',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: const Color(0xFFD071E0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: TextField(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFD071E0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "بحث بأقسام البرامج ...",
                  hintStyle: const TextStyle(color: Colors.white),
                  hintTextDirection: TextDirection.rtl,
                  suffixIcon: const Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: mainPramijonaList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.white,
                    shadowColor: const Color(0xFFD071E0),
                    surfaceTintColor: Colors.white,
                    child: ListTile(
                      title: Text(
                        mainPramijonaList[index].prnamigonaTitle,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color(0xFFD071E0),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                      trailing: Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(1),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3F3F3),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            mainPramijonaList[index].icon,
                            size: 20.0,
                            color: const Color(0xFFD071E0),
                          ),
                          onPressed: () => navigateToPage(index),
                        ),
                      ),
                      onTap: () => navigateToPage(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
