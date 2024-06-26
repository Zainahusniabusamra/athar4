import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:typed_data';
import 'package:flutter_application_athar_project/pages/case_description.dart';
import 'package:flutter_application_athar_project/pages/click.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_athar_project/pages/basket_module.dart'; // Import the ShoppingBasket model



class SecondSlider extends StatelessWidget {
  final List<dynamic> donations;

  SecondSlider({required this.donations});

  @override
  Widget build(BuildContext context) {
    return donations.isNotEmpty
        ? Container(
            margin:const EdgeInsets.only(top: 10, bottom: 10),
            height: 410,
            child: CarouselSlider.builder(
              itemCount: donations.length,
              options: CarouselOptions(
                aspectRatio: 0.9,
                enlargeCenterPage: true,
              ),
              itemBuilder: (BuildContext context, int index, _) {
                final donation = donations[index];
                final remainingAmount =
                    donation['donation_target'] - donation['current_donation'];
                final List<int>? imageData = donation['assetPath'] != null
                    ? (donation['assetPath']['data'] as List<dynamic>)
                        .cast<int>()
                    : null;

                final mainSlideHeight =
                    MediaQuery.of(context).size.height * 0.3;
                final slideHeight = mainSlideHeight * 0.5;

                return GestureDetector(
                  onTap: () {
                    final donation = donations[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CaseDescription(project: donation),
                      ),
                    );
                  },
                  child: Container(
                    height: slideHeight,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 233, 233),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: mainSlideHeight, // Set the same height as the main slide
                          margin:const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageData != null
                                ? Image.memory(
                                    Uint8List.fromList(imageData),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                :const Icon(Icons.image),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Title
                        Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              donation['name'] ?? '',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 2, 2, 88),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ElMessiri',
                              ),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // المبلغ المتبقي (Remaining Paid) and Value
                        Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Buttons
                              Row(
                                children: [
                                  // First Button - "تبرع الان"
                                  ElevatedButton(
                                    onPressed: () {
                                       showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DonationBottomSheet();
                                        },
                                      );
                                    },
                                    child:const Text("تبرع الان" , style: TextStyle(
                                      color: Color.fromARGB(255, 2, 2, 88),
                                    )),
                                  ),
                                  const SizedBox(width: 10), // Add spacing between buttons
                                  // Second Button - Shopping Basket Icon Button
                                  IconButton(
                                    onPressed: () {
                                      Provider.of<ShoppingBasket>(context, listen: false)
                                          .addItem(donation);
                                    },
                                    icon:const Icon(Icons.shopping_basket , color: Color.fromARGB(255, 2, 2, 88),),
                                  ),
                                ],
                              ),
                              // Text - "المبلغ المتبقي :"
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "المبلغ المتبقي :",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'ElMessiri',
                                      color: Color.fromARGB(255, 2, 2, 88),
                                    ),
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                  ),
                                const  SizedBox(height: 5),
                                  // Value
                                  Text(
                                    remainingAmount.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'ElMessiri',
                                      color: Color.fromARGB(255, 2, 2, 88),
                                    ),
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        :const CircularProgressIndicator();
  }
}
