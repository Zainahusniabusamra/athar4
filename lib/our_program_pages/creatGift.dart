import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_athar_project/our_program_pages/Details_of_the_recipient.dart';
import 'package:flutter_application_athar_project/our_program_pages/GiftPage.dart';
import 'package:flutter_application_athar_project/module/Gift_Type_module.dart';
import 'package:flutter_application_athar_project/module/card_format_module.dart';
import 'package:flutter_application_athar_project/module/donation_field_module.dart';

class creatGift extends StatefulWidget {
  const creatGift({Key? key}) : super(key: key);

  @override
  State<creatGift> createState() => _creatGiftState();
}

class _creatGiftState extends State<creatGift> {
  static List<GiftTypeModule> Gift_Type_list = [
    GiftTypeModule("عيد الفطر", Icons.circle, imagePath: 'images/balloon.jpg'),
    GiftTypeModule("الشفاء", Icons.circle, imagePath: 'images/flowers.jpg'),
    GiftTypeModule("العمل", Icons.circle, imagePath: 'images/work.jpg'),
    GiftTypeModule("الوالدين", Icons.circle, imagePath: 'images/parent.jpg'),
    GiftTypeModule("مواليد", Icons.circle, imagePath: 'images/baby.jpg'),
    GiftTypeModule("التخرج", Icons.circle, imagePath: 'images/graduation.jpg'),
    GiftTypeModule("الزواج", Icons.circle, imagePath: 'images/marriage.jpg'),
    GiftTypeModule("نجاح", Icons.circle, imagePath: 'images/success.jpg'),
    GiftTypeModule("عام", Icons.circle, imagePath: 'images/gift1.jpg'),
  ];

  static List<card_format_module> eadCard = [
    card_format_module(
      "الى",
      "كل عام وأنتم بخير",
      "لتكتمل فرحة ومسرة العيد، فقد تبرعت عنك عبر منصة أثر",
      "من",
      "تقبل الله منا ومنكم الصيام والقيام",
      Icons.circle,
      imagePath: 'images/balloonedit.png',
    ),
  ];
    static List<card_format_module> giftCard =[
       card_format_module("الى", "اهداء",
        " محبة لك وإحسانا إليك، فقد تبرعت عنك عبر منصة أثر", "من", "أسأل الله أن يضاعف الأجر",
        Icons.circle,
        imagePath: 'images/gift1edit.png', ),

  ];
  static List<card_format_module> successCard =[
       card_format_module("الى", "مبارك النجاح",
        "بشرى نجاحك زادتني بهجة وسرورا ولتكتمل فرحتي بك فقد تبرعت عنك عبر منصة أثر ",
         "من", "(بارك الله في علمك ونفع به)",
         Icons.circle,
         imagePath: 'images/successedit.png', ),

  ];
  static List<card_format_module> marriageCard =[
       card_format_module("الى", "مبارك لكما", 
       "اتماما للفرحة وتعبيرا عن المحبة، فقد تبرعت عنكما عبر منصة أثر", "من", "جمع الله بينكما في خير",
       Icons.circle,
       imagePath: 'images/marriageedit.png', ),

  ];
   static List<card_format_module> graduationCard =[
       card_format_module("الى", " مبارك التخرج", 
       "خير الهدايا أدومها وأنفعها، وتعبيرا عن فرحتي بتخرجك فقد تبرعت عنك عبر منصة أثر", 
       "من", "نفع الله بعلمك وعلمك",
       Icons.circle,
       imagePath: 'images/graduationedit.png', ),

  ];
   static List<card_format_module> babyCard =[
       card_format_module("الى",
        " بوركتم الموهوب", "مع بهحة قدوم المولود، هديتي لك من نوع اخر فقد تبرعت عنه عبر منصة أثر",
         "من", "أسأل الله أن ينبته نباتا حسنا",
         Icons.circle,
         imagePath: 'images/babyedit.png', ),

  ];
   static List<card_format_module> parentCard =[
       card_format_module("الى", 
       " أبي، مثلي الأعلى", 
       "لأنك رمز للعطاء والمحبة، ورضاك أجر وجنة فقد تبرعت عنك عبر منصة أثر", 
       "من", "رزقك الله الصحة وحسن العمل",
       Icons.circle,
       imagePath: 'images/parentedit.png', ),

       card_format_module("الى", 
       " أمي، باب الجنة", 
       "لأن قلبك مسكني ورضاك غايتي، فقد تبرعت عنك عبر منصة أثر", 
       "من", "رزقك الله الصحة وحسن العمل",
       Icons.circle,
       imagePath: 'images/parentedit.png', ),

  ];
   
   static List<card_format_module> workCard =[
       card_format_module("الى",
        " شكراً لجهودك", "تقديرا لإنجازاتك ونجاحاتك المهنية، وردا للجميل الذي صنعته فقد تبرعت عنك عبر منصة أثر",
         "من", "بوركت جهودك",
         Icons.circle,
         imagePath: 'images/workedit.png', ),

  ];
  static List<card_format_module> flowersCard =[
       card_format_module("الى",
        "أجر وعافية" , "بالتفاؤل والدعاء وأملا بالشفاء، فقد تبرعت عنمك عبر منصة أثر",
         "من", "أسأل الله أن يلبسك ثوب العافية",
         Icons.circle,
         imagePath: 'images/floweredit.png', ),

  ];
  static List<donation_field_module> donation_field_list =[
       donation_field_module("رعاية الأيتام",
       
         imagePath: 'images/floweredit.png', ),
         donation_field_module("سقيا الماء",
       
         imagePath: 'images/floweredit.png', ),
         donation_field_module("الرعاية الصحية",
       
         imagePath: 'images/floweredit.png', ),
         donation_field_module(" اعانة المعسرين",
       
         imagePath: 'images/floweredit.png', ),
  ];
   List<card_format_module>? selectedCardFormats;

  // Define a variable to store the selected gift type
  GiftTypeModule? selectedGiftType;
  donation_field_module ? selectedDonationField;

  // Modify the buildCardFormatList method to use selectedCardFormats
Widget buildCardFormatList() {
  if (selectedCardFormats == null) {
    return SizedBox(); // If no card formats are selected, return an empty SizedBox
  }
   
  return ListView(
  scrollDirection: Axis.horizontal,
  shrinkWrap: true,
  physics: ClampingScrollPhysics(),
  children: List.generate(selectedCardFormats!.length, (index) {
    final cardFormat = selectedCardFormats![index];
    bool isSelected = cardFormat.isSelected ?? false; // Check if the card is selected

    return Padding(
      padding: const EdgeInsets.only(top: 8.0), // Add padding from the top
      child: GestureDetector(
        onTap: () {
      setState(() {
              // Unselect all cards first
              selectedCardFormats!.forEach((card) {
                card.isSelected = false;
              });

              // Select the tapped card
              cardFormat.isSelected = true;
            });
        },
        child: Container(
          width: 200,
          height: 380,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ?  Color.fromARGB(255, 159, 76, 173): Colors.transparent, // Set border color based on selected state
              width: isSelected ? 3.0 : 0.0, // Set border width based on selected state
            ),
             borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              Card(
                elevation: 3,
                color: Color.fromARGB(255, 255, 255, 255), // Set background color of the card
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Text(
                      cardFormat.giftTo!,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          cardFormat.cardTitle!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 146, 65, 160),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        cardFormat.messageContent!,
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            cardFormat.giftFrom!,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          cardFormat.messageContent2!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 146, 65, 160),
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 4, // Adjust the position as needed
                bottom: 4, // Adjust the position as needed
                child: Image.asset(
                  cardFormat.imagePath!,
                  width: 160, // Adjust the width of the image
                  height: 110, // Adjust the height of the image
                ),
              ),
              Positioned(
                                top: 8,
                                left: 8,
                                child: Icon(
                                  cardFormat.isSelected!
                                      ? Icons.done 
                                      : cardFormat.icon,
                                  color:  Colors.white,
                                  size: 24.0,
                                ),
                              ),
            ],
          ),
        ),
      ),
    );
  }),
);


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 113, 224),
        elevation: 0.0,
        title: Text(' انشاء هدية'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GiftPage()),
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
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Text(
                'حدد نوع الهدية',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 208, 113, 224),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 220.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  children: Gift_Type_list.map((giftType) {
                    return GestureDetector(
                      onTap: () {
                      setState(() {
  // Deselect all other items
  for (var item in Gift_Type_list) {
    item.isSelected = false;
  }
  // Select the tapped item
  selectedGiftType = giftType;
  giftType.isSelected = true;
  // Update the selected card formats based on the selected gift type
  
  selectedCardFormats = getCardFormatsForGiftType(giftType);
});
                      },
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                              color: giftType.isSelected!
                                  ? Color.fromARGB(255, 159, 76, 173)
                                  : Colors.transparent,
                              width: 3.5,
                            ),
                          ),
                          color: Colors.white,
                          shadowColor: const Color.fromARGB(255, 208, 113, 224),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  giftType.imagePath!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: giftType.isSelected!
                                        ? Color.fromARGB(255, 159, 76, 173)
                                            .withOpacity(0.9)
                                        : Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(0.0),
                                    ),
                                  ),
                                  child: Text(
                                    giftType.GiftType!,
                                    style: TextStyle(
                                      color: giftType.isSelected!
                                          ? Colors.white
                                          : Color.fromARGB(255, 159, 76, 173),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Icon(
                                  giftType.isSelected!
                                      ? Icons.done
                                      : giftType.icon,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Text(
                'اختر شكل البطاقة',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 208, 113, 224),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 400.0,
              
             child: buildCardFormatList(), // Display the chosen card section
             
            ),
             const Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Text(
                'اختر مجال التبرع',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 208, 113, 224),
                ),
              ),
            ),
            const SizedBox(height: 10),
          Container(
   height: 100.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  children: donation_field_list.map((donationfield) {
                    return GestureDetector(
                      onTap: () {
                      setState(() {
                      // Deselect all other items
                      for (var item in donation_field_list) {
                        item.isSelected = false;
                      }
                      // Select the tapped item
                      selectedDonationField = donationfield;
                      donationfield.isSelected = true;
  
  });
                      },
                      child: SizedBox(
                        width: 150,
                        height: 80,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                              color: donationfield.isSelected!
                                  ? Color.fromARGB(255, 159, 76, 173)
                                  : Colors.transparent,
                              width: 3.5,
                            ),
                          ),
                          color: Colors.white,
                          shadowColor: const Color.fromARGB(255, 208, 113, 224),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  donationfield.imagePath!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 15,
                                right: 12,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: donationfield.isSelected!
                                        ? Color.fromARGB(255, 159, 76, 173)
                                            .withOpacity(0.9)
                                        : Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(0.0),
                                    ),
                                  ),
                                  child: Text(
                                    donationfield.donationField!,
                                    style: TextStyle(
                                      color: donationfield.isSelected!
                                          ? Colors.white
                                          : Color.fromARGB(255, 159, 76, 173),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
),


          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
       onPressed: () {
    // Navigate to the new page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Details_of_the_recipient()), // Replace YourNextPage with the name of your next page
    );
  },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
           
            SizedBox(), // This is the space for the FloatingActionButton
           Expanded(
        child: Container(
          color: Color.fromARGB(255, 146, 65, 160),
          alignment: Alignment.center,
          child: Text(
            "ادخال بيانات المهدى اليه",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
          ],
        ),
      ),
    
    );
  }
  // Helper function to get the list of card formats based on the selected gift type
List<card_format_module>? getCardFormatsForGiftType(GiftTypeModule selectedGiftType) {
  switch (selectedGiftType.GiftType) {
    case "عيد الفطر":
     selectedCardFormats = eadCard;
      return eadCard;
    case "الشفاء":
     selectedCardFormats = flowersCard;
      return flowersCard;
    case "العمل":
     selectedCardFormats = workCard;
      return workCard;
    case "الوالدين":
     selectedCardFormats = parentCard;
      return parentCard;
    case "مواليد":
     selectedCardFormats = babyCard;
      return babyCard;
    case "التخرج":
     selectedCardFormats = graduationCard;
      return graduationCard;
    case "الزواج":
     selectedCardFormats = marriageCard;
      return marriageCard;
    case "نجاح":
     selectedCardFormats = successCard;
      return successCard;
    case "عام":
     selectedCardFormats = giftCard;
      return giftCard;
    default:
      return null;
  }
  
}
}
