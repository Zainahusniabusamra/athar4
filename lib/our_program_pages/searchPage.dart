import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_athar_project/our_program_pages/CartPage.dart';
import 'package:flutter_application_athar_project/our_program_pages/GiftPage.dart';
import 'package:flutter_application_athar_project/our_program_pages/bloodDonation.dart';
import 'package:flutter_application_athar_project/module/Pramjona_module.dart';
import 'package:flutter_application_athar_project/our_program_pages/periodicDonation.dart';
import 'package:flutter_application_athar_project/our_program_pages/zakat.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _searchPageState();
}

class _searchPageState extends State<SearchPage> {
  static List<pramijonaModule> main_pramijona_list = [
    pramijonaModule(
      "الهدية",
      "تبرع لمن تحب في مختلف المناسبات الاجتماعية،وأرسل بطاقة الهدية عبر الرسائل النصية.",
      Icons.card_giftcard,
    ),
    pramijonaModule(
      "التبرع الدوري",
      "تتيح لك هده الخدمة الفرصة للمساهمة مع منصة أثر في جمع التبرعات للمجالات الخيرية المختلفة لديها. خدمة تتيح لك امكانية خصم مبلغ من بطاقتك البنكية للتبرع بشكل دوري، يصل تلقائيا اِلى الفرص الأشد استحقاقاً.",
      Icons.repeat,
    ),
    pramijonaModule(
      "الزكاة",
      "حساب الزكاة بمختلف أنواعها، ودفعها عبر المنصة، ثم صرفها لمستحقيها.",
      Icons.card_giftcard,
    ),
    pramijonaModule(
      "التبرع بالدم",
      " فرص للتبرع بالدم لاعانة المرضىالمحتاجين وتغطية احتياج بنوك الدم",
      Icons.card_giftcard,
    ),
  ];

  // creating the list that we're going to display and filter
  List<pramijonaModule> display_list = List.from(main_pramijona_list);

  void updateList(String value) {
    // function to filter our list
    setState(() {
      display_list = main_pramijona_list
          .where((element) => element.prnamigonaTitle!.contains(value))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 113, 224),
        elevation: 0.0,
        title: Text('البحث'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: const Color.fromARGB(255, 208, 113, 224),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => updateList(value),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 208, 113, 224),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "بحث بأقسام البرامج ...",
                      hintStyle: TextStyle(color: Colors.white),
                      hintTextDirection: TextDirection.rtl,
                      suffixIcon: Icon(Icons.search),
                      suffixIconColor: Colors.white,
                    ),
                  ),
                ),
                //SizedBox(width: 16),
                
              ],
            ),
            SizedBox(height: 16), // Add some space between search box and list
            Expanded(
              child: display_list.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 50,
                            color: const Color.fromARGB(255, 208, 113, 224),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "لا يوجد برامج مطابقة لبحثك",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 208, 113, 224),
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 3,
                        // Adjust the elevation as needed
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.white,
                        shadowColor: const Color.fromARGB(255, 208, 113, 224),
                        surfaceTintColor: Colors.white,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(9.0),
                          title: Text(
                            display_list[index].prnamigonaTitle!,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 208, 113, 224),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            display_list[index].prnamijonaDiscription!,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 208, 113, 224),
                              fontSize: 16.0,
                            ),
                          ),
                          trailing: Container(
                            margin: EdgeInsets.only(right: 16),
                            // Adjust left margin for position
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 243, 243, 243),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                display_list[index].icon,
                                color: const Color.fromARGB(255, 208, 113, 224),
                              ),
                              onPressed: () {
                                 switch (index) {
                              case 0:
                                // Navigate to CartPage for "الهدية"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GiftPage()),
                                );
                                break;
                              case 1:
                                // Navigate to a different page for "التبرع الدوري"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => periodicDonation()),
                                );
                                break;
                              case 2:
                                // Navigate to a different page for "الزكاة"
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => zakat()),
                                  );
                                break;
                              case 3:
                                // Navigate to a different page for "التبرع بالدم"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => bloodDonation()),
                                  );
                                break;
                              default:
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SearchPage()),
                                  );
                                break;
                            }
                              },
                            ),
                          ),
                          onTap: () {
                  // Handle onTap event for each list item
                     switch (index) {
                              case 0:
                                // Navigate to CartPage for "الهدية"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GiftPage()),
                                );
                                break;
                              case 1:
                                // Navigate to a different page for "التبرع الدوري"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => periodicDonation()),
                                );
                                break;
                              case 2:
                                // Navigate to a different page for "الزكاة"
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => zakat()),
                                  );
                                break;
                              case 3:
                                // Navigate to a different page for "التبرع بالدم"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => bloodDonation()),
                                  );
                                break;
                              default:
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SearchPage()),
                                  );
                                break;
                            }
                },
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
