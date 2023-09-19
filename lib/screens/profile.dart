import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/layout/cubit/cubit.dart';
import 'package:gradution_project/layout/cubit/states.dart';
import 'package:gradution_project/screens/side_bar/navigation_drawer.dart';
import 'package:gradution_project/shared/components/components.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {
        if (state is UserUpdateSuccessState) {
          ShowToast(text: 'Done', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        var profileImage = ProjectCubit.get(context).profileImage;

        var lan = ProjectCubit.get(context);
        return FutureBuilder(
            future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
            builder: (BuildContext, AsyncSnapshot<dynamic> snapshot){
              emailController.text =snapshot.data['email'];
              nameController.text = snapshot.data['name'];
              phoneController.text = snapshot.data['phone'];
    if(!snapshot.hasData || snapshot.data == null) {
    return const Center(child: CircularProgressIndicator());
    } else if (snapshot.connectionState == ConnectionState.done) {
      return Directionality(
        textDirection:lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          drawer: Navigation(),
          appBar: AppBar(
            title:  Text(lan.getTexts('profile-title')as String),
            backgroundColor: Color(0xff408D9B),

          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    if (state is UserUpdateLoadingState)
                      const LinearProgressIndicator(),
                    if (state is UserUpdateLoadingState)
                      SizedBox(
                        height: 15.0,
                      ),
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 160.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight:Radius.circular(40),bottomLeft: Radius.circular(40)),
                                  color: Color(0xff408D9B)
                              ),
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 65.0,
                                backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profileImage == null
                                      ? AssetImage('assets/images/logo2.png')
                                      : FileImage(profileImage) as ImageProvider,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  ProjectCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),


                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      (ProjectCubit.get(context).profileImage != null)
                          ?defualtButton(
                          function: () {
                            ProjectCubit.get(context).uploadProfileImage(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          },
                          text: 'Upload Picture'): Container(),
                      const SizedBox(
                        height: 25.0,
                      ),
                      defualtFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String? value) {
                          if (value == null) return null;
                          if (value.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        label: 'User Name',
                        prefix: Icons.person_rounded,
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
                        },
                        label: 'Phone Number',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defualtButton(
                          function: () {
                            ProjectCubit.get(context).updateUser(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text);
                          },
                          text: lan.getTexts('profile-btn')as String
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ),
        ),
      );
    }else {
     return const Center(child: CircularProgressIndicator());
    }

            }
        ) ;
      },
    );
  }
}
