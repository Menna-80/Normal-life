import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/layout/cubit/cubit.dart';
import 'package:gradution_project/layout/cubit/states.dart';
import 'package:gradution_project/shared/components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/components/constants.dart';
import '../about_us.dart';
import '../login/login.dart';
import '../profile.dart';
import 'drawer_item.dart';
import '../home.dart';

class Navigation extends StatelessWidget {
  Navigation({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var lan = ProjectCubit.get(context);
        return FutureBuilder(
            future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
            builder: (BuildContext, AsyncSnapshot<dynamic> snapshot){
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Directionality(
                  textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
                  child: Drawer(
                    child: Scaffold(
                      body: Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
                        child: Column(
                          children: [
                            headerWidget(),
                            const SizedBox(
                              height: 40,
                            ),
                            const Divider(
                              thickness: 1,
                              height: 10,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            DrawerItem(
                              name: lan.getTexts('drawer1') as String,
                              icon: Icons.home_filled,
                              onPressed: () => onItemPressed(context, index: 0),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            DrawerItem(
                                name: lan.getTexts('drawer2') as String,
                                icon: Icons.account_box_rounded,
                                onPressed: () => onItemPressed(context, index: 1)),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                DrawerItem(
                                    name: lan.getTexts('drawer3') as String,
                                    icon: Icons.dark_mode_rounded,
                                    onPressed: () => onItemPressed(context, index: 2)),
                                const SizedBox(
                                  width: 50,
                                ),
                                Switch(
                                  value: ProjectCubit.get(context).isDark,
                                  activeColor: const Color(0xff378F9F),
                                  onChanged: (value) {
                                    ProjectCubit.get(context).changeMode();
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                DrawerItem(
                                    name: lan.getTexts('drawer4') as String,
                                    icon: Icons.language_outlined,
                                    onPressed: () => onItemPressed(context, index: 3)),
                                Switch(
                                  value: ProjectCubit.get(context).isEn,
                                  activeColor: const Color(0xff378F9F),
                                  onChanged: (value) {
                                    ProjectCubit.get(context).changeLan(value);
                                  },
                                ),
                                Text(lan.getTexts('drawer4-1') as String,
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Divider(
                              thickness: 1,
                              height: 10,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            DrawerItem(
                                name: lan.getTexts('drawer5') as String,
                                icon: Icons.info,
                                onPressed: () => onItemPressed(context, index: 4)),
                            const SizedBox(
                              height: 30,
                            ),
                            DrawerItem(
                                name: lan.getTexts('drawer6') as String,
                                icon: Icons.logout,
                                onPressed: () => onItemPressed(context, index: 5)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }else {
                return const Text( 'erorrrrr');
              }
            }
        );
      },
    );
  }

  Future<void> onItemPressed(BuildContext context, {required int index}) async {
    Navigator.pop(context);

    switch (index) {
      case 0:
        NavigateTo(context, HomeScreen());
        break;
      case 1:
        NavigateTo(context, ProfileScreen());
        break;
      case 2:
        ProjectCubit.get(context).changeMode();
        break;
      case 4:
        NavigateTo(context, AboutUsScreen());
        break;
      case 5:
        signOut(context);
        NavigateAndReplace(context, LoginScreen());
        break;
    }
  }

  Widget headerWidget() {
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var profileImage = ProjectCubit.get(context).profileImage;
          return FutureBuilder(
              future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
              builder: (BuildContext, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
            //  Map<String, dynamic> data = snapshot.data!.data() ?? {};
              return Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: profileImage == null
                        ? AssetImage('assets/images/logo2.png')
                        : FileImage(profileImage) as ImageProvider,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data['name'],
                           // maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(snapshot.data['email'],
                            style: const TextStyle(fontSize: 14))
                      ],
                    ),
                  )
                ],
              );
            }else {
              return const Text( 'erorrrrr');
            }
          });
        });
  }
}
