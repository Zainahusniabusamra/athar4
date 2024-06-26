import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/our_program_pages/ZakatCalculator.dart';
import 'package:flutter_application_athar_project/our_program_pages/creatGift.dart';
import 'package:flutter_application_athar_project/module/Pramjona_module.dart';
import 'package:flutter_application_athar_project/module/pramijona_page_module.dart';
import 'package:flutter_application_athar_project/our_program_pages/prnamjona.dart';

class zakat extends StatefulWidget {
  const zakat ({super.key});

  @override
  State<zakat > createState() => _zakatState();
}

class _zakatState extends State<zakat > {
    static List<pramijonaModule> Zakat_list=[
pramijonaModule(" اخراج الزكاة ","دفع مبلغ الزكاة المعلوم مباشرة",Icons.money,),
pramijonaModule("حاسبة الزكاة","معرفة مقدار الزكاة الواجبة ثم دفعها مباشرة",Icons.calculate,),

  ];
   String selectedCurrency = 'USD'; // Default currency
  final currencies = ['USD', 'ILS', 'JOD']; // List of currencies
   double? Amount_of_money = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 113, 224),
        elevation: 0.0,
         title: Text('الزكاة'),
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
                          'الزكاة', 
                           
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 208, 113, 224),
                          ),
                        ),
                        SizedBox(height: 10), // Add some space between title and body text
                        Text(
                           textAlign: TextAlign.right,
                          'برنامج يتيح لك امكانية حساب الزكاة بأنواعها المختلفة ودفعها عبر طرق سهلة وسريعة لتصل الى مستحقيها.', // Your body text here
                          style: TextStyle(
                            fontSize: 18,
                            color:const Color.fromARGB(255, 208, 113, 224),
                          ),
                        ),
                        SizedBox(height: 20), // Add some space between search box and list
      Expanded(
        child: ListView.builder(
          
          itemCount: Zakat_list.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
             margin: EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.white,
                        shadowColor: const Color.fromARGB(255, 208, 113, 224),
                        surfaceTintColor: Colors.white,
              child: ListTile(
                title: Text(Zakat_list[index].prnamigonaTitle!,
                textAlign: TextAlign.right,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 208, 113, 224),
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                            ),
                            subtitle: Text(
                            Zakat_list[index].prnamijonaDiscription!,
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
                                size: 20.0,
                                Zakat_list[index].icon,
                                color: const Color.fromARGB(255, 208, 113, 224),
                              ),
                              onPressed: () {
                                switch (index) {
                              case 0:
                                showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            // This is the content of the floating page
                            return Container(
                              height: 450,
                              width: double.infinity,
                              color: Color.fromARGB(255, 219, 217, 217),
                              child: Column(
                                children: [
                                  SizedBox(height: 20.0),
                                  Container(
                                    height: 80.0,
                                    width: 120.0,
                                    padding: EdgeInsets.all(20.0),
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "اخراج الزكاة",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(183, 77, 29, 57),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    height: 180.0,
                                    width: 350.0,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 219, 217, 217),
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(color: Color.fromARGB(183, 77, 29, 57)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topRight,
                                          padding: EdgeInsets.all(15.0),
                                          height: 60.0,
                                          child: Text(
                                            "المبلغ",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(183, 77, 29, 57),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Container(
                                          height: 90.0,
                                          width: 300,
                                          child: TextField(
                                            textAlign: TextAlign.right,
                                            decoration: InputDecoration(
                                              hintTextDirection: TextDirection.rtl,
                                              hintText: '50000',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              prefix: DropdownButton<String>(
                                                value: selectedCurrency,
                                                items: currencies.map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedCurrency = newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                            onChanged: (value) {
                                             
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                       
                                       Navigator.pop(context); // Close the bottom sheet
                                       },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 150.0),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 157, 126, 161),
                                          borderRadius: BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 5.0,
                                              spreadRadius: 1.0,
                                              color: Color.fromARGB(255, 180, 150, 184),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          "احسب",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                    
                                break;
                              
                              case 1:
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ZakatCalculator()),
                                  );
                                break;
                                default :
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => zakat()),
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
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          // This is the content of the floating page
          return Container(
            height: 450,
            width: double.infinity,
            color: Color.fromARGB(255, 219, 217, 217),
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Container(
                  height: 80.0,
                  width: 120.0,
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.topCenter,
                  child: Text(
                    "اخراج الزكاة",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(183, 77, 29, 57),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 180.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 219, 217, 217),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Color.fromARGB(183, 77, 29, 57)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.all(15.0),
                        height: 60.0,
                        child: Text(
                          "المبلغ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(183, 77, 29, 57),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        height: 90.0,
                        width: 300,
                        child: TextField(
  textAlign: TextAlign.right,
  decoration: InputDecoration(
    hintTextDirection: TextDirection.rtl,
    hintText: '50000',
    errorText: (Amount_of_money == null || Amount_of_money == 0)
        ? 'الرجاء إدخال مبلغ للتبرع'
        : null, // Set error text if amount is null or 0
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        color: (Amount_of_money == null || Amount_of_money == 0)
            ? Colors.red // Change border color to red if amount is null or 0
            : Colors.grey, // Otherwise, use grey color
      ),
    ),
    prefix: DropdownButton<String>(
      value: selectedCurrency,
      items: currencies.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCurrency = newValue!;
        });
      },
    ),
  ),
  onChanged: (value) {
    setState(() {
      Amount_of_money = double.tryParse(value);
    });
  },
),
 ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 157, 126, 161),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              color: Color.fromARGB(255, 180, 150, 184),
                            ),
                          ],
                        ),
                        child: Text(
                          "إلغاء",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Check if the amount of zakat is greater than 0
      if (  Amount_of_money! <= 0) {
        // Notify the user to add the zakat amount
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("المبلغ من الزكاة يجب أن يكون أكبر من 0."),
        ));
      } else {
        // Show a floating page to collect payment information
   showModalBottomSheet(
  context: context,
  builder: (BuildContext context) {
    return Container(
      height: 800.0,
      width: double.infinity,
      color: Color.fromARGB(255, 219, 217, 217),
      child: Stack(
        children: [
          // Scrollable content
          Positioned(
            top: 80.0, // Height of the header
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 20.0,),
                  // Container to display total amount and selected currency
                  Container(
                    width: 360,
                    height: 90,
                 // margin: EdgeInsets.all(8.0),
                   // padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 189, 173, 185),
                      Colors.purpleAccent,
                    ],
                  ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          color: Color.fromARGB(255, 180, 150, 184),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "المبلغ الإجمالي",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "$Amount_of_money $selectedCurrency",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                   Container(
                    width: 360,
                    height: 80,
                  //margin: EdgeInsets.all(8.0),
                   // padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 243, 238, 242),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                  ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          color: Color.fromARGB(255, 180, 150, 184),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        
                        Text(
                          "$Amount_of_money $selectedCurrency",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color.fromARGB(183, 77, 29, 57),
                          ),
                        ),
                         SizedBox(width: 10.0),
                        Text(
                          "إخراج الزكاة",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(183, 77, 29, 57),
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                
                  
                    
                  SizedBox(height: 10.0,),
              Container(
  margin: EdgeInsets.all(20.0),
  padding: EdgeInsets.all(20.0),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20.0),
    border: Border.all(
      color: Color.fromARGB(183, 77, 29, 57), // Color of the border line
      width: 2.0, // Width of the border line
    ),
    boxShadow: [
      BoxShadow(
        blurRadius: 5.0,
        spreadRadius: 1.0,
        color: Color.fromARGB(255, 180, 150, 184),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        " الدفع عبر البطاقة البنكية",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(183, 77, 29, 57),
        ),
      ),
      SizedBox(height: 10.0,),
      Text(
        "رقم البطاقة",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(183, 146, 69, 114),
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '1234 5678 9012 3456',
        ),
      ),
      SizedBox(height: 20.0),
      Text(
        "الاسم على البطاقة",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(183, 77, 29, 57),
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'الاسم الكامل',
        ),
      ),
      SizedBox(height: 20.0),
      Text(
        "تاريخ الانتهاء",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(183, 77, 29, 57),
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'MM/YY',
        ),
      ),
      SizedBox(height: 20.0),
      Text(
        "الرمز الأمني",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(183, 77, 29, 57),
        ),
      ),
      SizedBox(height: 10.0),
      
       
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'رمز الامان',
              ),
            ),
         
          // Add some space between the text field and the text
          Text(
            "باتمام عملية التبرع انت توافق على ",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              // Open the privacy policy floating page
              // You can add the logic to open the floating page here
            },
            child: Text(
              "سياسة الخصوصية",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.blue, // Change the color of the link
                decoration: TextDecoration.underline, // Add underline to the text
              ),
            ),
          ),
        ],
      
    
  ),
),

    SizedBox(height: 30.0),
                  
                  Center(
                    child: InkWell(
                      onTap: () {
                        // Process payment here
                        // _processPayment(); // Call function to process payment
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 150.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 157, 126, 161),
                          borderRadius: BorderRadius.circular(20.0),
                          
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              color: Color.fromARGB(255, 180, 150, 184),
                            ),
                          ],
                        ),
                        child: Text(
                          "الدفع",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Fixed header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80.0,
              color: Color.fromARGB(255, 219, 217, 217),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      "بيانات الدفع",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(183, 77, 29, 57),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Color.fromARGB(183, 77, 29, 57)),
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  },
);
}
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 157, 126, 161),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              color: Color.fromARGB(255, 180, 150, 184),
                            ),
                          ],
                        ),
                        child: Text(
                          "المتابعة للدفع",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );

      break; 
      
       case 1:
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ZakatCalculator()),
                                  );
                                break;
                                default :
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => zakat()),
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