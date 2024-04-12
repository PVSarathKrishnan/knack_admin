import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knack_admin/presentation/user_management.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsScreen(),
                    ));
              },
              child: _buildCard(
                title: 'User Management',
                description: 'Manage users and roles',
              ),
            ),
            SizedBox(height: 40),
            _buildCard(
              title: 'Course Management',
              description: 'Manage courses and enrollments',
            ),
            SizedBox(height: 40),
            _buildCard(
              title: 'Revenue Management',
              description: 'Track and manage revenue generated',
            ),
            SizedBox(height: 40),
            _buildCard(
              title: 'Settings',
              description: 'Configure application settings',
            ),
            SizedBox(height: 40),
            _buildCard(
              title: 'Feedbacks',
              description: 'View and respond to user feedback',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 400),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 40, 226, 46),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
