import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';

class RevenueManagementScreen extends StatefulWidget {
  const RevenueManagementScreen({super.key});

  @override
  State<RevenueManagementScreen> createState() =>
      _RevenueManagementScreenState();
}

class _RevenueManagementScreenState extends State<RevenueManagementScreen> {
  late Future<Map<String, dynamic>> revenueData;

  @override
  void initState() {
    super.initState();
    revenueData = _fetchRevenueData();
  }

  Future<Map<String, dynamic>> _fetchRevenueData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('bookings').get();
    List<QueryDocumentSnapshot> bookings = snapshot.docs;

    double totalAmount = 0;
    Map<String, int> courseCount = {};
    Map<String, double> userSpending = {};
    int bookingCount = bookings.length;

    for (var doc in bookings) {
      var data = doc.data() as Map<String, dynamic>;
      double amount = double.parse(data['booking_amount']);
      String courseTitle = data['courseDetails']['title'];
      String userId = data['user_id'];
      String userName = data['user_name'];

      totalAmount += amount;
      courseCount[courseTitle] = (courseCount[courseTitle] ?? 0) + 1;
      userSpending[userName] = (userSpending[userName] ?? 0) + amount;
    }

    String mostBoughtCourse = courseCount.keys.first;
    for (var course in courseCount.keys) {
      if (courseCount[course]! > courseCount[mostBoughtCourse]!) {
        mostBoughtCourse = course;
      }
    }

    String topUser = userSpending.keys.first;
    for (var user in userSpending.keys) {
      if (userSpending[user]! > userSpending[topUser]!) {
        topUser = user;
      }
    }

    double averageSpending = totalAmount / bookingCount;

    return {
      'totalAmount': totalAmount,
      'mostBoughtCourse': mostBoughtCourse,
      'topUser': topUser,
      'averageSpending': averageSpending,
      'courseCount': courseCount,
      'bookings': bookings,
    };
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<Map<String, dynamic>>(
        future: revenueData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var data = snapshot.data!;
          double totalAmount = data['totalAmount'];
          String mostBoughtCourse = data['mostBoughtCourse'];
          String topUser = data['topUser'];
          double averageSpending = data['averageSpending'];
          Map<String, int> courseCount = data['courseCount'];
          List<QueryDocumentSnapshot> bookings = data['bookings'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Revenue Statistics',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildStatisticCard(
                        'Total Generated Amount',
                        '₹$totalAmount',
                        'https://i.pinimg.com/236x/6d/ef/9f/6def9f4cda334a4d7530ff89ec5007e2.jpg',
                      ),
                      _buildStatisticCard(
                        'Most Bought Course',
                        mostBoughtCourse,
                        'https://i.pinimg.com/564x/1e/82/0f/1e820f1d393a1777bc449e74db0c64fc.jpg',
                      ),
                      _buildStatisticCard(
                        'Top User',
                        topUser,
                        'https://i.pinimg.com/564x/09/e9/58/09e958341105fd48e8bf3e54ca29cff4.jpg',
                      ),
                      _buildStatisticCard(
                        'Average Spending Amount',
                        '₹$averageSpending',
                        'https://i.pinimg.com/236x/51/28/98/512898814667f9b0510902acc9262924.jpg',
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildPieChart(courseCount),
                  SizedBox(height: 20),
                  Text(
                    'Detailed Bookings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> bookingData =
                          bookings[index].data() as Map<String, dynamic>;
                      return BookingCard(bookingData: bookingData);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatisticCard(String title, String value, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart(Map<String, int> courseCount) {
    List<PieChartSectionData> sections = [];

    // Use a predefined set of colors for each section
    final List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    int index = 0;
    courseCount.forEach((course, count) {
      sections.add(PieChartSectionData(
        title: course,
        value: count.toDouble(),
        color: colors[index++ % colors.length], // Cycle through colors
      ));
    });

    return Card(
      margin:
          EdgeInsets.symmetric(vertical: 16.0), // Increased vertical spacing
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12)), // More pronounced border radius
      child: Padding(
        padding: const EdgeInsets.all(
            20.0), // Increased padding for better readability
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Distribution',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow
                      .ellipsis), // Larger font size, bold, and ellipsis for overflow
            ),
            SizedBox(
                height: 250, // Increased height for larger chart
                child: PieChart(PieChartData(
                    sections: sections,
                    borderData: FlBorderData(show: false)))),
          ],
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const BookingCard({Key? key, required this.bookingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String courseTitle = bookingData['courseDetails']['title'];
    String coursePhoto = bookingData['courseDetails']['photo'];
    String userName = bookingData['user_name'];
    String bookingAmount = bookingData['booking_amount'];

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                coursePhoto,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'User: $userName',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Amount: ₹$bookingAmount',
                    style: TextStyle(fontSize: 16),
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
