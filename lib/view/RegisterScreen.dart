

import 'package:ahmedsaeedtask/presenter/RegisterPresenter.dart';
import 'package:ahmedsaeedtask/presenter/controllers/RegisterController.dart';
import 'package:ahmedsaeedtask/view/ImageDisplayScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../presenter/controllers/LoginController.dart';
import '../presenter/LoginPresenter.dart';

class RegisterScreen extends StatelessWidget{

  RegisterPresenter? _registerPresenter ;

  RegisterScreen();


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _loginkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    if(_registerPresenter != null){
    }
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          _registerPresenter = RegisterPresenter(context, controller);
          return Scaffold(
              body:  Form(
                key: _loginkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          hintText: "Email"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "email must not be empty";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      textDirection: TextDirection.ltr,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          hintText: "password"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "email must not be empty";
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 24),
                      child: ElevatedButton(
                          onPressed: () {

                            if (_loginkey.currentState!.validate()) {
                              String email = _emailController.value.text;
                              String password =
                                  _passwordController.value.text;
                              if(_registerPresenter != null){
                                _registerPresenter!.register(email, password);
                              }
                              else {
                                print("_loginPresenetr can not be null");
                              }
                            }
                          },
                          child: Text("Sign Up")),
                    ),
                    Text(controller.isRegistered.value?"logged in ": "not logged in"),
                  ],
                ),
              ));
        });
  }

}