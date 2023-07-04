import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradution_project/layout/cubit/states.dart';
import 'package:gradution_project/screens/login/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../models/usermodel.dart';
import '../../shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage ;

import '../../shared/network/local/shared_pref.dart';

class ProjectCubit extends Cubit<ProjectStates> {
  ProjectCubit() : super(ProjectInitialState());

  static ProjectCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;


  void getUserData()async {
    emit(GetUserLoadingState());

   await FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      if (value.exists) {
        userModel = UserModel.fromJson(value.data() as Map<String, dynamic>);
        emit(GetUserSuccessState());
        print('*************************************************');
      } else {
        emit(GetUserErrorState('User not found'));
      }
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }


  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }




  void uploadProfileImage({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(UserUpdateLoadingState());


    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          email: email,
          image: value,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }


  void updateUser({
    required String name,
    required String phone,
    required String email,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email:email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
      bio: '',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(UserUpdateSuccessState());
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }



  bool isDark = true;
  void changeMode({ bool? fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(ChangeModeState());
    } else
    {
      isDark = !isDark;
      CachHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeState());
      });
    }
  }


  bool isEn = true;
  Map<String, Object> textsAr ={
    "hello":" مرحبا بك",
    "title": " ماذا تريد أن تفعل؟",
    "home-btn1": "التحكم بيدك كاملة",
    "home-btn2":"التحكم بكل إصبع",
    "home-btn3":"اصنع شكل",
    "home-btn4":"التحكم بزاوية اليد",
    "home-btn5":"التعليمات",
    "drawer1":"الصفحة الرئيسية",
    "drawer2":"الصفحة الشخصية",
    "drawer3":"المظهر الداكن",
    "drawer4":"العربية",
    "drawer4-1":"الإنجليزية",
    "drawer5":"من نحن",
    "drawer6":"تسجيل خروج",
    "page1-title":"التحكم بيدك كاملة",
    "page2-title":"التحكم بكل إصبع",
    "page3-title":"اصنع شكل",
    "page4-title":"التحكم بزاوية اليد",
    "page5-title":"التعليمات",
    "page6-title":"من نحن",
    "page6-headline":"نحن فريق هدفنا إيجاد أفضل الحلول للأشخاص الذين يعانون من بتر أو شلل اليد اليمنى بسبب إصابة الحبل الشوكي ، لأداء مهامهم اليومية دون أي عائق جسدي أو نفسي أمامهم وبأقل تكلفة ، ويمكنك التواصل مع أي من أعضاء الفريق",
    "page6-1":"منار عبد الرحمن محمد",
    "page6-1.1":"manarabdo972@gmail.com",
    "page6-2":"ولاء السيد جلال",
    "page6-2.1":"walaaalsayed242001@gmail.com",
    "page6-3":"يسرا ضياء مختار",
    "page6-3.1":"yossradiaa133@gmail.com",
    "page6-4":"منة الله عاطف محمد",
    "page6-4.1":"mennatullah327@gmail.com",
    "page6-5":"مي إبراهيم أحمد",
    "page6-5.1":"maiibrahim3355@gmail.com",
    "page1-btn1":"افتح يدك",
    "page1-btn2":"أغلق يدك",
    "page2-finger1":"إصبع الإبهام",
    "page2-finger2":"السبابة",
    "page2-finger3":"الاصبع الوسطى",
    "page2-finger4":"البنصر",
    "page2-finger5":"الاصبع الصغير",
    "page2-btn1":"افتح الاصبع",
    "page2-btn2":"أغلق إصبعك",
    "page3-title2":"اختر الشكل الذي تريده وانقر فوقه",
    "page4-title2":"تعليمات لإبقاء يدك تعمل بشكل جيد",
    "page4-ins1":"لا تقم بإزالة أي جزء من اليد",
    "page4-ins2":"استخدم جهد بطارية لا يقل عن 4.8 فولت ولا يزيد عن 6 فولت.",
    "page4-ins3":"تغيير حجارة البطارية كل أسبوع ",
    "page4-ins4":"تجنب تغيير السلك الذي يربط الأصابع معًا.",
    "page4-ins5":"لا تجعل أحدًا يزيل شيئًا من يدك ، معتقدًا أن هذا جيد ، قد يدمر يدك.",
    "page4-ins6":"لا تجعل الماء يلمس البطارية أو الأجزاء الداخلية ، فهو يدمرها.",
    "page4-ins7":"إذا كان لديك أي مشكلة يرجى الاتصال بنا.",
    "profile-btn":"تحديث البيانات",
    "profile-title":"صفحتي الشخصية",



  };
  Map<String, Object> textsEn ={
    "hello":"Hello",
    "title": "What Do You Want To Do ?",
    "home-btn1": "Control All Your Hand",
    "home-btn2":"Control Each Finger",
    "home-btn3":"Make A Shape",
    "home-btn4":"Hand angle control",
    "home-btn5":"Instructions",
    "drawer1":"Home",
    "drawer2":"Profile",
    "drawer3":"Dark Mode",
    "drawer4":"Arabic",
    "drawer4-1":"English",
    "drawer5":"About us",
    "drawer6":"Log Out",
    "page1-title":"Control All Your Hand",
    "page2-title":"Control Each Finger",
    "page3-title":"Make A Shape",
    "page4-title":"Hand angle control",
    "page5-title":"Instructions",
    "page6-title":"About Us",
    "page6-headline":"We are a team whose goal is to find the best solutions for people who suffer from amputation or paralysis of their right hand because of spinal cord injury, to perform their daily tasks without any physical or psychological hindrance in front of them at the lowest cost, and you can communicate with any of the team",
    "page6-1":"Manar Abd-ElRahman Muhammed ",
    "page6-1.1":"manarabdo972@gmail.com",
    "page6-2":"Walaa El-Sayed Galal",
    "page6-2.1":"walaaalsayed242001@gmail.com",
    "page6-3":"Yosra Diaa Mokhtar",
    "page6-3.1":"yossradiaa133@gmail.com",
    "page6-4":"Mennatullah Atef Muhammed",
    "page6-4.1":"mennatullah327@gmail.com",
    "page6-5":"Mai Ibrahim Ahmed",
    "page6-5.1":"maiibrahim3355@gmail.com",
    "page1-btn1":"Open Your Hand",
    "page1-btn2":"Close Your Hand",
    "page2-finger1":"Thumb",
    "page2-finger2":"Index Finger",
    "page2-finger3":"Middle Finger",
    "page2-finger4":"Ring Finger",
    "page2-finger5":"Little Finger",
    "page2-btn1":"Open",
    "page2-btn2":"Close",
    "page3-title2":"Choose Shape You Want and click on it",
    "page4-title2":"Instructions to Keep your hand work well",
    "page4-ins1":"Don\'t Remove Any part From hand",
    "page4-ins2":"Use battery voltage not about low 4.8 no more than 6 volt.",
    "page4-ins3":"Change Battery Supply Every Week ",
    "page4-ins4":"Avoid changing the wire that connects the fingers together.",
    "page4-ins5":"Don\’t make any one remove anything from your hand, thinking that is good ,that might destroy your hand.",
    "page4-ins6":"Don\’t Make water touch the battery or the inside  parts, it destroy it.",
    "page4-ins7":"If u have any problem please contact us.",
    "profile-btn":"Edit Profile",
    "profile-title":"My Profile",

  };

  changeLan(bool lan) async{
    isEn = lan;
    emit(ChangeLanState());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isEn", isEn);
  }

  getLan() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isEn = prefs.getBool("isEn")?? true;
    emit(GetLanState());
  }

  Object? getTexts(String txt) {
    if (isEn == true) return textsEn[txt];
    return textsAr[txt];
  }

/*getUser(){
  var user =  FirebaseAuth.instance.currentUser;
   return user?.displayName;
}*/
  bool isSignedIn = FirebaseAuth.instance.currentUser != null;


  Future<void>signOut()async{
    await FirebaseAuth.instance.signOut();
    User? currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser == null) {
      isSignedIn = false;
    }
    emit(signOutState());



}







}