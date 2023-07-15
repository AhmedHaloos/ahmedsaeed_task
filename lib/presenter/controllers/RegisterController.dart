


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{


  final isRegistered= false.obs;
  final currentUser  = Rxn<User>() ;


  /// update the state of user registered
  void updateRegisterState(bool isRegister, Function(bool) callback){
    if(callback !=  null){
      ever(isRegistered,callback!);
    }
    this.isRegistered.value = isRegister;
    update();
  }
  ///update the current user
  void updateCurrUser(User user){
    currentUser.value = user;
    update();
  }

}