import 'package:evently/core/remote/network/firestore_manager.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class UserProvider extends ChangeNotifier {
 User? currentUser;

 Future<void> fetchUser()async{
   currentUser = await FirestoreManager.getUser();
   notifyListeners();
 }

}