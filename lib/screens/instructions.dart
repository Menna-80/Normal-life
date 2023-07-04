import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/screens/side_bar/navigation_drawer.dart';
import 'package:gradution_project/shared/styles/colors.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      builder: (context, state) {
        var lan = ProjectCubit.get(context);
        return Directionality(
          textDirection:lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(
            drawer: Navigation(),
            appBar: AppBar(
              title: Text(lan.getTexts('page5-title') as String),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 150.0,
                        width: 150.0,
                        child: Image.asset(
                          ProjectCubit.get(context).isDark
                              ? 'assets/images/logo1.png'
                              : 'assets/images/logo2.png',
                        ),
                      ),
                    ),
                    Text(
                      lan.getTexts('page4-title2')as String,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Textcolor),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children:  [
                        const CircleAvatar(
                          backgroundColor: Textcolor,
                          radius: 8.0,
                        ),
                        SizedBox(width: 15.0,),
                        Expanded(
                          child: Text(
                            lan.getTexts('page4-ins1')as String,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Textcolor,
                          radius: 8.0,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            lan.getTexts('page4-ins2')as String,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children:  [
                        const CircleAvatar(
                          backgroundColor: Textcolor,
                          radius: 8.0,
                        ),
                        SizedBox(width: 15.0,),
                        Expanded(
                          child: Text(
                            lan.getTexts('page4-ins3')as String,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children:  [
                        CircleAvatar(
                          backgroundColor: Textcolor,
                          radius: 8.0,
                        ),
                        SizedBox(width: 15.0,),
                        Expanded(
                          child: Text(
                            lan.getTexts('page4-ins4')as String,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children:  [
                        CircleAvatar(
                          backgroundColor: Textcolor,
                          radius: 8.0,
                        ),
                        SizedBox(width: 15.0,),
                        Expanded(
                          child: Text(
                            lan.getTexts('page4-ins5')as String,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children:  [
                        CircleAvatar(
                          backgroundColor: Textcolor,
                          radius: 8.0,
                        ),
                        SizedBox(width: 15.0,),
                        Expanded(
                          child: Text(
                            lan.getTexts('page4-ins6')as String,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children:  [
                        CircleAvatar(
                          backgroundColor: Textcolor,
                          radius: 8.0,
                        ),
                        SizedBox(width: 15.0,),
                        Expanded(
                          child: Text(
                            lan.getTexts('page4-ins7')as String,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
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
