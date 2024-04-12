import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

// Import your screen classes (replace with actual implementations)
import 'home_screen.dart'; // Assuming you have a home_screen.dart file
import 'add_course_screen.dart'; // Assuming you have an add_course_screen.dart file
import 'logout_screen.dart'; // Assuming you have a logout_screen.dart file

class ControllerScreen extends StatefulWidget {
  const ControllerScreen({Key? key}) : super(key: key);

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const AddCourseScreen(),
    const LogoutScreen(),
  ];

  int _selectedIndex = 0; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 221, 51),
      body: Row(
        children: [
          SideNavigationBar(
            expandable: true,
            initiallyExpanded: false,

            theme: SideNavigationBarTheme(
              itemTheme: SideNavigationBarItemTheme(
                  selectedItemColor: Color.fromARGB(255, 40, 226, 46),
                  selectedBackgroundColor: Colors.black,
                  unselectedItemColor: Colors.white),
              togglerTheme: SideNavigationBarTogglerTheme(
                expandIconColor: const Color.fromARGB(255, 0, 0, 0),
                shrinkIconColor: Colors.black,
              ),
              dividerTheme: SideNavigationBarDividerTheme(
                footerDividerColor: Colors.white,
                headerDividerColor: Colors.white,
                mainDividerColor: Colors.white,
                footerDividerThickness: 2,
                headerDividerThickness: 1,
                mainDividerThickness: 2,
                showHeaderDivider: true,
                showMainDivider: true,
                showFooterDivider: false,
              ),
            ),
            header: SideNavigationBarHeader(
                image: Image.asset(
                  "lib/assets/logo_name.png",
                  height: 100,
                  width: 150,
                ),
                title: Text(" "),
                subtitle: Text(" ")),
            footer: SideNavigationBarFooter(
              label: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "lib/assets/logo_tr.png",
                    height: 50,
                  ),
                  Text(
                    "Lightning your future",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
            selectedIndex: _selectedIndex,
            items: [
              SideNavigationBarItem(
                icon: Icons.home_filled,
                label: "Home",
              ),
              SideNavigationBarItem(
                icon: Icons.book,
                label: "Add Course",
              ),
              SideNavigationBarItem(
                icon: Icons.logout,
                label: "Logout",
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          // Display the selected screen based on _selectedIndex
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}
