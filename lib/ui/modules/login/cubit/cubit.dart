import 'package:aliexpo/data/models/login_model.dart';
import 'package:aliexpo/ui/modules/login/cubit/states.dart';
import 'package:aliexpo/data/network/end_ponts.dart';
import 'package:aliexpo/data/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  bool isPassword = true;

  LoginModel? userData;

  static LoginCubit get(context) => BlocProvider.of(context);

  void ChangePasswordShow() {
    isPassword = !isPassword;
    emit(LoginShangeIconPasswordlState());
  }

  void Login({required String email, required String password}) {
    emit(LoginLodingState());
    Diohelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        ?.then((value) {
      userData = LoginModel.formaJson(value.data);
      print('value >>>$value');
      print('value.data >>>${value.data}');
      emit(LoginSuccesslState(userData));
    }).catchError((onError) {
      print('error >>>${onError.toString()}');
      emit(LoginErorrlState());
    });
  }
}
