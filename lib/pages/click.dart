
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DonationBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController donationAmountController = TextEditingController();

    Future<void> makeDonation(String amount) async {
      final url = Uri.parse('http://192.168.1.140:3000/user/update-donation');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'donation': int.parse(amount)}),
      );

      if (response.statusCode == 200) {
        // Successfully updated donation
        print('Donation updated successfully');
      } else {
        // Error occurred
        print('Error updating donation: ${response.body}');
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
        ),
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "قيمة المبلغ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 2, 88),
                    fontFamily: 'ElMessiri',
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: donationAmountController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            border: InputBorder.none,
                            hintText: 'ادخل قيمة التبرع',
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 2, 2, 88),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "₪",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final amount = donationAmountController.text;
                    makeDonation(amount);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 2, 2, 88),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Center(
                    child: Text(
                      "تبرع الان",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'ElMessiri',
                      ),
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








// import 'package:flutter/material.dart';

// class DonationBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController donationAmountController = TextEditingController();

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Padding(
//         padding: EdgeInsets.only(
//           left: 20.0,
//           right: 20.0,
//           top: 20.0,
//           bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
//         ),
//         child: SingleChildScrollView(
//           child: Directionality(
//             textDirection: TextDirection.rtl,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "قيمة المبلغ",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 2, 2, 88),
//                     fontFamily: 'ElMessiri',
//                   ),
//                   textAlign: TextAlign.right,
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Color.fromARGB(255, 224, 224, 224)),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: donationAmountController,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                             border: InputBorder.none,
//                             hintText: 'ادخل قيمة التبرع',
//                           ),
//                           keyboardType: TextInputType.number,
//                           textAlign: TextAlign.right,
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 2, 2, 88),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "₪",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontFamily: 'ElMessiri',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle the donation logic here
//                     final amount = donationAmountController.text;
//                     print('Donation amount: $amount');
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 2, 2, 88),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "تبرع الان",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontFamily: 'ElMessiri',
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }