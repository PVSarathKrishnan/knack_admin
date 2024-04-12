import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: Text(
          "User Details",
          style: t1,
        ),
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
            child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection('users').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return DataTable(
                    headingRowHeight: 60,
                    columns: [
                      DataColumn(label: Text('sl/no', style: t1)),
                      DataColumn(label: Text('Name', style: t1)),
                      DataColumn(label: Text('Email', style: t1)),
                      DataColumn(label: Text('Course Selected', style: t1)),
                      DataColumn(label: Text('Premium Course', style: t1)),
                    ],
                    rows: snapshot.data!.docs.map(
                      (document) {
                        int rowIndex = snapshot.data!.docs.indexOf(document) + 1;
                        Map<String, dynamic> data = document.data()!;
                        return DataRow(cells: [
                          DataCell(Text(rowIndex.toString(), style: t1)), // sl/no starts from 1
                          DataCell(Text(data['name'].toString(), style: t1)),
                          DataCell(Text(data['email'].toString(), style: t1)),
                          DataCell(Text(data['course_selected'].toString(), style: t1)),
                          DataCell(Text(data['premium_course'].toString(), style: t1)),
                        ]);
                      },
                    ).toList(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
