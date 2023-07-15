

import 'package:ahmedsaeedtask/firebase_options.dart';
import 'package:ahmedsaeedtask/model/datamodel/ResultApi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginBackend {

    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void checkUserLoggedIn(Function(ResultApi) callback){
    

    _firebaseAuth.authStateChanges()
        .listen((User? user) {
      if (user == null) {
        callback(ResultApi(ResultApi.failed, {
          "user" : null
        }, "user not logged in"));
      } else {
        callback(ResultApi(ResultApi.success, {
          "user" : user,
        }, "user not logged in"));
      }
    });
  }
  void login(String email, String password, Function(ResultApi) callback){

    try {
      _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((userCredetial){
        // print("response from firebase : ${userCredetial}");
        if(userCredetial.user != null){
          // print("login backend user : ${userCredetial.user}");
          callback(ResultApi(ResultApi.success, {
            "user" : userCredetial.user
          }, ""));
        }
        else {
          callback(ResultApi(ResultApi.failed, {
            "user" : null
          }, "error in signing user up"));
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }
  void register(String email, String password, Function(ResultApi) callback){


    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredetial){
          if(userCredetial.user != null){
            callback(ResultApi(ResultApi.success, {
              "user" : userCredetial.user
            }, ""));
          }
          else {
            callback(ResultApi(ResultApi.failed, {
              "user" : null
            }, "error in signing user up"));
          }

    })
        .catchError((e){
          print("register error : $e");
    });

  }



}