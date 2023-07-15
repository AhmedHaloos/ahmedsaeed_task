import 'package:ahmedsaeedtask/presenter/controllers/LoginController.dart';
import 'package:ahmedsaeedtask/presenter/LoginPresenter.dart';
import 'package:ahmedsaeedtask/view/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {

  LoginPresenter? _loginPresenetr ;

  LoginScreen();


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _loginkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          _loginPresenetr = LoginPresenter(context, controller);
          return Scaffold(
            appBar: AppBar(
              title: Text("Login"),
            ),
              body: Form(
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
                                    if(_loginPresenetr != null){
                                    _loginPresenetr!.login(email, password);
                                    }
                                    else {
                                      print("_loginPresenetr can not be null");
                                    }
                                  }
                                },
                                child: Text("Login")),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 24),
                            child: ElevatedButton(
                                onPressed: () {
                                Navigator.pushReplacement(context, 
                                MaterialPageRoute(builder: (context)=>RegisterScreen()));
                                },
                                child: Text("Sign up")),
                          )
                        ],
                      ),
                    ));
        });
  }
}
