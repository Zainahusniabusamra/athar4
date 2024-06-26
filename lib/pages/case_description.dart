import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/pages/click.dart';
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';

class CaseDescription extends StatefulWidget {
  final dynamic project;

  const CaseDescription({Key? key, required this.project}) : super(key: key);

  @override
  State<CaseDescription> createState() => _CaseDescriptionState();
}

class _CaseDescriptionState extends State<CaseDescription> {
  late List<int>? imageData;

  @override
  void initState() {
    super.initState();
    imageData = widget.project['assetPath'] != null
        ? (widget.project['assetPath']['data'] as List<dynamic>).cast<int>()
        : null;
  }

  @override
  Widget build(BuildContext context) {
    double donationProgress = 0.0;
    if (widget.project['donation_target'] != null && widget.project['current_donation'] != null) {
      double target = (widget.project['donation_target'] as int).toDouble();
      double current = (widget.project['current_donation'] as int).toDouble();
      donationProgress = current / target;
    }

    return Scaffold(
      backgroundColor:const  Color.fromARGB(248, 255, 255, 255),
      
      appBar: AppBar(
       backgroundColor: const Color.fromARGB(248, 255, 255, 255),
        title:const Text(
          'وصف الحالة',
          style: TextStyle(
            fontFamily: 'ElMessiri',
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding:const EdgeInsetsDirectional.only(start: 16, end: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(8.0),
                  image: DecorationImage(
                    image: MemoryImage(Uint8List.fromList(imageData!)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
             const Text(
                'تفاصيل المشروع',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                ),
              ),
             const  SizedBox(height: 16),
              Container(
                padding:const EdgeInsetsDirectional.only(start: 16, end: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 236, 233, 233),
                  borderRadius: BorderRadiusDirectional.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset:const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const Text(
                      'الوصف:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.project['description'] ?? '',
                      style:const TextStyle(
                        fontSize: 16,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                   const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'الهدف:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                        Text(
                          '${widget.project['donation_target']}',
                          style:const TextStyle(
                            fontSize: 18,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: donationProgress,
                      backgroundColor: Colors.grey,
                      valueColor:const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 2, 2, 88)),
                    ),
                   const SizedBox(height: 16),
                    const Text(
                      'التبرع الحالي:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                   const  SizedBox(height: 8),
                    Text(
                      '${widget.project['current_donation']}',
                      style:const TextStyle(
                        fontSize: 18,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                   const SizedBox(height: 16),
                    const Text(
                      'عدد التبرعات:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${widget.project['num_of_donations']}',
                      style:const TextStyle(
                        fontSize: 18,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        // await canLaunch('${widget.project['link']}')
                        //     ? await launch('${widget.project['link']}')
                        //     : print('Cannot open the URL');


                         showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DonationBottomSheet();
                                        },
                                      );
                      },
                      child: Text(
                        'تبرع الآن',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 2, 2, 88),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



