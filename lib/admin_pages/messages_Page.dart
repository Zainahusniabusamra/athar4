import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/admin_pages/MessageDetailsPage.dart';

class CommunicationToolsPage extends StatelessWidget {
  final List<Message> messages = [
    Message(sender: 'أليس', content: 'مرحبا!', timestamp: '12:30 PM'),
    Message(sender: 'بوب', content: 'كيف حالك؟', timestamp: '12:45 PM'),
    Message(sender: 'تشارلي', content: 'انظر إلى هذا!', timestamp: '1:00 PM'),
    Message(sender: 'ديفيد', content: 'صباح الخير!', timestamp: '9:00 AM'),
    Message(sender: 'إيما', content: 'أراك لاحقًا!', timestamp: '10:15 AM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'أدوات الاتصال',
          style: TextStyle(fontFamily: 'ElMessiri', color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 2, 2, 88),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: messages.map((message) => MessageCard(message: message)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class Message {
  final String sender;
  final String content;
  final String timestamp;

  Message({required this.sender, required this.content, required this.timestamp});
}

class MessageCard extends StatelessWidget {
  final Message message;

  MessageCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageDetailsPage(message: message)),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16.0),
        elevation: 4.0,
        color: Color.fromARGB(255, 236, 233, 233),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Color.fromARGB(255, 2, 2, 88),
                    child: Text(
                      message.sender[0].toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    message.sender,
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 2, 2, 88),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                message.content,
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  color: Color.fromARGB(255, 2, 2, 88),
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                message.timestamp,
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










// import 'package:flutter/material.dart';


// import 'package:flutter_application_athar_project/admin_pages/MessageDetailsPage.dart'; 
// class CommunicationToolsPage extends StatelessWidget {
//   final List<Message> messages = [
//     Message(sender: 'أليس', content: 'مرحبا!', timestamp: '12:30 PM'),
//     Message(sender: 'بوب', content: 'كيف حالك؟', timestamp: '12:45 PM'),
//     Message(sender: 'تشارلي', content: 'انظر إلى هذا!', timestamp: '1:00 PM'),
//     Message(sender: 'ديفيد', content: 'صباح الخير!', timestamp: '9:00 AM'),
//     Message(sender: 'إيما', content: 'أراك لاحقًا!', timestamp: '10:15 AM'),
//   ];

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//         backgroundColor: Color.fromARGB(248, 255, 255, 255),
//       appBar: AppBar(
//         title: Text(
//           'أدوات الاتصال',
//           style: TextStyle(fontFamily: 'ElMessiri',color: Colors.white),
//         ),
//         backgroundColor: Color.fromARGB(255, 2, 2, 88),
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: messages.map((message) => MessageCard(message: message)).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Message {
//   final String sender;
//   final String content;
//   final String timestamp;

//   Message({required this.sender, required this.content, required this.timestamp});
// }

// class MessageCard extends StatelessWidget {
//   final Message message;

//   MessageCard({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Handle the card tap, e.g., navigate to message details
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MessageDetailsPage(message: message)),
//         );
//       },
//       child: Card(
//         margin: EdgeInsets.only(bottom: 16.0),
//         elevation: 4.0,
//         color:  const Color.fromARGB(255, 236, 233, 233),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20.0,
//                     backgroundColor: Color.fromARGB(255, 2, 2, 88),
//                     child: Text(
//                       message.sender[0].toUpperCase(),
//                       style: TextStyle(
//                         fontFamily: 'ElMessiri',
//                         fontSize: 18.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Text(
//                     message.sender,
//                     style: TextStyle(
//                       fontFamily: 'ElMessiri',
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 2, 2, 88),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 message.content,
//                 style: TextStyle(
//                   fontFamily: 'ElMessiri',
//                   color: Color.fromARGB(255, 2, 2, 88),
//                   fontSize: 16.0,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 message.timestamp,
//                 style: TextStyle(
//                   fontFamily: 'ElMessiri',
//                   fontSize: 14.0,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// }




// class MessageDetailsPage extends StatelessWidget {
//    final Message message;

//   MessageDetailsPage({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'تفاصيل الرسالة',
//           style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 245, 245, 245)),
//         ),
//         backgroundColor: Color.fromARGB(255, 2, 2, 88),
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20.0,
//                     backgroundColor: Color.fromARGB(255, 2, 2, 88),
//                     child: Text(
//                       message.sender[0].toUpperCase(),
//                       style:const TextStyle(
//                         fontFamily: 'ElMessiri',
//                         fontSize: 18.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Text(
//                     'مرسل الرسالة: ${message.sender}',
//                     style:const TextStyle(
//                       fontFamily: 'ElMessiri',
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 2, 2, 88),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               const Text(
//                 'محتوى الرسالة:',
//                 style: TextStyle(
//                   fontFamily: 'ElMessiri',
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(255, 2, 2, 88),
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 message.content,
//                 style:const TextStyle(
//                   fontFamily: 'ElMessiri',
//                   fontSize: 16.0,
//                   color: Color.fromARGB(255, 2, 2, 88),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'الوقت: ${message.timestamp}',
//                 style:const TextStyle(
//                   fontFamily: 'ElMessiri',
//                   fontSize: 14.0,
//                   color: Colors.grey,
//                 ),
//               ),
//               SizedBox(height: 32.0),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'اكتب ردك هنا...',
//                   hintStyle: TextStyle(fontFamily: 'ElMessiri'),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16.0),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle the reply action
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromARGB(255, 2, 2, 88),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16.0),
//                   ),
//                 ),
//                 child:const Text(
//                   'إرسال',
//                   style: TextStyle(fontFamily: 'ElMessiri', color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

