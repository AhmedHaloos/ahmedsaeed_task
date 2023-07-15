


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginController extends GetxController{



  /// update the user state to be logged in
  final isLoggedIn = false.obs;

  ///update login state
  void updateLoginState(bool _isLoggedIn, Function(bool) callback){

    if(callback != null){
      print("ever login called ");
      ever(isLoggedIn, callback);
    }
    this.isLoggedIn.value = _isLoggedIn;
    update();
  }



}