import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/admin_pages/messages_Page.dart'; 




class MessageDetailsPage extends StatefulWidget {
  final Message message;

  MessageDetailsPage({required this.message});

  @override
  _MessageDetailsPageState createState() => _MessageDetailsPageState();
}

class _MessageDetailsPageState extends State<MessageDetailsPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.add(widget.message); // Initialize with the passed message
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(Message(
          sender: 'أنا', // Adjust as necessary
          content: _controller.text,
          timestamp: TimeOfDay.now().format(context),
        ));
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'تفاصيل الرسالة',
          style: TextStyle(fontFamily: 'ElMessiri', color: Color.fromARGB(255, 245, 245, 245)),
        ),
        backgroundColor: Color.fromARGB(255, 2, 2, 88),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatBubble(message: message);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'اكتب ردك هنا...',
                        hintStyle: TextStyle(fontFamily: 'ElMessiri'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 2, 2, 88),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: Text(
                      'إرسال',
                      style: TextStyle(fontFamily: 'ElMessiri', color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    bool isMe = message.sender == 'أنا'; // Adjust as necessary
    return Align(
      alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Card(
        color: isMe ?  Color.fromARGB(255, 2, 2, 88) : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.sender,
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                message.content,
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 16.0,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                message.timestamp,
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 12.0,
                  color: isMe ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}












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

