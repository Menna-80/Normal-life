

import 'package:firebase_auth/firebase_auth.dart';

import '../../screens/login/login.dart';
import '../network/local/shared_pref.dart';
import 'components.dart';

void signOut(context){
  CachHelper.removeData(key: 'uId').then((value) {
            if(value==true){
              NavigateAndReplace(context, LoginScreen());
            }
          });
}

void printFullData(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) =>print(element.group(0)));
}

String? uId = FirebaseAuth.instance.currentUser?.uid;