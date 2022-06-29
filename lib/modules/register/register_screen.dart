import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class RegisterScreen extends StatelessWidget {
  var formState = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>
        (
        listener: (context,state){
          if (state is RegisterSuccessState) {
            if (state.loginModel.status) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
              MotionToast.success(
                title: "Success",
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                description: state.loginModel.message,
                descriptionStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                animationType: ANIMATION.FROM_LEFT,
                position: MOTION_TOAST_POSITION.TOP,
                borderRadius: 10.0,
                width: 300,
                height: 65,
              ).show(context);
            } else {
              print(state.loginModel.message);
              MotionToast.error(
                title: "Error",
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                description: state.loginModel.message,
                descriptionStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                animationType: ANIMATION.FROM_LEFT,
                position: MOTION_TOAST_POSITION.TOP,
                borderRadius: 10.0,
                width: 300,
                height: 65,
              ).show(context);
            }
          }
        },
        builder: (context,state){
          return ModalProgressHUD(
            inAsyncCall: state is RegisterLoadingState,
            color: Colors.white,
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator(),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SvgPicture.asset(
                    'assets/images/bg.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.transparent,
                  body: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarIconBrightness: Brightness.dark),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Form(
                            key: formState,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Already have an account?',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(
                                      width: 0,
                                    ),
                                    TextButton(
                                        style: ButtonStyle(),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Sign In!',
                                          style: TextStyle(
                                              color: indigo,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: fullNameController,
                                  cursorColor: indigo,
                                  keyboardType: TextInputType.text,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Full Name',
                                    prefixIcon: Icon(IconBroken.Profile),
                                    enabledBorder: enabledBorder,
                                    focusedBorder: focusedBorder,
                                    errorBorder: enabledBorder,
                                    focusedErrorBorder: focusedBorder,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  cursorColor: indigo,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Email',
                                    prefixIcon: Icon(IconBroken.Message),
                                    enabledBorder: enabledBorder,
                                    focusedBorder: focusedBorder,
                                    errorBorder: enabledBorder,
                                    focusedErrorBorder: focusedBorder,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  cursorColor: indigo,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: RegisterCubit.get(context).isShowPassword,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Password is too short';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Password',
                                    prefixIcon: Icon(IconBroken.Unlock),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        RegisterCubit.get(context)
                                            .changePasswordVisibility();
                                      },
                                      child:
                                      RegisterCubit.get(context).isShowPassword
                                          ? Icon(IconBroken.Hide)
                                          : Icon(IconBroken.Show),
                                    ),
                                    enabledBorder: enabledBorder,
                                    focusedBorder: focusedBorder,
                                    errorBorder: enabledBorder,
                                    focusedErrorBorder: focusedBorder,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: phoneController,
                                  cursorColor: indigo,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 11,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Phone',
                                    prefixIcon: Icon(IconBroken.Call),
                                    enabledBorder: enabledBorder,
                                    focusedBorder: focusedBorder,
                                    errorBorder: enabledBorder,
                                    focusedErrorBorder: focusedBorder,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                gradientButton(
                                  context: context,
                                  onPressed: () {
                                    if(formState.currentState.validate()){
                                      RegisterCubit.get(context).userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          name: fullNameController.text,
                                      );
                                    }
                                  },
                                  title: Text(
                                    'Sign Up',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },

      ),
    );
  }
}
