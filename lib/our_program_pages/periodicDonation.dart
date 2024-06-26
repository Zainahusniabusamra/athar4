import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/our_program_pages/AppointmentBooking.dart';
import 'package:flutter_application_athar_project/our_program_pages/My_appointments.dart';
import 'package:flutter_application_athar_project/module/Pramjona_module.dart';
import 'package:flutter_application_athar_project/our_program_pages/prnamjona.dart';

class periodicDonation extends StatefulWidget {
  const periodicDonation ({super.key});

  @override
  State<periodicDonation > createState() => _periodicDonationState();
}

class _periodicDonationState extends State<periodicDonation > {
   static List<pramijonaModule> periodic_donation_list=[
pramijonaModule(" حجز موعد ","اطلع على احتياجات بنوك الدم لحجز موعدك",Icons.calendar_month_outlined,),
pramijonaModule(" مواعيدي","مواعيد التبرع بالدم التي قمت بحجزها",Icons.calendar_month_outlined,),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 113, 224),
        elevation: 0.0,
         title: Text('التبرع بالدم'),
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
                          'التبرع بالدم', 
                           
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 208, 113, 224),
                          ),
                        ),
                        SizedBox(height: 10), // Add some space between title and body text
                        Text(
                           textAlign: TextAlign.right,
                          'تتيح لك منصة أثر الفرصة لانقاذ حياة من خلال تبرعك بالدم', // Your body text here
                          style: TextStyle(
                            fontSize: 18,
                            color:const Color.fromARGB(255, 208, 113, 224),
                          ),
                        ),
                        SizedBox(height: 20), // Add some space between search box and list
      Expanded(
        child: ListView.builder(
          
          itemCount: periodic_donation_list.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
             margin: EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.white,
                        shadowColor: const Color.fromARGB(255, 208, 113, 224),
                        surfaceTintColor: Colors.white,
              child: ListTile(
                title: Text(periodic_donation_list[index].prnamigonaTitle!,
                textAlign: TextAlign.right,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 208, 113, 224),
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                            ),
                            subtitle: Text(
                            periodic_donation_list[index].prnamijonaDiscription!,
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
                                periodic_donation_list[index].icon,
                                color: const Color.fromARGB(255, 208, 113, 224),
                              ),
                              onPressed: () {
                                switch (index) {
                              case 0:
                                // Navigate to CartPage for "الهدية"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AppointmentBooking()),
                                );
                                break;
                              
                              case 1:
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => My_appointments()),
                                  );
                                break;
                                default :
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => periodicDonation()),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AppointmentBooking()),
                                );
                                break;
                              
                               case 1:
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => My_appointments()),
                                  );
                                break;
                                default :
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => periodicDonation()),
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