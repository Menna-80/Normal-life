import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/screens/side_bar/navigation_drawer.dart';
import 'package:gradution_project/shared/styles/colors.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      builder: (context, state) {
        var lan = ProjectCubit.get(context);
        return Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(
            drawer: Navigation(),
            appBar: AppBar(
              title: Text(lan.getTexts('page6-title') as String),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 130.0,
                        width: 150.0,
                        child: Image.asset(
                          ProjectCubit.get(context).isDark
                              ? 'assets/images/logo1.png'
                              : 'assets/images/logo2.png',
                        ),
                      ),
                    ),
                    Text(
                      lan.getTexts('page6-headline') as String,
                      //   textAlign: TextAlign.,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 40,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Info(text1:lan.getTexts('page6-1') as String, text2:   lan.getTexts('page6-1.1') as String,),
                    const SizedBox(
                      height: 20,
                    ),
                    Info(text1: lan.getTexts('page6-2') as String, text2:  lan.getTexts('page6-2.1') as String,),
                    const SizedBox(
                      height: 20,
                    ),
                    Info(text1: lan.getTexts('page6-3') as String, text2:  lan.getTexts('page6-3.1') as String,),

                    const SizedBox(
                      height: 20,
                    ),
                    Info(text1: lan.getTexts('page6-4') as String, text2:  lan.getTexts('page6-4.1') as String,),

                    const SizedBox(
                      height: 20,
                    ),
                    Info(text1: lan.getTexts('page6-5') as String, text2:  lan.getTexts('page6-5.1') as String,),

                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

class Info extends StatelessWidget {
   final String text1;
   final String text2;

  const Info({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 100.0,
      width: 450.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 8.0,
              blurStyle: BlurStyle.outer),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Textcolor,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Text(
                  text1,
                  style: const TextStyle(
                    fontSize: 20, ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 40.0,
              ),
              Text(
                text2,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

