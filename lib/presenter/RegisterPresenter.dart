


import 'package:ahmedsaeedtask/presenter/global/functions.dart';
import 'package:ahmedsaeedtask/model/backend/LoginBackend.dart';
import 'package:ahmedsaeedtask/view/LoginScreen.dart';
import 'package:flutter/cupertino.dart';

import '../model/datamodel/ResultApi.dart';
import 'controllers/RegisterController.dart';

class RegisterPresenter {

  LoginBackend _loginBackend = LoginBackend();
  RegisterController _registerController;
  BuildContext _context;

  RegisterPresenter( this._context, this._registerController);


  void register(String email, String password){

    _loginBackend!.register(email, password, (result){
      if (_registerController != null) {

        if (result.status == ResultApi.success) {
          print("update reg state = true");
          _registerController!.updateRegisterState(true, _regCallback);
          _registerController!.updateCurrUser(result.data?["user"]);
        } else {
          _registerController!.updateRegisterState(false,_regCallback);
        }
      } else {
        print("_loginController can not be null in login presenter");
      }
    });
  }
  void _regCallback(bool registered){
    print("_regCallback");
    if(registered){
      navigate(_context, LoginScreen(), true);
    }
    else print("not registered");
  }
}