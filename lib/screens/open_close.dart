import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/layout/cubit/states.dart';

import '../layout/cubit/cubit.dart';
import '../shared/components/components.dart';

import 'package:firebase_database/firebase_database.dart';

import 'side_bar/navigation_drawer.dart';


class OpenCloseScreen extends StatelessWidget {
  final DBref = FirebaseDatabase.instance.ref();

  int? handStatus = 18;

  // int counter=0;
  getHandStatus() async {
    await DBref.child('HAND_STATUS').once().then((DatabaseEvent event) {
      handStatus = event.snapshot.value as int?;
      // counter = (event.snapshot.value as int?)?? 0 ;

      print(handStatus);
      //  print(counter);
      // print(event.snapshot);
    });

  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ProjectCubit,ProjectStates>(
        builder: (context,state){
      var lan = ProjectCubit.get(context);
      return Directionality(
        textDirection:lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
        drawer: Navigation(),
        appBar: AppBar(
          title: Text(lan.getTexts('page1-title') as String),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  child: Image.asset(
                    ProjectCubit.get(context).isDark
                        ? 'assets/images/logo1.png'
                        : 'assets/images/logo2.png',
                  ),
                ),
              ),
              Image.asset('assets/images/open2.png',width: 180,height: 180,),
              const SizedBox(
                height: 10.0,
              ),
              opencloseButtons(text: lan.getTexts('page1-btn1')as String, onPressed:  (){
                handStatus == 18
                    ? DBref.child('handStatus').set(17)
                    : DBref.child('handStatus').set(17);
              },),
              const SizedBox(
                height: 20.0,
              ),
              Image.asset('assets/images/closehand1.png',width: 180,height: 180,),
              const SizedBox(
                height: 10.0,
              ),
              opencloseButtons(text: lan.getTexts('page1-btn2')as String, onPressed:  (){
                handStatus == 17
                    ? DBref.child('handStatus').set(18)
                    : DBref.child('handStatus').set(18);
              },),
            ],
          ),
        ),
    ),
      );},
        listener:  (context,state){},
    );
  }
}

class opencloseButtons  extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const opencloseButtons ({Key? key,  required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height * .08,

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
        onPressed: onPressed,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  text,
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
    );
  }
}
