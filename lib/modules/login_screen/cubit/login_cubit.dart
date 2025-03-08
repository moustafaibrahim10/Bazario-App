import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login_screen/cubit/login_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit(): super(InitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool obscure=false;
  Widget suffix=Icon(Icons.visibility_off);

  LoginModel? model;
  void changePasswordMode()
  {
    obscure =!obscure;
    suffix= obscure ? Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined);
    emit(changePasswordModeState());

  }

 void userLogin(
  {
    required String email,
    required String password,
})
 {
   emit(LoginLoadingState());
   DioHelper.postData(
       url: LOGIN,
       data: {
         'email':email,
         'password':password,
       },
   ).then((value){
     model=LoginModel.fromJson(value?.data);

     emit(LoginSuccessState(model!));
   }).catchError((error){
     emit(LoginFilledState(error));
     print(error.toString());
   });
 }

}