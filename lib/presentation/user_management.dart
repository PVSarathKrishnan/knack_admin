import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knack_admin/presentation/style/text_style.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details",style: t1,),
        backgroundColor: Color.fromARGB(255, 9, 220, 62).withOpacity(0.5),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
          
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 233, 233, 233).withOpacity(0.5),
               
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: DataTable(
              headingRowHeight: 60,
              columns: [
                DataColumn(label: Text('sl/no', style: t1)),
                DataColumn(label: Text('Name', style: t1)),
                DataColumn(label: Text('Email', style: t1)),
                DataColumn(label: Text('Course Selected', style: t1)),
                DataColumn(label: Text('Premium Course', style: t1)),
              ],
              rows: List.generate(
                20,
                (index) => DataRow(cells: [
                  DataCell(Text((index + 1).toString(), style: t1)),
                  DataCell(Text('Sarath Krishnan', style: t1)),
                  DataCell(Text('gmail@gmail.com', style: t1)),
                  DataCell(
                      Text('0', style: t1)), // Assuming 0 means not selected
                  DataCell(Text('2', style: t1)), // Assuming 2 means selected
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
