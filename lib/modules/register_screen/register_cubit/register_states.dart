import 'package:shop_app/models/login_model/login_model.dart';

abstract class RegisterStates {}

class InitialState extends RegisterStates {}

class changePasswordModeState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterFilledState extends RegisterStates {
  final error;

  RegisterFilledState(this.error);
}
