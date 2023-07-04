import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/layout/cubit/states.dart';
import 'package:gradution_project/screens/home.dart';
import 'package:gradution_project/screens/login/login.dart';
import 'package:gradution_project/screens/on_boarding.dart';
import 'package:gradution_project/shared/components/components.dart';
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
  bool? OnBoarding = CachHelper.getData(key: 'OnBoarding');
  if (OnBoarding != null) {
    if (uId != null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardScreen();
  }
  print(OnBoarding);

  runApp(MyApp(
    startwidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  final bool? isDark;
  const MyApp({required this.isDark, required this.startwidget});

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
                home: FutureBuilder(
                  future: Future.value(FirebaseAuth.instance.currentUser),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.hasData) {
                    return HomeScreen();
                  } else {
                    return startwidget;
                  }
                },)
            );
          }),
    );
  }
}
