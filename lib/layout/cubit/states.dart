import 'package:gradution_project/models/usermodel.dart';

abstract class ProjectStates {}

class ProjectInitialState extends ProjectStates {}
class GetUserLoadingState extends ProjectStates {}

class BottomNavBarState extends ProjectStates {}

class GetUserSuccessState extends ProjectStates {

}

class GetUserErrorState extends ProjectStates
{
  final String error;

  GetUserErrorState(this.error);
}

class GetAllUsersLoadingState extends ProjectStates {}

class GetAllUsersSuccessState extends ProjectStates {}

class GetAllUsersErrorState extends ProjectStates
{
  final String error;

  GetAllUsersErrorState(this.error);
}




class ProfileImagePickedSuccessState extends ProjectStates {}

class ProfileImagePickedErrorState extends ProjectStates {}

class CoverImagePickedSuccessState extends ProjectStates {}

class CoverImagePickedErrorState extends ProjectStates {}

class UploadProfileImageSuccessState extends ProjectStates {}

class UploadProfileImageErrorState extends ProjectStates {}

class UploadCoverImageSuccessState extends ProjectStates {}

class UploadCoverImageErrorState extends ProjectStates {}

class UserUpdateLoadingState extends ProjectStates {}

class UserUpdateErrorState extends ProjectStates {}
class UserUpdateSuccessState extends ProjectStates {}

class ChangeModeState extends ProjectStates{}

class ChangeLanState extends ProjectStates{}

class GetLanState extends ProjectStates{}

class signOutState extends ProjectStates{}