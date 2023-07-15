import 'package:ahmedsaeedtask/presenter/global/functions.dart';
import 'package:ahmedsaeedtask/model/datamodel/ResultApi.dart';
import 'package:ahmedsaeedtask/presenter/controllers/LoginController.dart';
import 'package:ahmedsaeedtask/model/backend/LoginBackend.dart';
import 'package:flutter/cupertino.dart';

import '../view/ImageUploadScreen.dart';

class LoginPresenter {

  LoginController? _loginController ;
  LoginBackend? _loginBackend = LoginBackend();
  BuildContext _context;

  bool isLoggedIn = false;
  bool isRegistered = false;

  LoginPresenter( this._context, this._loginController);
  void login(String email, String password) {
    if (_loginBackend != null) {
      _loginBackend!.login(email, password, (result) {

        if (_loginController != null) {
          if (result.status == ResultApi.success) {

            _loginController!.updateLoginState(true, _loginCallback);
          } else {

            _loginController!.updateLoginState(false, _loginCallback);
          }
        }
      });
    }
  }

  void _loginCallback(bool isLoggedIn ){
    // print("login callback is called");
    if(isLoggedIn){
      navigate(_context, ImageUploadScreen(), false);
    }
  }
}
