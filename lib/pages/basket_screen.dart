import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'basket_module.dart';
import 'click.dart';

class  BasketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return Directionality(
      textDirection: TextDirection.rtl, // Set text direction to RTL
      child: Scaffold(
        backgroundColor:const Color.fromARGB(248, 255, 255, 255),
        appBar: AppBar(
          title:const Text(
            'سلة التسوق',
            style: TextStyle(
              fontFamily: 'ElMessiri',
              color: Color.fromARGB(255, 2, 2, 88),
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme:const IconThemeData(color: Color.fromARGB(255, 2, 2, 88)),
        ),
        body: Consumer<ShoppingBasket>(
          builder: (context, basket, child) {
            return basket.items.isNotEmpty
                ? ListView.builder(
                    itemCount: basket.items.length,
                    itemBuilder: (context, index) {
                      final item = basket.items[index];
                      final remainingAmount = item['donation_target'] - item['current_donation'];
                      return Card(
                        color: const Color.fromARGB(255, 236, 233, 233),
                        margin:const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: ListTile(
                          contentPadding:const EdgeInsets.all(15),
                          title: Text(
                            item['name'],
                            style:const TextStyle(
                              fontFamily: 'ElMessiri',
                              color: Color.fromARGB(255, 2, 2, 88),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'المبلغ المتبقي: $remainingAmount',
                            style:const TextStyle(
                              fontFamily: 'ElMessiri',
                              color: Color.fromARGB(255, 2, 2, 88),
                              fontSize: 14,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:const Icon(Icons.remove_shopping_cart),
                                color: Colors.red,
                                onPressed: () {
                                  basket.removeItem(item);
                                },
                              ),
                             const SizedBox(width: 10), // Spacing between the buttons
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:const Color.fromARGB(255, 2, 2, 88), // Button color
                                  foregroundColor: Colors.white, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  // Handle donate button press
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DonationBottomSheet(); // Your donation bottom sheet widget
                                    },
                                  );
                                },
                                child:const Text(
                                  'تبرع',
                                  style: TextStyle(
                                    fontFamily: 'ElMessiri',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'سلتك فارغة',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        color: Color.fromARGB(255, 2, 2, 88),
                        fontSize: 18,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'basket_module.dart';

// class BasketScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:const Text(
//           'Shopping Basket',
//           style: TextStyle(
//             fontFamily: 'ElMessiri',
//             color: Color.fromARGB(255, 2, 2, 88),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Color.fromARGB(255, 2, 2, 88)),
//       ),
//       body: Consumer<ShoppingBasket>(
//         builder: (context, basket, child) {
//           return basket.items.isNotEmpty
//               ? ListView.builder(
//                   itemCount: basket.items.length,
//                   itemBuilder: (context, index) {
//                     final item = basket.items[index];
//                     final remainingAmount = item['donation_target'] - item['current_donation'];
//                     return Card(
//                       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       elevation: 3,
//                       child: ListTile(
//                         contentPadding: EdgeInsets.all(15),
//                         title: Text(
//                           item['name'],
//                           style: TextStyle(
//                             fontFamily: 'ElMessiri',
//                             color: Color.fromARGB(255, 2, 2, 88),
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: Text(
//                           'Remaining amount: $remainingAmount',
//                           style: TextStyle(
//                             fontFamily: 'ElMessiri',
//                             color: Color.fromARGB(255, 2, 2, 88),
//                             fontSize: 14,
//                           ),
//                         ),
//                         trailing: IconButton(
//                           icon: Icon(Icons.remove_shopping_cart),
//                           color: Colors.red,
//                           onPressed: () {
//                             basket.removeItem(item);
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 )
//               : const Center(
//                   child: Text(
//                     'Your basket is empty',
//                     style: TextStyle(
//                       fontFamily: 'ElMessiri',
//                       color: Color.fromARGB(255, 2, 2, 88),
//                       fontSize: 18,
//                     ),
//                   ),
//                 );
//         },
//       ),
//     );
//   }
// }



