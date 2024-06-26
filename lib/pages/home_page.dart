import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'second_slider.dart';
import 'package:flutter_application_athar_project/admin_pages/done.dart';
import 'basket_screen.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<dynamic> donations = [];
  @override
  void initState() {
    super.initState();
    fetchLowDonations();
  }

  Future<void> fetchLowDonations() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.140:3000/user/low-donations'));

      if (response.statusCode == 200) {
        setState(() {
          donations = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load low donations');
      }
    } catch (error) {
      print('Error fetching low donations: $error');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(248, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 94,
            padding:const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            child: Stack(
              children: [

                
                Positioned(
                  top: 0,
                  left: 0,
                  child:
                   Row(
                    children: [
                      Container(
                        margin:const EdgeInsets.only(top: 30, bottom: 10, right: 10),
                        child: IconButton(
            icon: const Icon(
              Icons.shopping_basket_rounded,
              color: Color.fromARGB(255, 17, 3, 134),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BasketScreen(),
                ),
              );
            },
                          // icon: const Icon(
                          //   Icons.shopping_basket_rounded,
                          //   color: Color.fromARGB(255, 17, 3, 134),
                          // ),
                          // onPressed: () {
                          //   // Add onPressed functionality for the basket icon button
                          // },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: Image.asset(
                    'assets/imgs/athar_logo.jpg', // Replace with your better icon asset
                    height: 55,
                    width: 55,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FirstSlider(),
                 const SizedBox(height: 20),
                  Container(
                    padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    margin:const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image:const DecorationImage(
                        image: AssetImage('assets/imgs/olive.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           const SizedBox(width: 30),
                            ElevatedButton(
                              onPressed: () {
                                // Add functionality for the button
                              },
                              style: ElevatedButton.styleFrom(
                                //backgroundColor:Color.fromARGB(255, 236, 233, 233),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Text(
                                  'ساهم بعطائك',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 2, 2, 88),
                                      fontFamily: 'ElMessiri'),
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'وقف احسان',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 246, 246, 248),
                                        fontFamily: 'ElMessiri'),
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Text(
                                    'صدقة جارية يدوم نفعها ويتضاعف اجرها ',
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    selectionColor: Color.fromARGB(255, 235, 235, 240),
                                    style: TextStyle(
                                      color:  Color.fromARGB(255, 246, 246, 248),
                                        fontSize: 14, fontFamily: 'ElMessiri'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.keyboard_double_arrow_left_rounded ,color: Color.fromARGB(255, 2, 2, 88),),
                          onPressed: () {
                            // Add functionality for the icon button
                          },
                        ),
                        const Text(
                          'فرص تبرع',
                          style: TextStyle(
                            color: Color.fromARGB(255, 2, 2, 88),
                              fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'ElMessiri'),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  SecondSlider(donations: donations),
                
                Padding(
                    padding:const EdgeInsets.all(15), // Adjust the margin as needed
                    child: AspectRatio(
                      aspectRatio: 37 / 4, // Adjust the aspect ratio as needed
                      child: SvgPicture.asset(
                        'assets/imgs/ahseno-ayah.svg',
                        fit: BoxFit.contain, // Adjust the fit as needed
                        color:const  Color.fromARGB(255, 2, 2, 88), // Set the color to blue
                      ),
                    ),
                  ),
Container(
  margin:const EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // First Button
      ElevatedButton(
        onPressed: () {
          // Add functionality for the first button
        },
        style: ElevatedButton.styleFrom(
          iconColor:const Color.fromARGB(255, 2, 2, 88),
          backgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
          ),
        ),
        child: Container(
          height: 170,
          width: 65,
          padding:const EdgeInsets.symmetric(vertical: 8), // Adjust padding as needed
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people), // or Icons.group
              SizedBox(height: 10), // Adjust spacing between icon and title as needed
              Text(
                'ابرز المحسنين',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'ElMessiri',
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ), // Adjust font size as needed
            ],
          ),
        ),
      ),
      // Second Button
      ElevatedButton(
        onPressed: () {
          // Add functionality for the second button
        },
        style: ElevatedButton.styleFrom(
          iconColor:const Color.fromARGB(255, 2, 2, 88),
          backgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
          ),
        ),
        child: Container(
          height: 170,
          width: 65,
          padding:const EdgeInsets.symmetric(vertical: 8), // Adjust padding as needed
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.handshake), // or Icons.people_outline
              SizedBox(height: 10), // Adjust spacing between icon and title as needed
              Text(
                'شركاء احسان',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'ElMessiri',
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ), // Adjust font size as needed
            ],
          ),
        ),
      ),
      // Third Button
      ElevatedButton(
        onPressed: () {
          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFListPage(),
                        ),
                      );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          iconColor:const Color.fromARGB(255, 2, 2, 88),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
          ),
        ),
        child: Container(
          height: 170,
          width: 65,
          padding:const EdgeInsets.symmetric(vertical: 8), // Adjust padding as needed
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_chart), // or Icons.show_chart
              SizedBox(height: 10), // Adjust spacing between icon and title as needed
              Text(
                'الاحصائيات',
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 2, 88),
                  fontSize: 14,
                  fontFamily: 'ElMessiri',
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ), // Adjust font size as needed
            ],
          ),
        ),
      ),
    ],
  ),
),




                  Container(
                    padding:const EdgeInsets.all(20), // Adjust padding as needed
                    decoration: BoxDecoration(
                      color: Colors
                          .grey.shade200, // Adjust background color as needed
                      borderRadius: BorderRadius.circular(
                          10), // Adjust border radius as needed
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title
                       const Text('احسان في ارقام ',style: TextStyle(
                          color: Color.fromARGB(255, 2, 2, 88),
                              fontSize: 18, fontWeight: FontWeight.bold ,fontFamily: 'ElMessiri',),
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                        ),
                       const SizedBox(height:10), // Add spacing between title and sections
                        // Sections
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // First Section
                            Container(
                              width: 300, // Adjust width as needed
                              height: 150, // Adjust height as needed
                              margin:const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color:const Color.fromARGB(255, 2, 2, 88),
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust border radius as needed
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.yard,
                                      color: Colors
                                          .white), // Adjust icon color as needed
                                  SizedBox(
                                      height:
                                          5), // Adjust spacing between icon and text
                                  Text('اجمالي التبرعات',style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold,
                                          color: Colors.white,fontFamily: 'ElMessiri',
                                    ),
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                          ), // Adjust text color as needed
                                  SizedBox(height:5), // Adjust spacing between text and number
                                  Text('10',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .white)), // Adjust number color as needed
                                ],
                              ),
                            ),
                            // Second Section
                            Container(
                              width: 300, // Adjust width as needed
                              height: 150,
                              margin:const EdgeInsets.all(8), // Adjust height as needed
                              decoration: BoxDecoration(
                                color:const Color.fromARGB(255, 2, 2, 88),
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust border radius as needed
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_2,
                                      color: Colors
                                          .white), // Adjust icon color as needed
                                  SizedBox(
                                      height:
                                          5), // Adjust spacing between icon and text
                                  Text('عدد المستفيدين من البرامج الخيرية  ',
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                                          color: Colors.white,fontFamily: 'ElMessiri',
                                    ),
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                      ),
                                 Text('والتموينية لعام 2023 وحتى الان ',
                                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                                          color: Colors.white,fontFamily: 'ElMessiri',
                                    ),
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                      ), // Adjust text color as needed
                                  SizedBox(height:5), // Adjust spacing between text and number
                                  Text('20',style: TextStyle(fontSize: 14,color: Colors.white)), // Adjust number color as needed
                                ],
                              ),
                            ),
                            // Third Section
                            Container(
                              width: 300, // Adjust width as needed
                              height: 150,
                              margin:const EdgeInsets.all(8), // Adjust height as needed
                              decoration: BoxDecoration(
                                color:const Color.fromARGB(255, 2, 2, 88),
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust border radius as needed
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person,
                                      color: Colors
                                          .white), // Adjust icon color as needed
                                  SizedBox(height:5), // Adjust spacing between icon and text
                                  Text('عدد عمليات التبرع',style:TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold,
                                          color: Colors.white,fontFamily: 'ElMessiri',
                                    ),
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,), // Adjust text color as needed
                                  SizedBox(
                                      height:
                                          5), // Adjust spacing between text and number
                                  Text('30',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .white)), // Adjust number color as needed
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding:const EdgeInsets.all(15), // Adjust the margin as needed
                    child: AspectRatio(
                      aspectRatio: 37 / 4, // Adjust the aspect ratio as needed
                      child: SvgPicture.asset(
                        'assets/imgs/lntnalo-ayah.svg',
                        fit: BoxFit.contain, // Adjust the fit as needed
                        color:const Color.fromARGB(255, 2, 2, 88),
                      ),
                    ),
                  ),
          

                ],
              ),
            ),
          ),
        ],
    
    
    
    
    
      ),
    );
  }

}




class FirstSlider extends StatefulWidget {
  @override
  _FirstSliderState createState() => _FirstSliderState();
}

class _FirstSliderState extends State<FirstSlider> {
  final myitems = [
    {
      'image': 'assets/imgs/flag2.png',
      'text': 'تبرع الان',
      'description': 'الخير بين يديك',
      'slideText': 'فرصة'
    },
    {
      'image': 'assets/imgs/alquds3.png',
      'text': 'اخرج زكاتك',
      'description': 'الخير بين يديك',
      'slideText': 'زكاة مالك'
    },
    {
      'image': 'assets/imgs/celine7.png',
      'text': 'اهد احبابك',
      'description': 'لتسعدهم بعطائك',
      'slideText': 'الهدية'
    },
    {
      'image': 'assets/imgs/gaza2.png',
      'text': 'فرج كربهم',
      'description': 'بعطائك تعيد الامل',
      'slideText': 'فرجت'
    },
  ];

  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: myitems.length,
          options: CarouselOptions(
            autoPlay: true, // Enable auto-play
            height: 200,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayInterval: const Duration(seconds: 2),
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                myCurrentIndex = index;
              });
            },
          ),
          itemBuilder: (BuildContext context, int index, _) {
            return  Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Rounded edges
                    child: Image.asset(
                      myitems[index]['image'] as String,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 45,
                    right: 20,
                    child: Text(
                      myitems[index]['slideText'] as String,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 2, 2, 88),
                          fontSize: 16,
                          fontFamily: 'ElMessiri'),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myitems[index]['description'] as String,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 2, 2, 88), fontFamily: 'ElMessiri'),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for the button
                          },
                          child: Text(
                            myitems[index]['text'] as String,
                            style: TextStyle(
                              color: Color.fromARGB(255, 2, 2, 88),
                                fontSize: 16, fontFamily: 'ElMessiri'),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
//backgroundColor:Color.fromARGB(255, 236, 233, 233),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
              const  SizedBox(height: 10), // Add space below the CarouselSlider

        AnimatedSmoothIndicator(
          activeIndex: myCurrentIndex,
          count: myitems.length,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            spacing: 10,
            dotColor: Colors.grey.shade200,
            activeDotColor: Colors.grey.shade900,
            paintStyle: PaintingStyle.fill,
          ),
        ),
      ],
    );
  }
}


// class SecondSlider extends StatelessWidget {
//   final List<dynamic> donations;

//   SecondSlider({required this.donations});

//   @override
//   Widget build(BuildContext context) {
//     return donations.isNotEmpty
//         ? Container(
//             margin: EdgeInsets.only(top: 10, bottom: 10),
//             height: 410,
//             child: CarouselSlider.builder(
//               itemCount: donations.length,
//               options: CarouselOptions(
//                 aspectRatio: 0.9,
//                 enlargeCenterPage: true,
//               ),
//               itemBuilder: (BuildContext context, int index, _) {
//                 final donation = donations[index];
//                 final remainingAmount =
//                     donation['donation_target'] - donation['current_donation'];
//                 final List<int>? imageData = donation['assetPath'] != null
//                     ? (donation['assetPath']['data'] as List<dynamic>)
//                         .cast<int>()
//                     : null;

//                 final mainSlideHeight =
//                     MediaQuery.of(context).size.height * 0.3;
//                 final slideHeight = mainSlideHeight * 0.5;

//                 return GestureDetector(
//                   onTap: () {
//                     final donation = donations[index];
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CaseDescription(project: donation),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: slideHeight,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 236, 233, 233),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Image
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           height: mainSlideHeight, // Set the same height as the main slide
//                           margin: EdgeInsets.all(10),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: imageData != null
//                                 ? Image.memory(
//                                     Uint8List.fromList(imageData),
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Icon(Icons.image),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         // Title
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Text(
//                               donation['name'] ?? '',
//                               style: const TextStyle(
//                                 color: Color.fromARGB(255, 2, 2, 88),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'ElMessiri',
//                               ),
//                               textAlign: TextAlign.right,
//                               textDirection: TextDirection.rtl,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         // المبلغ المتبقي (Remaining Paid) and Value
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               // Buttons
//                               Row(
//                                 children: [
//                                   // First Button - "تبرع الان"
//                                   ElevatedButton(
//                                     onPressed: () {
//                                        showModalBottomSheet(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return DonationBottomSheet();
//                                         },
//                                       );
//                                     },
//                                     child: Text("تبرع الان" , style: TextStyle(
//                                       color: Color.fromARGB(255, 2, 2, 88),
//                                     )),
//                                   ),
//                                   const SizedBox(width: 10), // Add spacing between buttons
//                                   // Second Button - Shopping Basket Icon Button
//                                   IconButton(
//                                     onPressed: () {
//                                       // Handle onPressed for the second button
//                                     },
//                                     icon: Icon(Icons.shopping_basket , color: Color.fromARGB(255, 2, 2, 88),),
//                                   ),
//                                 ],
//                               ),
//                               // Text - "المبلغ المتبقي :"
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   const Text(
//                                     "المبلغ المتبقي :",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontFamily: 'ElMessiri',
//                                       color: Color.fromARGB(255, 2, 2, 88),
//                                     ),
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                                   ),
//                                   SizedBox(height: 5),
//                                   // Value
//                                   Text(
//                                     remainingAmount.toString(),
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontFamily: 'ElMessiri',
//                                       color: Color.fromARGB(255, 2, 2, 88),
//                                     ),
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           )
//         : CircularProgressIndicator();
//   }
// }



























// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_application_athar_project/pages/case_description.dart';
// import 'package:flutter_application_athar_project/pages/click.dart';

// class homePage extends StatefulWidget {
//   const homePage({Key? key}) : super(key: key);

//   @override
//   State<homePage> createState() => _homePageState();
// }

// class _homePageState extends State<homePage> {
//   List<dynamic> donations = [];
//   @override
//   void initState() {
//     super.initState();
//     fetchLowDonations();
//   }

//   Future<void> fetchLowDonations() async {
//     try {
//       final response = await http.get(Uri.parse('http://192.168.1.140:3000/user/low-donations'));

//       if (response.statusCode == 200) {
//         setState(() {
//           donations = json.decode(response.body);
//         });
//       } else {
//         throw Exception('Failed to load low donations');
//       }
//     } catch (error) {
//       print('Error fetching low donations: $error');
//     }
//   }





//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(248, 255, 255, 255),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             height: 94,
//             padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
//             child: Stack(
//               children: [

                
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   child:
//                    Row(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(top: 30, bottom: 10, right: 10),
//                         child: IconButton(
//                           icon: const Icon(
//                             Icons.shopping_basket_rounded,
//                             color: Color.fromARGB(255, 17, 3, 134),
//                           ),
//                           onPressed: () {
//                             // Add onPressed functionality for the basket icon button
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
//                     'assets/imgs/donation.png', // Replace with your better icon asset
//                     height: 35,
//                     width: 35,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   FirstSlider(),
//                   SizedBox(height: 20),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                     margin: EdgeInsets.symmetric(horizontal: 20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       image: DecorationImage(
//                         image: AssetImage('assets/imgs/olive.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: Stack(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(width: 30),
//                             ElevatedButton(
//                               onPressed: () {
//                                 // Add functionality for the button
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 //backgroundColor:Color.fromARGB(255, 236, 233, 233),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 10, horizontal: 10),
//                                 child: Text(
//                                   'ساهم بعطائك',
//                                   style: TextStyle(
//                                     color: Color.fromARGB(255, 2, 2, 88),
//                                       fontFamily: 'ElMessiri'),
//                                   textAlign: TextAlign.right,
//                                   textDirection: TextDirection.rtl,
//                                 ),
//                               ),
//                             ),
//                             const Expanded(
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     'وقف احسان',
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color.fromARGB(255, 246, 246, 248),
//                                         fontFamily: 'ElMessiri'),
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                                   ),
//                                   Text(
//                                     'صدقة جارية يدوم نفعها ويتضاعف اجرها ',
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                                     selectionColor: Color.fromARGB(255, 235, 235, 240),
//                                     style: TextStyle(
//                                       color:  Color.fromARGB(255, 246, 246, 248),
//                                         fontSize: 14, fontFamily: 'ElMessiri'),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.keyboard_double_arrow_left_rounded ,color: Color.fromARGB(255, 2, 2, 88),),
//                           onPressed: () {
//                             // Add functionality for the icon button
//                           },
//                         ),
//                         const Text(
//                           'فرص تبرع',
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 2, 2, 88),
//                               fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'ElMessiri'),
//                           textAlign: TextAlign.right,
//                           textDirection: TextDirection.rtl,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SecondSlider(donations: donations),
                
//                 Padding(
//                     padding: EdgeInsets.all(15), // Adjust the margin as needed
//                     child: AspectRatio(
//                       aspectRatio: 37 / 4, // Adjust the aspect ratio as needed
//                       child: SvgPicture.asset(
//                         'assets/imgs/ahseno-ayah.svg',
//                         fit: BoxFit.contain, // Adjust the fit as needed
//                         color:  Color.fromARGB(255, 2, 2, 88), // Set the color to blue
//                       ),
//                     ),
//                   ),
// Container(
//   margin: EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       // First Button
//       ElevatedButton(
//         onPressed: () {
//           // Add functionality for the first button
//         },
//         style: ElevatedButton.styleFrom(
//           iconColor: Color.fromARGB(255, 2, 2, 88),
//           backgroundColor: Colors.grey.shade200,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
//           ),
//         ),
//         child: Container(
//           height: 170,
//           width: 65,
//           padding: EdgeInsets.symmetric(vertical: 8), // Adjust padding as needed
//           child: const Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.people), // or Icons.group
//               SizedBox(height: 10), // Adjust spacing between icon and title as needed
//               Text(
//                 'ابرز المحسنين',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'ElMessiri',
//                 ),
//                 textAlign: TextAlign.center,
//                 textDirection: TextDirection.rtl,
//               ), // Adjust font size as needed
//             ],
//           ),
//         ),
//       ),
//       // Second Button
//       ElevatedButton(
//         onPressed: () {
//           // Add functionality for the second button
//         },
//         style: ElevatedButton.styleFrom(
//           iconColor: Color.fromARGB(255, 2, 2, 88),
//           backgroundColor: Colors.grey.shade200,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
//           ),
//         ),
//         child: Container(
//           height: 170,
//           width: 65,
//           padding: EdgeInsets.symmetric(vertical: 8), // Adjust padding as needed
//           child: const Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.handshake), // or Icons.people_outline
//               SizedBox(height: 10), // Adjust spacing between icon and title as needed
//               Text(
//                 'شركاء احسان',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'ElMessiri',
//                 ),
//                 textAlign: TextAlign.center,
//                 textDirection: TextDirection.rtl,
//               ), // Adjust font size as needed
//             ],
//           ),
//         ),
//       ),
//       // Third Button
//       ElevatedButton(
//         onPressed: () {
//           // Add functionality for the third button
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.grey.shade200,
//           iconColor: Color.fromARGB(255, 2, 2, 88),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
//           ),
//         ),
//         child: Container(
//           height: 170,
//           width: 65,
//           padding: EdgeInsets.symmetric(vertical: 8), // Adjust padding as needed
//           child: const Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.insert_chart), // or Icons.show_chart
//               SizedBox(height: 10), // Adjust spacing between icon and title as needed
//               Text(
//                 'الاحصائيات',
//                 style: TextStyle(
//                   color: Color.fromARGB(255, 2, 2, 88),
//                   fontSize: 14,
//                   fontFamily: 'ElMessiri',
//                 ),
//                 textAlign: TextAlign.center,
//                 textDirection: TextDirection.rtl,
//               ), // Adjust font size as needed
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// ),




//                   Container(
//                     padding: EdgeInsets.all(20), // Adjust padding as needed
//                     decoration: BoxDecoration(
//                       color: Colors
//                           .grey.shade200, // Adjust background color as needed
//                       borderRadius: BorderRadius.circular(
//                           10), // Adjust border radius as needed
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Title
//                         Text('احسان في ارقام ',style: TextStyle(
//                           color: Color.fromARGB(255, 2, 2, 88),
//                               fontSize: 18, fontWeight: FontWeight.bold ,fontFamily: 'ElMessiri',),
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                         ),
//                        const SizedBox(height:10), // Add spacing between title and sections
//                         // Sections
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // First Section
//                             Container(
//                               width: 300, // Adjust width as needed
//                               height: 150, // Adjust height as needed
//                               margin: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color:Color.fromARGB(255, 2, 2, 88),
//                                 borderRadius: BorderRadius.circular(
//                                     10), // Adjust border radius as needed
//                               ),
//                               child: const Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.yard,
//                                       color: Colors
//                                           .white), // Adjust icon color as needed
//                                   SizedBox(
//                                       height:
//                                           5), // Adjust spacing between icon and text
//                                   Text('اجمالي التبرعات',style: TextStyle(
//                                           fontSize: 18, fontWeight: FontWeight.bold,
//                                           color: Colors.white,fontFamily: 'ElMessiri',
//                                     ),
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                                           ), // Adjust text color as needed
//                                   SizedBox(height:5), // Adjust spacing between text and number
//                                   Text('10',
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors
//                                               .white)), // Adjust number color as needed
//                                 ],
//                               ),
//                             ),
//                             // Second Section
//                             Container(
//                               width: 300, // Adjust width as needed
//                               height: 150,
//                               margin:
//                                   EdgeInsets.all(8), // Adjust height as needed
//                               decoration: BoxDecoration(
//                                 color:Color.fromARGB(255, 2, 2, 88),
//                                 borderRadius: BorderRadius.circular(
//                                     10), // Adjust border radius as needed
//                               ),
//                               child: const Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.person_2,
//                                       color: Colors
//                                           .white), // Adjust icon color as needed
//                                   SizedBox(
//                                       height:
//                                           5), // Adjust spacing between icon and text
//                                   Text('عدد المستفيدين من البرامج الخيرية  ',
//                                       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
//                                           color: Colors.white,fontFamily: 'ElMessiri',
//                                     ),
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                                       ),
//                                  Text('والتموينية لعام 2023 وحتى الان ',
//                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
//                                           color: Colors.white,fontFamily: 'ElMessiri',
//                                     ),
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                                       ), // Adjust text color as needed
//                                   SizedBox(height:5), // Adjust spacing between text and number
//                                   Text('20',style: TextStyle(fontSize: 14,color: Colors.white)), // Adjust number color as needed
//                                 ],
//                               ),
//                             ),
//                             // Third Section
//                             Container(
//                               width: 300, // Adjust width as needed
//                               height: 150,
//                               margin:
//                                   EdgeInsets.all(8), // Adjust height as needed
//                               decoration: BoxDecoration(
//                                 color:Color.fromARGB(255, 2, 2, 88),
//                                 borderRadius: BorderRadius.circular(
//                                     10), // Adjust border radius as needed
//                               ),
//                               child: const Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.person,
//                                       color: Colors
//                                           .white), // Adjust icon color as needed
//                                   SizedBox(height:5), // Adjust spacing between icon and text
//                                   Text('عدد عمليات التبرع',style:TextStyle(
//                                           fontSize: 18, fontWeight: FontWeight.bold,
//                                           color: Colors.white,fontFamily: 'ElMessiri',
//                                     ),
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,), // Adjust text color as needed
//                                   SizedBox(
//                                       height:
//                                           5), // Adjust spacing between text and number
//                                   Text('30',
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors
//                                               .white)), // Adjust number color as needed
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),


//                   Padding(
//                     padding: EdgeInsets.all(15), // Adjust the margin as needed
//                     child: AspectRatio(
//                       aspectRatio: 37 / 4, // Adjust the aspect ratio as needed
//                       child: SvgPicture.asset(
//                         'assets/imgs/lntnalo-ayah.svg',
//                         fit: BoxFit.contain, // Adjust the fit as needed
//                         color:Color.fromARGB(255, 2, 2, 88),
//                       ),
//                     ),
//                   ),
          

//                 ],
//               ),
//             ),
//           ),
//         ],
    
    
    
    
    
//       ),
//     );
//   }

// }




// class FirstSlider extends StatefulWidget {
//   @override
//   _FirstSliderState createState() => _FirstSliderState();
// }

// class _FirstSliderState extends State<FirstSlider> {
//   final myitems = [
//     {
//       'image': 'assets/imgs/flag2.png',
//       'text': 'تبرع الان',
//       'description': 'الخير بين يديك',
//       'slideText': 'فرصة'
//     },
//     {
//       'image': 'assets/imgs/alquds3.png',
//       'text': 'اخرج زكاتك',
//       'description': 'الخير بين يديك',
//       'slideText': 'زكاة مالك'
//     },
//     {
//       'image': 'assets/imgs/celine7.png',
//       'text': 'اهد احبابك',
//       'description': 'لتسعدهم بعطائك',
//       'slideText': 'الهدية'
//     },
//     {
//       'image': 'assets/imgs/gaza2.png',
//       'text': 'فرج كربهم',
//       'description': 'بعطائك تعيد الامل',
//       'slideText': 'فرجت'
//     },
//   ];

//   int myCurrentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider.builder(
//           itemCount: myitems.length,
//           options: CarouselOptions(
//             autoPlay: true, // Enable auto-play
//             height: 200,
//             autoPlayCurve: Curves.fastOutSlowIn,
//             autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             autoPlayInterval: const Duration(seconds: 2),
//             enlargeCenterPage: true,
//             aspectRatio: 2.0,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 myCurrentIndex = index;
//               });
//             },
//           ),
//           itemBuilder: (BuildContext context, int index, _) {
//             return Container(
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10), // Rounded edges
//                     child: Image.asset(
//                       myitems[index]['image'] as String,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                   ),
//                   Positioned(
//                     top: 45,
//                     right: 20,
//                     child: Text(
//                       myitems[index]['slideText'] as String,
//                       style: const TextStyle(
//                           color: Color.fromARGB(255, 2, 2, 88),
//                           fontSize: 16,
//                           fontFamily: 'ElMessiri'),
//                       textAlign: TextAlign.right,
//                       textDirection: TextDirection.rtl,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 40,
//                     right: 20,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           myitems[index]['description'] as String,
//                           style: const TextStyle(
//                               color: Color.fromARGB(255, 2, 2, 88), fontFamily: 'ElMessiri'),
//                           textAlign: TextAlign.right,
//                           textDirection: TextDirection.rtl,
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Add functionality for the button
//                           },
//                           child: Text(
//                             myitems[index]['text'] as String,
//                             style: TextStyle(
//                               color: Color.fromARGB(255, 2, 2, 88),
//                                 fontSize: 16, fontFamily: 'ElMessiri'),
//                             textAlign: TextAlign.right,
//                             textDirection: TextDirection.rtl,
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 8,
//                               horizontal: 16,
//                             ),
// //backgroundColor:Color.fromARGB(255, 236, 233, 233),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//                 SizedBox(height: 10), // Add space below the CarouselSlider

//         AnimatedSmoothIndicator(
//           activeIndex: myCurrentIndex,
//           count: myitems.length,
//           effect: WormEffect(
//             dotHeight: 8,
//             dotWidth: 8,
//             spacing: 10,
//             dotColor: Colors.grey.shade200,
//             activeDotColor: Colors.grey.shade900,
//             paintStyle: PaintingStyle.fill,
//           ),
//         ),
//       ],
//     );
//   }
// }


// class SecondSlider extends StatelessWidget {
//   final List<dynamic> donations;

//   SecondSlider({required this.donations});

//   @override
//   Widget build(BuildContext context) {
//     return donations.isNotEmpty
//         ? Container(
//             margin: EdgeInsets.only(top: 10, bottom: 10),
//             height: 410,
//             child: CarouselSlider.builder(
//               itemCount: donations.length,
//               options: CarouselOptions(
//                 aspectRatio: 0.9,
//                 enlargeCenterPage: true,
//               ),
//               itemBuilder: (BuildContext context, int index, _) {
//                 final donation = donations[index];
//                 final remainingAmount =
//                     donation['donation_target'] - donation['current_donation'];
//                 final List<int>? imageData = donation['assetPath'] != null
//                     ? (donation['assetPath']['data'] as List<dynamic>)
//                         .cast<int>()
//                     : null;

//                 final mainSlideHeight =
//                     MediaQuery.of(context).size.height * 0.3;
//                 final slideHeight = mainSlideHeight * 0.5;

//                 return GestureDetector(
//                   onTap: () {
//                     final donation = donations[index];
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CaseDescription(project: donation),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: slideHeight,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 236, 233, 233),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Image
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           height: mainSlideHeight, // Set the same height as the main slide
//                           margin: EdgeInsets.all(10),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: imageData != null
//                                 ? Image.memory(
//                                     Uint8List.fromList(imageData),
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Icon(Icons.image),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         // Title
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Text(
//                               donation['name'] ?? '',
//                               style: const TextStyle(
//                                 color: Color.fromARGB(255, 2, 2, 88),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'ElMessiri',
//                               ),
//                               textAlign: TextAlign.right,
//                               textDirection: TextDirection.rtl,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         // المبلغ المتبقي (Remaining Paid) and Value
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               // Buttons
//                               Row(
//                                 children: [
//                                   // First Button - "تبرع الان"
//                                   ElevatedButton(
//                                     onPressed: () {
//                                        showModalBottomSheet(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return DonationBottomSheet();
//                                         },
//                                       );
//                                     },
//                                     child: Text("تبرع الان" , style: TextStyle(
//                                       color: Color.fromARGB(255, 2, 2, 88),
//                                     )),
//                                   ),
//                                   const SizedBox(width: 10), // Add spacing between buttons
//                                   // Second Button - Shopping Basket Icon Button
//                                   IconButton(
//                                     onPressed: () {
//                                       // Handle onPressed for the second button
//                                     },
//                                     icon: Icon(Icons.shopping_basket , color: Color.fromARGB(255, 2, 2, 88),),
//                                   ),
//                                 ],
//                               ),
//                               // Text - "المبلغ المتبقي :"
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   const Text(
//                                     "المبلغ المتبقي :",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontFamily: 'ElMessiri',
//                                       color: Color.fromARGB(255, 2, 2, 88),
//                                     ),
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                                   ),
//                                   SizedBox(height: 5),
//                                   // Value
//                                   Text(
//                                     remainingAmount.toString(),
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontFamily: 'ElMessiri',
//                                       color: Color.fromARGB(255, 2, 2, 88),
//                                     ),
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           )
//         : CircularProgressIndicator();
//   }
// }







