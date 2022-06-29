import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=> BlocProvider.of(context);

  LoginModel loginModel;
  void userRegister({
    @required String email,
    @required String password,
    @required String phone,
    @required String name,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }

  bool isShowPassword = true;

  void changePasswordVisibility (){
    isShowPassword= !isShowPassword;
    emit(RegisterChangePasswordVisibilityState());
  }


}
