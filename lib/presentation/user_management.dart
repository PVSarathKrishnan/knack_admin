import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knack_admin/application/bloc/user%20bloc/fetch_user_bloc.dart';
import 'package:knack_admin/presentation/Custom%20Widgets/loader.dart';
import 'package:knack_admin/presentation/style/text_style.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  // Instance of UserRepository

  @override
  Widget build(BuildContext context) {
    context.read<FetchUserBloc>().add(FetchUserLoadEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Details",
          style: t1,
        ),
        backgroundColor: Color.fromARGB(255, 9, 220, 62).withOpacity(0.5),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<FetchUserBloc, FetchUserState>(
            builder: (context, state) {
              if (state is FetchUserLoadedState) {
                return DataTable(
                  
                  headingRowHeight: 50,
                  columns: [
                    DataColumn(label: Text('sl/no', style: t1)),
                    DataColumn(label: Text('Name', style: t1)),
                    DataColumn(label: Text('Email', style: t1)),
                  ],
                  rows: List<DataRow>.generate(
                    state.userList.length,
                    (index) => DataRow(cells: [
                      DataCell(Text((index + 1).toString(), style: t1.copyWith(fontWeight: FontWeight.normal))),
                      DataCell(Text(state.userList[index].name, style: t1.copyWith(fontWeight: FontWeight.normal))),
                      DataCell(Text(state.userList[index].email, style: t1.copyWith(fontWeight: FontWeight.normal))),
                      // Add more DataCell widgets if needed
                    ]),
                  ),
                );
              } else {
                return Center(
                  child: CustomLoaderWidget(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
