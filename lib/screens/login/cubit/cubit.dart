import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/screens/login/cubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/components/components.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

 /* void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }*/

  IconData suffix = Icons.visibility_off_rounded;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded;

    emit(ChangePasswordVisibilityState());
  }

  SignIn({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password) ;
      emit(LoginSuccessState(userCredential.user!.uid));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ShowToast(
          text: 'No user found for that email.',
          state: ToastStates.error,
        );
      } else if (e.code == 'wrong-password') {
        ShowToast(
          text: 'Wrong password provided for that user.',
          state: ToastStates.error,
        );
      }
      emit(LoginErrorState(e.toString()));
    }

  }
}
