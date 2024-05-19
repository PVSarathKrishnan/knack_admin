import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knack_admin/presentation/logout/user/user_management.dart';
import 'package:knack_admin/presentation/style/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "Home Page",
              style: t1,
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildCard({
  //   required String title,
  //   required String description,
  // }) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 400),
  //     padding: EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: Colors.black,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               title,
  //               style: GoogleFonts.montserrat(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             Text(
  //               description,
  //               style: GoogleFonts.montserrat(
  //                 fontSize: 14,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Icon(
  //           Icons.navigate_next,
  //           color: Colors.black,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
