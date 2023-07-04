
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/layout/cubit/states.dart';
import 'package:gradution_project/models/usermodel.dart';
import 'package:gradution_project/screens/shape.dart';
import 'package:gradution_project/screens/web_view/web_view_screen.dart';
import 'package:gradution_project/shared/styles/colors.dart';

import '../layout/cubit/cubit.dart';
import '../shared/components/components.dart';
import 'fingers.dart';
import 'instructions.dart';
import 'side_bar/navigation_drawer.dart';
import 'open_close.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {
          if(state is GetUserSuccessState) {
            ProjectCubit.get(context).getUserData();
          }

        },
        builder:  (context, state) {
          return ConditionalBuilder(
              condition: ProjectCubit.get(context).userModel != null,
              builder: (context)=>Homebulider(ProjectCubit.get(context).userModel, context),
              fallback: (context)=> Center(child: CircularProgressIndicator()),
          );
        },
      );
  }
}
Widget Homebulider(UserModel? model, context){
  var lan = ProjectCubit.get(context);
  return Directionality(
    textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
    child: Scaffold(
      drawer: Navigation(),
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child:Image.asset(
                    ProjectCubit.get(context).isDark ?  'assets/images/logo1.png':'assets/images/logo2.png',
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: lan.getTexts('hello')as String, style:  TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:lan.isDark? Colors.white : Colors.black
                    ),),
                    TextSpan(text: ' ${model?.name}', style:  TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500, color:lan.isDark? Colors.white : Colors.black
                    ), ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                lan.getTexts('title') as String,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Textcolor),
              ),
              const SizedBox(
                height: 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Buttons(text: lan.getTexts('home-btn1') as String, image: 'assets/images/close1.jpeg', onPressed: (){
                    NavigateTo(context,  OpenCloseScreen());
                  },),
                  const SizedBox(height: 30.0,),
                  Buttons(text: lan.getTexts('home-btn2') as String, image: 'assets/images/finger3.jpeg', onPressed: (){
                    NavigateTo(context,  FingersScreen());
                  },),
                  const SizedBox(height: 30.0,),
                  Buttons(text: lan.getTexts('home-btn3') as String, image: 'assets/images/shape.jpeg', onPressed: (){
                    NavigateTo(context, ShapeScreen());
                  },),
                  const SizedBox(height: 30.0,),
                  Buttons(text:  lan.getTexts('home-btn4') as String, image: 'assets/images/shape3.png', onPressed: (){
                    NavigateTo(context, WebViewScreen('http://192.168.1.21'));
                  },),
                  const SizedBox(height: 30.0,),
                  Buttons(text:  lan.getTexts('home-btn5') as String, image: 'assets/images/instructions.jpeg', onPressed: (){
                    NavigateTo(context,  const InstructionScreen());
                  },),



                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
class Buttons extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onPressed;

  const Buttons({Key? key, required this.text, required this.image, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .1,

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
          children:  [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 120,
            ),
            CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(
                image,
              ),
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

}
