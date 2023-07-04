import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/shared/styles/colors.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/components/components.dart';
import 'side_bar/navigation_drawer.dart';

class FingersScreen extends StatelessWidget {
  final DBref = FirebaseDatabase.instance.ref();

  int? handStatus = 0;

  // int counter=0;
  getHandStatus() async {
    await DBref.child('HAND_STATUS').once().then((DatabaseEvent event) {
      handStatus = event.snapshot.value as int?;
      // counter = (event.snapshot.value as int?)?? 0 ;
      if (kDebugMode) {
        print(handStatus);
      }
      //  print(counter);
      // print(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var lan = ProjectCubit.get(context);
        return Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(
            drawer: Navigation(),
            appBar: AppBar(title: Text(lan.getTexts('page2-title') as String),),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Image.asset(
                          'assets/images/open2.png',

                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(
                          width: 50.0,
                        ),
                        Image.asset(
                              'assets/images/close2.png',
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    FingersButtons(
                      fingername: lan.getTexts('page2-finger1') as String,
                      CloseonPressed: () {
                        handStatus == 1
                            ? DBref.child('handStatus').set(10)
                            : DBref.child('handStatus').set(10);
                      },
                      OpenonPressed: () {
                        handStatus == 10
                            ? DBref.child('handStatus').set(1)
                            : DBref.child('handStatus').set(1);
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    FingersButtons(
                      fingername: lan.getTexts('page2-finger2') as String,
                      CloseonPressed: () {
                        handStatus == 2
                            ? DBref.child('handStatus').set(20)
                            : DBref.child('handStatus').set(20);
                      },
                      OpenonPressed: () {
                        handStatus == 20
                            ? DBref.child('handStatus').set(2)
                            : DBref.child('handStatus').set(2);
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    FingersButtons(
                      fingername: lan.getTexts('page2-finger3') as String,
                      CloseonPressed: () {
                        handStatus == 3
                            ? DBref.child('handStatus').set(30)
                            : DBref.child('handStatus').set(30);
                      },
                      OpenonPressed: () {
                        handStatus == 30
                            ? DBref.child('handStatus').set(3)
                            : DBref.child('handStatus').set(3);
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    FingersButtons(
                      fingername: lan.getTexts('page2-finger4') as String,
                      CloseonPressed: () {
                        handStatus == 4
                            ? DBref.child('handStatus').set(40)
                            : DBref.child('handStatus').set(40);
                      },
                      OpenonPressed: () {
                        handStatus == 40
                            ? DBref.child('handStatus').set(4)
                            : DBref.child('handStatus').set(4);
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    FingersButtons(
                      fingername: lan.getTexts('page2-finger5') as String,
                      CloseonPressed: () {
                        handStatus == 5
                            ? DBref.child('handStatus').set(50)
                            : DBref.child('handStatus').set(50);
                      },
                      OpenonPressed: () {
                        handStatus == 50
                            ? DBref.child('handStatus').set(5)
                            : DBref.child('handStatus').set(5);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class FingersButtons extends StatelessWidget {
  final String fingername;
  final VoidCallback CloseonPressed;
  final VoidCallback OpenonPressed;
  const FingersButtons({
    Key? key,
    required this.fingername,
    required this.CloseonPressed,
    required this.OpenonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
        builder: (context, state) {
          var lan = ProjectCubit.get(context);
          return Directionality(
            textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  fingername,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0,
                      color: Textcolor),
                )),
                const SizedBox(
                  width: 40.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .3,
                  height: MediaQuery.of(context).size.height * .06,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff378F9F),
                        Color(0xff1C95AB),
                        Color.fromRGBO(0, 197, 232, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: MaterialButton(
                    onPressed: OpenonPressed,
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              lan.getTexts('page2-btn1') as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .3,
                  height: MediaQuery.of(context).size.height * .06,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff378F9F),
                        Color(0xff1C95AB),
                        Color.fromRGBO(0, 197, 232, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: MaterialButton(
                    onPressed: CloseonPressed,
                    child: Row(
                      children:  [
                        Expanded(
                          child: Center(
                            child: Text(
                              lan.getTexts('page2-btn2') as String,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
