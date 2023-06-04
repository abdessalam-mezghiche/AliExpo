import 'package:aliexpo/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLodingState extends LoginStates {}

class LoginSuccesslState extends LoginStates {
  LoginModel? loginData;

  LoginSuccesslState(this.loginData);
}

class LoginErorrlState extends LoginStates {}

class LoginShangeIconPasswordlState extends LoginStates {}
