
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../shared/network/local/shared_pref.dart';
import 'login/login.dart';

class BoardingModel {
  String? image;
  String? title;
  String? logo;

  BoardingModel({
    required this.image,
    required this.title,
    required this.logo,

  });
}

class OnBoardScreen extends StatefulWidget {

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var boardController = PageController();
  bool isLast = false;
  void submit()
  {
    CachHelper.saveData(value: true, key: 'OnBoarding').then((value) {
      if(value==true)
      {
        NavigateAndReplace(context, LoginScreen());
      }
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/1.jpeg',
        logo:'assets/images/logo2.png' ,
        title: 'Hi, be safe with us and don\'t worry about anything'),
    BoardingModel(
        image: 'assets/images/2.jpeg',
        logo:'assets/images/logo2.png' ,
        title: 'Through this application, you can control your hand with ease'),
    BoardingModel(
        image: 'assets/images/3.png',
        logo:'assets/images/logo2.png' ,
        title: 'Our aim is to have well control for your hand'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defualtTextButton(
            function: submit,
            text: 'Skip',
          ),
        //  Image.asset('assets/images/logo.jpeg'),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [

            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildboardingitem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: CustomizableEffect(
                    spacing: 5.0,
                    dotDecoration: DotDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey,
                      verticalOffset: 5.0,
                      rotationAngle: 50.0,
                      height: 10,
                      width: 10,
                    ),
                    activeDotDecoration: DotDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: defaultcolor,
                      width: 30,
                      height: 10,
                    ),
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          microseconds: 850,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildboardingitem(BoardingModel model) => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Container(
      height: 200.0,
      width: 200.0,

      child: Image(
        image: AssetImage('${model.logo}',
        ),

      ),
    ),
    SizedBox(
      height: 10.0,
    ),
    Text(
      '${model.title}',
      style: const TextStyle(fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: Textcolor,
      ),
    ),
    SizedBox(
      height: 20.0,
    ),
    Expanded(
      child: Image(
        image: AssetImage('${model.image}'),
      ),
    ),
    SizedBox(
      height: 30.0,
    ),


  ],
);
