import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/screens/login/cubit/states.dart';
import 'package:gradution_project/screens/register/register.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/shared_pref.dart';
import '../home.dart';
import 'cubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  /* SignIn(context) async {
    var formdata = formkey.currentState;
    if (formdata?.validate() == true) {
      formdata?.save();
      try {
         userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found'){
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text('No user found for that email.'),
          )..show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text('Wrong password provided for that user.'),
          )..show();
        }
      } catch (e) {
        print(e);
      }
    } else {
      ShowToast(state: ToastStates.error, text: 'Error In Log IN');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async {
          if (state is LoginErrorState) {
            ShowToast(
              text: 'Error In Log IN',
              state: ToastStates.error,
            );
          }
          if (state is LoginSuccessState) {
            CachHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) async {
              NavigateAndReplace(
                context,
                HomeScreen(),
              );
            });
            ShowToast(
              text: 'Logged in successfully',
              state: ToastStates.success,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 200.0,
                            width: 200.0,
                            child: Image.asset(
                              ProjectCubit.get(context).isDark
                                  ? 'assets/images/logo1.png'
                                  : 'assets/images/logo2.png',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          'Welcome back, please login to your account',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defualtFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value == null) return null;
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                          label: 'Email adresess',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defualtFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value == null) return null;
                              if (value.isEmpty) {
                                return 'password must not be empty';
                              }
                            },
                            onSubmit: (String? value) {
                              if (formkey.currentState?.validate() == true) {
                                LoginCubit.get(context).SignIn(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword: LoginCubit.get(context).isPassword,
                            label: 'Password',
                            prefix: Icons.password_outlined,
                            suffix: LoginCubit.get(context).suffix,
                            suffixPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defualtButton(
                            function: () {
                              if (formkey.currentState?.validate()==true) {
                                LoginCubit.get(context).SignIn(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                              }
                            },
                            text: 'Login',
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            defualtTextButton(
                              function: () {
                                NavigateTo(context, RegisterScreen());
                              },
                              text: 'Register Now',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
