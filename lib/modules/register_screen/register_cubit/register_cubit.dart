import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit(): super(InitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  bool obscure=false;
  Widget suffix=Icon(Icons.visibility_off);

  LoginModel? model;
  void changePasswordMode()
  {
    obscure =!obscure;
    suffix= obscure ? Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined);
    emit(changePasswordModeState());

  }

  void userRegister(
      {
        required String name,
        required String email,
        required String password,
        required String phone,
      })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      },
    ).then((value){
      model=LoginModel.fromJson(value?.data);

      emit(RegisterSuccessState(model!));
    }).catchError((error){
      emit(RegisterFilledState(error));
      print(error.toString());
    });
  }

}