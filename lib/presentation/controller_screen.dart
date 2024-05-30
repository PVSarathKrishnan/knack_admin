import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

// Import your screen classes (replace with actual implementations)
import 'home/home_screen.dart';
import 'course/add_course_screen.dart';
import 'course/course_management.dart';
import 'user/user_management.dart';
import 'revenue/revenue_management.dart';
import 'settings/settings.dart';
import 'logout/logout_screen.dart';

class ControllerScreen extends StatefulWidget {
  const ControllerScreen({Key? key}) : super(key: key);

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    AddCourseScreen(),
    CourseManagementScreen(),
    UserDetailsScreen(),
    RevenueManagementScreen(),
  ];

  final SidebarXController _controller =
      SidebarXController(selectedIndex: 0, extended: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          SidebarX(
            separatorBuilder: (context, index) {
              // Return your custom separator widget here
              return Divider(
                height: 50,
                thickness: 2,
                color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                indent: 30,
                endIndent: 30,
              );
            },
            showToggleButton: false,
            controller: _controller,
            theme: SidebarXTheme(
              width: 150, // Set a fixed width for the sidebar
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: canvasColor,
                borderRadius: BorderRadius.circular(20),
              ),
              hoverColor: scaffoldBackgroundColor,
              textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              selectedTextStyle: const TextStyle(color: Colors.white),
              hoverTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              itemTextPadding: const EdgeInsets.only(left: 30),
              selectedItemTextPadding: const EdgeInsets.only(left: 30),
              itemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: canvasColor),
              ),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: actionColor.withOpacity(0.37),
                ),
                gradient: const LinearGradient(
                  colors: [accentCanvasColor, canvasColor],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.28),
                    blurRadius: 30,
                  )
                ],
              ),
              iconTheme: IconThemeData(
                color: Colors.white.withOpacity(0.3),
                size: 20,
              ),
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
                size: 35,
              ),
            ),
            headerBuilder: (context, extended) {
              return SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('lib/assets/logo_name.png'),
                ),
              );
            },
            footerDivider: divider,
            items: const [
              SidebarXItem(
                icon: Icons.home_filled,
                label: 'Home',
              ),
              SidebarXItem(
                icon: Icons.add_circle_outline_sharp,
                label: 'Add Course',
              ),
              SidebarXItem(
                icon: Icons.menu_book_sharp,
                label: 'Course Management',
              ),
              SidebarXItem(
                icon: Icons.people,
                label: 'User Management',
              ),
              SidebarXItem(
                icon: Icons.auto_graph_sharp,
                label: 'Revenue Management',
              ),
            ],
          ),
          // Add spacing between the SideNavigationBar and the main content
          const SizedBox(width: 10),
          // Display the selected screen based on _selectedIndex
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return _screens[_controller.selectedIndex];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Add Course';
    case 2:
      return 'Course Management';
    case 3:
      return 'User Management';
    case 4:
      return 'Revenue Management';
    default:
      return 'Not found page';
  }
}

const primaryColor = Colors.green;
const canvasColor = Colors.black;
const scaffoldBackgroundColor = Colors.black;
const accentCanvasColor = Colors.green;
const white = Colors.white;
final actionColor = Colors.green.withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
