import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/layout/cubit/states.dart';
import 'package:gradution_project/screens/home.dart';
import 'package:gradution_project/screens/login/login.dart';
import 'package:gradution_project/screens/on_boarding.dart';
import 'package:gradution_project/shared/components/constants.dart';
import 'package:gradution_project/shared/network/local/shared_pref.dart';
import 'package:gradution_project/shared/themes.dart';

import 'layout/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CachHelper.init();

  bool? isDark = CachHelper.getData(key: 'isDark');
  Widget widget;
  uId = CachHelper.getData(key: 'uId');

  bool? onBoarding = CachHelper.getData(key: 'OnBoarding');
  if (onBoarding != null) {
    if (uId != null) {
      widget = const HomeScreen();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = OnBoardScreen();
  }

  runApp(MyApp(
    startwidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  final bool? isDark;
  const MyApp({super.key, required this.isDark, required this.startwidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider (
      providers: [
        BlocProvider (
          create: (BuildContext context) => ProjectCubit()
            ..getUserData()
            ..changeMode(fromShared: isDark)
            ..getLan()
          ,
        ),
      ],
      child: BlocConsumer<ProjectCubit, ProjectStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                theme: lighttheme,
                darkTheme: darktheme,
                themeMode: ProjectCubit.get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: StreamBuilder(
                  stream: FirebaseFirestore.instance.doc('users').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.hasData) {
                    return const HomeScreen();
                  } else {
                    return startwidget;
                  }
                },)
            );
          }),
    );
  }
}
