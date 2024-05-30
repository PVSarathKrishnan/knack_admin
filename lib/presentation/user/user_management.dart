import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knack_admin/Domain/model/user_model.dart';
import 'package:knack_admin/application/bloc/user%20bloc/fetch_user_bloc.dart';
import 'package:knack_admin/presentation/Custom%20Widgets/loader.dart';
import 'package:knack_admin/presentation/style/text_style.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<FetchUserBloc>().add(FetchUserLoadEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "User Details",
          style: t1,
        ),
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
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: state.userList.length,
                  itemBuilder: (context, index) {
                    return UserTile(user: state.userList[index], index: index);
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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

class UserTile extends StatelessWidget {
  final UserModel user;
  final int index;

  UserTile({required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          user.name,
          style: t1.copyWith(fontSize: 20),
        ),
        subtitle: Text(
          user.email,
          style: t1.copyWith(fontSize: 15),
        ),
        leading: CircleAvatar(
          child: Text(
            (index + 1).toString(),
            style: t1.copyWith(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
