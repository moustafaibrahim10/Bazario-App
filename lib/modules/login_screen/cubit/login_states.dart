import 'package:shop_app/models/login_model/login_model.dart';

abstract class LoginStates {}

class InitialState extends LoginStates {}

class changePasswordModeState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginmodel;

  LoginSuccessState(this.loginmodel);
}

class LoginFilledState extends LoginStates {
  final error;

  LoginFilledState(this.error);
}
