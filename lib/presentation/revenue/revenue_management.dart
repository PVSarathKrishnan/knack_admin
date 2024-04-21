import 'package:flutter/material.dart';

class RevenueManagementScreen extends StatefulWidget {
  const RevenueManagementScreen({super.key});

  @override
  State<RevenueManagementScreen> createState() => _RevenueManagementScreenState();
}

class _RevenueManagementScreenState extends State<RevenueManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      child: Text("Revenue"),
    ));
  }
}