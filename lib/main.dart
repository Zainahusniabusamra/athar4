import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_athar_project/api/firebase_api.dart';
import 'package:flutter_application_athar_project/pages/custom_bottom_navbar.dart';
import 'package:flutter_application_athar_project/firebase_options.dart';
import 'package:flutter_application_athar_project/pages/notificationPage.dart';
import 'package:flutter_application_athar_project/admin_pages/custom_bottom_navbar_admin.dart';
import 'package:flutter_application_athar_project/admin_star/custom_navbar_admin2.dart';
import 'package:flutter_application_athar_project/donor_pages/custom_bottom_navbar_donor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_athar_project/pages/basket_module.dart';
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initializeNotifications();

  // Get FCM token
  String? token = await FirebaseMessaging.instance.getToken();




WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Received message: ${message.notification?.title}");
    // Handle foreground notification here
  });

  runApp(
    ChangeNotifierProvider(
      create: (context) => ShoppingBasket(),
      child: MyApp(token: token),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String email = 'zainaabusamra3';
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
//       //home: custom_bottom_navbar_admin(email: email),

       home:const CustomBottomNavbar(),
//       // home:const CustomBottomNavbardonor(email: email),
     // home: custom_bottom_navbar_admin2(email: email, ),
           //home: Authenticate(),

      navigatorKey: navigatorKey,
      routes: {
        '/notifications_screen': (context) => const NotificationPage(),
      },
    );
  }
}






















































// import 'package:flutter/material.dart';
// import 'package:flutter_application_athar_project/api/firebase_api.dart';
// import 'package:flutter_application_athar_project/pages/custom_bottom_navbar.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_application_athar_project/firebase_options.dart';
// import 'package:flutter_application_athar_project/pages/notificationPage.dart';
// import 'package:flutter_application_athar_project/admin_pages/custom_bottom_navbar_admin.dart';
// import 'package:flutter_application_athar_project/admin_star/custom_navbar_admin2.dart';

// import 'package:flutter_application_athar_project/donor_pages/custom_bottom_navbar_donor.dart';

// import 'package:provider/provider.dart';
// import 'package:flutter_application_athar_project/pages/basket_module.dart'; // Import the ShoppingBasket model

// final navigatorKey = GlobalKey<NavigatorState>();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await FirebaseApi().initializeNotifications();
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ShoppingBasket(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const String email = 'zainaabusamra3';
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       //home: custom_bottom_navbar_admin(email: email),
//             home: custom_bottom_navbar_admin2(email: email),

//        //home:const CustomBottomNavbar(),
//       // home:const CustomBottomNavbardonor(email: email),
//       navigatorKey: navigatorKey,
//       routes: {
//         '/notifications_screen': (context) => const NotificationPage(),
//       },
//     );
//   }
// }



