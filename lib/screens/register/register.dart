
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/layout/cubit/states.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/components/components.dart';

import '../home.dart';


class RegisterScreen extends StatelessWidget {
   const RegisterScreen({super.key});




  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();

    var passwordController = TextEditingController();

    var nameController = TextEditingController();

    var phoneController = TextEditingController();

    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => ProjectCubit(),
      child: BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is CreateUserSuccessState) {
            if(ProjectCubit.get(context).userModel != null) {
              showToast(
                  text:'Successfully registered' ,
                  state: ToastStates.success,
                );
            }
                navigateAndReplace(
                  context,
                  HomeScreen(),
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
                      children: [
                        Center(
                          child: SizedBox(
                            height: 200.0,
                            width: 200.0,
                            child:Image.asset(
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
                          'REGISTER',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defualtFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value == null) return null;
                            if (value.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person_rounded,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defualtFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value == null) return null;
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
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
                              return null;
                            },
                            onSubmit: (String? value) {},
                            isPassword: ProjectCubit.get(context).isPassword,
                            label: 'Password',
                            prefix: Icons.password_outlined,
                            suffix: ProjectCubit.get(context).suffix,
                            suffixPressed: () {
                              ProjectCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defualtFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value == null) return null;
                            if (value.isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defualtButton(
                            function: () {
                              if (formkey.currentState?.validate() == true) {
                                ProjectCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: 'Register',
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
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
