import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knack_admin/main.dart';
import 'package:knack_admin/presentation/course/course_management.dart';
import 'package:knack_admin/presentation/login/login_screen.dart';
import 'package:knack_admin/presentation/revenue/revenue_management.dart';
import 'package:knack_admin/presentation/style/text_style.dart';
import 'package:knack_admin/presentation/user/user_management.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Knack Admin!',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4, // Display 2 tiles per row
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: .5,
                  children: [
                    _buildFeatureTile(
                      'Course Management',
                      Icons.menu_book,
                      Colors.blue,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseManagementScreen(),
                          ),
                        );
                      },
                    ),
                    _buildFeatureTile(
                      'User Management',
                      Icons.people,
                      Colors.green,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserDetailsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildFeatureTile(
                      'Revenue Management',
                      Icons.attach_money,
                      Colors.purple,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RevenueManagementScreen(),
                          ),
                        );
                      },
                    ),
                    _buildFeatureTile(
                        'Logout',
                        Icons.logout,
                        const Color.fromARGB(
                            255, 255, 0, 0), // Changed icon to logout
                        () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureTile(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
