import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_athar_project/our_program_pages/zakat.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class ZakatCalculator extends StatefulWidget {
  const ZakatCalculator({Key? key}) : super(key: key);

  @override
  State<ZakatCalculator> createState() => _ZakatCalculatorState();
}

class _ZakatCalculatorState extends State<ZakatCalculator> {
  List<Widget> additionalContainers = [];
  List<Widget> additionalContainersForSilver = [];
  double? Amount_of_money = 0;
  double? Zakat_on_money;
  double? Silver_weight=0.0;
  double? Price_of_a_gram_of_silver=3.8;
  double? Zakat_on_silver;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext? bottomSheetContext;

  String selectedCurrency = 'USD'; // Default currency
  final currencies = ['USD', 'ILS', 'JOD']; // List of currencies

  int containerCount = 0;
  int keyCount = 0; // Add a new counter for generating unique keys

  String selectedGoldkarat = 'عيار12'; 
  double? goldWeight;
   double? goldenzakatAmount;
   double? pureGoldWeight = 0.0;

  final List<String> Goldkarat = ['عيار12', 'عيار14', 'عيار18' , 'عيار21', 'عيار22', 'عيار14']; 
  /********************************************************************************************** */
  /********************************************************************************************** */
  double getGoldPurity(String karat) {
    switch (karat) {
      case 'عيار24':
        return 1.0; // 100% purity
      case 'عيار22':
        return 0.9167; // 91.67% purity
      case 'عيار21':
        return 0.875; // 87.5% purity
      case 'عيار18':
        return 0.75; // 75% purity
      case 'عيار14':
        return 0.5833; // 58.33% purity
      case 'عيار12':
        return 0.5; // 50% purity
      default:
        return 1.0; // Default to 24K if no match
    }
  }
  void calculateZakat() {
    if (selectedGoldkarat != null && goldWeight != null) {
      double purity = getGoldPurity(selectedGoldkarat!);
      pureGoldWeight = goldWeight! * purity;
      goldenzakatAmount = pureGoldWeight! * 0.025; // 2.5% Zakat
    } else {
      goldenzakatAmount = null; // Reset zakat amount if inputs are invalid
      pureGoldWeight = null; // Reset pure gold weight if inputs are invalid
    }
  }



 /************************************************************************************************/
  /************************************************************************************************/

  // Function to generate a unique key for each container
  Key generateContainerKey() {
    keyCount++;
    return Key('container_$keyCount');
  }

  /************************************************************************************************/
  /************************************************************************************************/
   // Function to delete the container
  void _deleteContainer(Key containerKey) {
    showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "تأكيد الحذف",
            textAlign: TextAlign.right,
          ),
          content: Text(
            "هل أنت متأكد من حذف زكاة المال؟",
            textAlign: TextAlign.right,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text("تراجع"),
            ),
            TextButton(
              onPressed: () {
                // Find the index of the container with the given key
                int index = additionalContainers.indexWhere((widget) => widget.key == containerKey);
                if (index != -1) {
                  setState(() {
                    // Remove the container at the found index
                    additionalContainers.removeAt(index);
                  });
                }
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text("حذف"),
            ),
          ],
        );
      },
    );
  }
  /************************************************************************************************/
  /************************************************************************************************/
  // Function to edit the container
void _editContainer(int selectedContainerIndex) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      double? updatedAmountOfMoney = Amount_of_money;
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
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
                    "تعديل المال",
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
                            hintText: '0',
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
                            updatedAmountOfMoney = double.tryParse(value);
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
                      if (updatedAmountOfMoney != null) {
                        // Recalculate Zakat on money based on the updated amount
                        Zakat_on_money = updatedAmountOfMoney! / 40.0;
                        // Update the container with the new information
                        setState(() {
                          additionalContainers[selectedContainerIndex] = _buildContainer(
                            amountOfMoney: updatedAmountOfMoney!,
                            zakatOnMoney: Zakat_on_money!,
                            selectedCurrency: selectedCurrency,
                          );
                        });
                        Navigator.pop(context); // Close the bottom sheet
                      }
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
                        "حفظ التغييرات",
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
    },
  );
}
/****************************************************************************************************/
/***************************************************************************************************/
void editContainerMoney(double newAmountOfMoney, String newCurrency, Key containerKey) {
  // Find the container widget using the key
  Widget containerWidget = additionalContainers.firstWhere((widget) => widget.key == containerKey);
  
  // Update the content of the container
  Slidable container = containerWidget as Slidable;
  
  // Update the amount of money and currency in the container
  
    Amount_of_money = newAmountOfMoney;
    selectedCurrency = newCurrency;
    // Recalculate the zakat on money with the new values
     if (Amount_of_money != null) {
    Zakat_on_money = Amount_of_money! / 40.0;
      } else {
          Zakat_on_money = 0.0;
      }
  
}

  //function to build the contaner 
 Slidable _buildContainer({
  required double amountOfMoney,
  required double zakatOnMoney,
  required String selectedCurrency,
}) {
  Key containerKey = generateContainerKey(); // Generate a unique key for the container
  return Slidable(
    key: containerKey,
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    direction: Axis.horizontal,
    child: Container(
      height: 250.0,
      width: 400.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 219, 207, 214),
            Color.fromARGB(255, 238, 201, 220)!,
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50.0),
              Center(
                child: Container(
                  height: 150.0,
                  width: 190.0,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "مبلغ الزكاة",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '${zakatOnMoney.toStringAsFixed(2)} $selectedCurrency',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 90.0,
                width: 90.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 189, 173, 185),
                      Colors.purpleAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    "المال",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            width: 380, // Adjust the width as needed
            child: Divider(
              color: Colors.black,
              height: 2.0,
            ),
          ),
          SizedBox(width: 10),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${amountOfMoney.toStringAsFixed(2)} $selectedCurrency',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19.0,
                ),
              ),
              SizedBox(width: 20.0),
              Text(
                "المبلغ المدخل",
                style: TextStyle(
                  fontSize: 19.0,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'حذف',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          _deleteContainer(containerKey);
        },
      ),
      IconSlideAction(
        caption: 'تعديل',
        color: Colors.blue,
        icon: Icons.edit,
        onTap: () {
          int selectedContainerIndex = additionalContainers.indexWhere((widget) => widget.key == containerKey);
          _editContainer(selectedContainerIndex);
        },
      ),
    ],
  );
}

//function to build contaner for silver 
 Slidable _buildContainerForSilver({
  required double Silverweight,
  required double Zakatonsilver,
}) {
  Key containerKey = generateContainerKey(); // Generate a unique key for the container
  return Slidable(
    key: containerKey,
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    direction: Axis.horizontal,
    child: Container(
      height: 380.0,
      width: 400.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 219, 207, 214),
            Color.fromARGB(255, 238, 201, 220)!
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50.0),
              Center(
                child: Container(
                  height: 150.0,
                  width: 190.0,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "مبلغ الزكاة",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '${Zakatonsilver.toStringAsFixed(2)} ISL',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 90.0,
                width: 90.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 189, 173, 185),
                      Colors.purpleAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    "الفضة",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            width: 380, // Adjust the width as needed
            child: Divider(
              color: Colors.black,
              height: 2.0,
            ),
          ),
          SizedBox(width: 10),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                ' ${Silverweight.toStringAsFixed(2)} ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19.0,
                ),
              ),
              SizedBox(width: 20.0),
              Text(
                "وزن الفضة بالجرام",
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            width: 350,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 189, 173, 185),
                  Colors.purpleAccent,
                ],
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  ' ${Zakatonsilver.toStringAsFixed(2)} ',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 19.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  "سعر الفضة للجرام الواحد",
                  style: TextStyle(
                    fontSize: 19.0,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "نصاب زكاة الفضة 595 جرام من الفضة",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'حذف',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          _deleteContainer(containerKey);
        },
      ),
      IconSlideAction(
        caption: 'تعديل',
        color: Colors.blue,
        icon: Icons.edit,
        onTap: () {
          int selectedContainerIndex =
              additionalContainers.indexWhere((widget) => widget.key == containerKey);
          _editContainer(selectedContainerIndex);
        },
      ),
    ],
  );
}

// function to build golden contaner 
Slidable _buildContainerForgolden({
  required double goldenZakatAmount,
  required double goldWeight,
  required String selectedGoldkarat,
  required double puregoldWeight,
}) {
  Key containerKey = generateContainerKey(); // Generate a unique key for the container
  return Slidable(
    key: containerKey,
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    direction: Axis.horizontal,
    child: Container(
      height: 380.0,
      width: 400.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 219, 207, 214),
           Color.fromARGB(255, 238, 201, 220)!],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50.0,),
            Center(
  child: Container(
    height: 150.0,
    width: 190.0,
    padding: EdgeInsets.all(8.0),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "مبلغ الزكاة",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '${goldenZakatAmount.toStringAsFixed(2)} ISL',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ],
    ),
  ),
),
   Container(
                height: 90.0,
                width: 90.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 189, 173, 185),
                      Colors.purpleAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    "الذهب",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            
            ],
          ),
          SizedBox(height: 20.0),
          Container(
      width: 380, // Adjust the width as needed
      child: Divider(
        color: Colors.black,
        height: 2.0,
      ),
    ),
    SizedBox(width: 10),
    SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                ' ${goldWeight.toStringAsFixed(2)} ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19.0,
                ),
              ),
              SizedBox(width: 20.0),
              Text(
                "وزن الذهب المدخل بالجرام",
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.black87,
                ),
              ),
              
            ],

          ),
          SizedBox(height: 20.0),
          Container(
            width: 350,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 189, 173, 185),
                      Colors.purpleAccent,
                    ],
                  ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  ' ${puregoldWeight.toStringAsFixed(2)} ',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 19.0,
                  ),
                ),
                SizedBox(width: 20.0),
                Text(
                  " صافي وزن الذهب بالجرام  " ,
                  style: TextStyle(
                    fontSize: 19.0,
                    color:const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  "نصاب زكاة الذهب 85 جرام من صافي وزن الذهب",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Color.fromARGB(255, 128, 60, 111),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'حذف',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          _deleteContainer(containerKey);
        },
      ),
      IconSlideAction(
        caption: 'تعديل',
        color: Colors.blue,
        icon: Icons.edit,
        onTap: () {
          int selectedContainerIndex = additionalContainers.indexWhere((widget) => widget.key == containerKey);
          _editContainer(selectedContainerIndex);
        },
      ),
    ],
  );
}



/*Widget _buildSlidableContainer() {
  return Slidable(
    key: Key('container_$containerCount'),
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    direction: Axis.horizontal,
    child: Container(
      height: 220.0,
      width: 400.0,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 150.0,
                  width: 190.0,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 40.0,
                        child: Text(
                          "مبلغ الزكاة",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        height: 60.0,
                        child: Text(
                          '${Zakat_on_money!.toStringAsFixed(2)} $selectedCurrency',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 90.0,
                  width: 90.0,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 189, 173, 185),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    "المال",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${Amount_of_money!.toStringAsFixed(2)}  $selectedCurrency',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19.0,
                  ),
                ),
                SizedBox(width: 20.0),
                Text(
                  "المبلغ المدخل",
                  style: TextStyle(
                    fontSize: 19.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'حذف',
        color: Colors.transparent,
        icon: Icons.delete,
        onTap: () {
          showDialog(
            context: _scaffoldKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "تأكيد الحذف",
                  textAlign: TextAlign.right,
                ),
                content: Text(
                  "هل أنت متأكد من حذف زكاة المال؟",
                  textAlign: TextAlign.right,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Dismiss the dialog
                    },
                    child: Text("تراجع"),
                  ),
                  TextButton(
                    onPressed: () {
                      // Find the index of the container with the given key
                      int index = additionalContainers.indexWhere((widget) => widget.key == Key('container_$containerCount'));
                      if (index != -1) {
                        setState(() {
                          // Remove the container at the found index
                          additionalContainers.removeAt(index);
                        });
                      }
                      Navigator.of(context).pop(); // Dismiss the dialog
                    },
                    child: Text("حذف"),
                  ),
                ],
              );
            },
          );
        },
      ),
      IconSlideAction(
        caption: 'تعديل',
        color: Colors.transparent,
        icon: Icons.archive,
        onTap: () {
          int selectedContainerIndex = additionalContainers.indexWhere((widget) => widget.key == Key('container_$containerCount'));
          _editContainer(selectedContainerIndex);
        },
      ),
    ],
  );
}
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 113, 224),
        elevation: 0.0,
        title: Text('حاسبة الزكاة'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
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
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>zakat()),
                    );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 8.0),
                    /*****************************************************************************/
                    /*****************************************************************************/
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 50.0,
                        width: 130.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                backgroundColor: Color.fromARGB(179, 190, 120, 167),
                                radius: 20,
                                child: Icon(
                                  Icons.add,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "  المال",
                                style: TextStyle(color: Colors.black, fontSize: 25.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Show the floating page when the container is tapped
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
                                      "المال",
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
                                              hintText: '0',
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
                                              Amount_of_money = double.tryParse(value);
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
                                        if (Amount_of_money != null) {
                                          Zakat_on_money = Amount_of_money! / 40.0;
                                        } else {
                                          Zakat_on_money = 0.0;
                                        }
                                      setState(() {
                                        additionalContainers.add(
                                          _buildContainer(
                                            amountOfMoney: Amount_of_money!,
                                            zakatOnMoney: Zakat_on_money!,
                                            selectedCurrency: selectedCurrency,
                                          ),
                                        );
                                      });
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
                      },
                    ),
                    SizedBox(width: 8.0),
                    
                    /*****************************************************************************/
                    /*****************************************************************************/
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 50.0,
                        width: 130.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                backgroundColor: Color.fromARGB(179, 190, 120, 167),
                                radius: 20,
                                child: Icon(
                                  Icons.add,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " الفضة",
                                style: TextStyle(color: Colors.black, fontSize: 25.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Show the floating page when the container is tapped
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
                                      "الفضة",
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
                                            "وزن الفضة بالجرام",
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
                                              hintText: '0',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                             
                                              ),
                                            onChanged: (value) {
                                              Silver_weight = double.tryParse(value);
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
                                        if (Silver_weight != null) {
                                          Zakat_on_silver = (Silver_weight! * Price_of_a_gram_of_silver!) * 0.025;
                                        } else {
                                          Zakat_on_silver = 0.0;
                                        }

                                      setState(() {
                                        additionalContainers.add(
                                          _buildContainerForSilver(
                                            Silverweight: Silver_weight!,
                                            Zakatonsilver: Zakat_on_silver!,
                                           
                                          ),
                                        );
                                      });
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
                      },
                    ),
                    SizedBox(width: 8.0),
                    /********************************************************************************/
                    /*******************************************************************************/
                  
                    GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8),
        height: 50.0,
        width: 130.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(179, 190, 120, 167),
                radius: 20,
                child: Icon(
                  Icons.add,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                " الذهب",
                style: TextStyle(color: Colors.black, fontSize: 25.0),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // Show the floating page when the container is tapped
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            // This is the content of the floating page
            return Container(
              height: MediaQuery.of(context).size.height * 0.8, // Use 80% of the screen height
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
                      "الذهب",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(183, 77, 29, 57),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 300.0, // Adjusted to fit the new elements
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
                            "العيار",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(183, 77, 29, 57),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          height: 60.0,
                          width: 300,
                          child: DropdownButtonFormField<String>(
                            value: selectedGoldkarat,
                            items: Goldkarat.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, textAlign: TextAlign.right),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGoldkarat = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: 'اختر العيار',
                              hintTextDirection: TextDirection.rtl,
                            ),
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.all(15.0),
                          height: 60.0,
                          child: Text(
                            "وزن الذهب",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(183, 77, 29, 57),
                            ),
                          ),
                        ),
                        Container(
                          height: 60.0,
                          width: 300,
                          child: TextField(
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.rtl,
                              hintText: '0',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onChanged: (value) {
                              goldWeight = double.tryParse(value);
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
                        setState(() {
                          calculateZakat();
                         
                           additionalContainers.add(
                                          _buildContainerForgolden(
                                            goldenZakatAmount: goldenzakatAmount!,
                                            goldWeight: goldWeight!,
                                            selectedGoldkarat : selectedGoldkarat,
                                            puregoldWeight: pureGoldWeight!,

                                          ),
                                        );
                        });
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
      },
    ),
    SizedBox(width: 8.0),
                    // Add other GestureDetector widgets here
                  ],
                ),
              ),
            ),
            
            Column(
  children: <Widget>[
    for (int i = 0; i < additionalContainers.length; i++)
      Column(
        children: <Widget>[
          additionalContainers[i],
          SizedBox(height: 20.0), // Adjust the height as needed
        ],
      ),
  ],
),

          
          
          ],
        ),
      ),
    );
  }
}
