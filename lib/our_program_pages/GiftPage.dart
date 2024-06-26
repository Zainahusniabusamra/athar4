import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_athar_project/our_program_pages/creatGift.dart';
import 'package:flutter_application_athar_project/our_program_pages/prnamjona.dart';
import 'package:flutter_application_athar_project/module/Pramjona_module.dart';
import 'package:flutter_application_athar_project/module/pramijona_page_module.dart';
class GiftPage extends StatefulWidget {
  const GiftPage ({super.key});

  @override
  State<GiftPage > createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage > {
  static List<PramijonaPageModule> Gift_list = [
    PramijonaPageModule("أرسل هدية لمن تحب", Icons.card_giftcard),
  ];

  @override
  Widget build(BuildContext context) {  
    return  Scaffold(
       backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 113, 224),
        elevation: 0.0,
         title: Text('هدية أثر'),
          centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize:25.0 ,
          fontWeight: FontWeight.bold,
          

        ),
            automaticallyImplyLeading: false,
                  actions: [
              Container(
                margin: EdgeInsets.only(right: 16), // Adjust right margin for position
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 208, 113, 224), 
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  color: Colors.white,
                  iconSize: 25.0,
                  onPressed: () {
                  //  Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => pramijona()),
                  //   );
                  },
                ),
              ),
            ],
                ),
               body: Padding(
                 padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0), 
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text( 
                          textAlign: TextAlign.right,
                          'هدية أثر', 
                           
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 208, 113, 224),
                          ),
                        ),
                        SizedBox(height: 10), // Add some space between title and body text
                        Text(
                           textAlign: TextAlign.right,
                          'خدمة لتقديم التبرعات عن الغير كهدية للاهل والأصدقاء، في مختلف المناسبات الاجتماعية', // Your body text here
                          style: TextStyle(
                            fontSize: 18,
                            color:const Color.fromARGB(255, 208, 113, 224),
                          ),
                        ),
                        SizedBox(height: 20), // Add some space between search box and list
      Expanded(
        child: ListView.builder(
          
          itemCount: Gift_list.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
             margin: EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.white,
                        shadowColor: const Color.fromARGB(255, 208, 113, 224),
                        surfaceTintColor: Colors.white,
              child: ListTile(
                title: Text(Gift_list[index].prnamigonaTitle!,
                textAlign: TextAlign.right,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 208, 113, 224),
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),),
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
                                size: 20.0,
                                Gift_list[index].icon,
                                color: const Color.fromARGB(255, 208, 113, 224),
                              ),
                              onPressed: () {
                                switch (index) {
                              case 0:
                                // Navigate to CartPage for "الهدية"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => creatGift()),
                                );
                                break;
                              
                              default:
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GiftPage()),
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
                                  MaterialPageRoute(builder: (context) => creatGift()),
                                );
                                break;
                              
                              default:
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GiftPage()),
                                  );
                                break;
                            }
                },
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