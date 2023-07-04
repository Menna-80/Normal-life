import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import 'side_bar/navigation_drawer.dart';

class ShapeScreen extends StatelessWidget {
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
        builder: (context, state){
          var lan = ProjectCubit.get(context);
          return Directionality(
            textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
      drawer: Navigation(),
      appBar: AppBar(
        title: Text(lan.getTexts('page3-title') as String),
      ),
      body: Padding(
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
               Text(
                lan.getTexts('page3-title2') as String,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0,
                    color: Textcolor),
              ),
              const SizedBox(
                height: 10.0,
              ),
              shapebuttons(
                image1: 'assets/images/shape1.png',
                image2: 'assets/images/shape2.png',
                onPressed1: () {
                  handStatus == 0
                      ? DBref.child('handStatus').set(11)
                      : DBref.child('handStatus').set(11);
                },
                onPressed2: () {
                  handStatus == 0
                      ? DBref.child('handStatus').set(12)
                      : DBref.child('handStatus').set(12);
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              shapebuttons(
                image1: 'assets/images/shape3.png',
                image2: 'assets/images/shape4.png',
                onPressed1: () {
                  handStatus == 0
                      ? DBref.child('handStatus').set(13)
                      : DBref.child('handStatus').set(13);
                },
                onPressed2: () {
                  handStatus == 0
                      ? DBref.child('handStatus').set(14)
                      : DBref.child('handStatus').set(14);
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              shapebuttons(
                image1: 'assets/images/shape5.png',
                image2: 'assets/images/shape6.png',
                onPressed1: () {
                  handStatus == 0
                      ? DBref.child('handStatus').set(15)
                      : DBref.child('handStatus').set(15);
                },
                onPressed2: () {
                  handStatus == 0
                      ? DBref.child('handStatus').set(16)
                      : DBref.child('handStatus').set(16);
                },
              ),
            ],
        ),
      ),
    ),
          );
          },
        listener: (context, state){}
    );
  }
}

class shapebuttons extends StatelessWidget {
  final String image1;
  final String image2;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;

  const shapebuttons(
      {Key? key,
      required this.image1,
      required this.image2,
      required this.onPressed1,
      required this.onPressed2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
            onPressed: onPressed1,
            child: Image.asset(
              image1,
              width: 150,
              height: 150,
            )),
        const SizedBox(
          height: 40.0,
        ),
        MaterialButton(
            onPressed: onPressed2,
            child: Image.asset(
              image2,
              width: 150,
              height: 150,
            )),
      ],
    );
  }
}
