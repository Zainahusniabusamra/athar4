

import 'package:flutter/material.dart';
import 'package:flutter_application_athar_project/pages/home_page.dart';
import 'package:flutter_application_athar_project/pages/our_program_page.dart';
import 'package:flutter_application_athar_project/admin_pages/donate_page_admin.dart';
import 'package:flutter_application_athar_project/donor_pages/profile_page_donor.dart';


class CustomBottomNavbardonor extends StatefulWidget {
  final String? email;
  const CustomBottomNavbardonor({Key? key, required this.email}) : super(key: key);

  @override
  State<CustomBottomNavbardonor> createState() => CustomBottomNavbardonorState();
}

class CustomBottomNavbardonorState extends State<CustomBottomNavbardonor> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late List<Widget> widgetBuilder;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    widgetBuilder = [
      DonorProfilePage(email: widget.email),
      adminPage(),
      ourProgramPage(),
      homePage(),
    ];
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    _animationController.forward(from: 0.0);
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          color: Colors.white,
          child:const Center(
            child: Text('This is a bottom sheet'),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetBuilder[selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white, 
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset:const Offset(0, 3),
            ),
          ],
          borderRadius:const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              icon: Icons.person,
              label: 'حسابي',
              isSelected: selectedIndex == 0,
              onTap: () => onItemTapped(0),
            ),
            BottomNavItem(
              icon: Icons.widgets_rounded,
              label: 'فرصة تبرع',
              isSelected: selectedIndex == 1,
              onTap: () => onItemTapped(1),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient:const LinearGradient(
                  colors: [
                    Color(0xFF005C97),
                    Color.fromARGB(255, 2, 2, 88),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset:const Offset(0, 3),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: _openBottomSheet,
                child:const Center(
                  child: Text(
                    'التبرع السريع',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo', // Example of using a custom Arabic font (replace with your preferred font)
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            BottomNavItem(
              icon: Icons.volunteer_activism_rounded,
              label: 'برنامجنا',
              isSelected: selectedIndex == 2,
              onTap: () => onItemTapped(2),
            ),
            BottomNavItem(
              icon: Icons.home,
              label: 'الرئيسية',
              isSelected: selectedIndex == 3,
              onTap: () => onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ?const Color.fromARGB(255, 2, 2, 88) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat',
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ?const Color.fromARGB(255, 2, 2, 88) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}


