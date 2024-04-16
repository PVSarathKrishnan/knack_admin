import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knack_admin/Domain/model/user_model.dart';

class UserRepo {
  Future<List<UserModel>> getUsers() async {
    List<UserModel> userList = [];
    try {
      final userData =
          await FirebaseFirestore.instance.collection("users").get();
      userData.docs.forEach((element) {
        final data = element.data();

        final user = UserModel(name: data["name"], email: data["email"]);
        userList.add(user);
      });
      return userList;
    } catch (e) {
     debugPrint("exception getting user  : ${e}");
    }
    return userList;
  }
}
