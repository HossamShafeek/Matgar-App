import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/layout/animated_drawer.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class LoginScreen extends StatelessWidget {
  var formState = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                print(state.loginModel.data.token);
                print('==============================');
                token=CacheHelper.getData(key: 'token');
                print(token);
                print('==============================');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return AnimatedDrawer();
                }));
                MotionToast.success(
                  title: "Success",
                  titleStyle: TextStyle(fontWeight: FontWeight.bold),
                  description: state.loginModel.message,
                  descriptionStyle: TextStyle(
                    //overflow: TextOverflow.ellipsis,
                  ),
                  animationType: ANIMATION.FROM_LEFT,
                  position: MOTION_TOAST_POSITION.TOP,
                  borderRadius: 10.0,
                  width: 300,
                  height: 65,
                ).show(context);
              });
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
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoginLoadingState,
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
                        child: Form(
                          key: formState,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Don’t have an account?',
                                    style: TextStyle(),
                                  ),
                                  SizedBox(
                                    width: 0,
                                  ),
                                  TextButton(
                                      style: ButtonStyle(),
                                      onPressed: () {
                                        navigatorPush(
                                            context, RegisterScreen());
                                      },
                                      child: Text(
                                        'Sign Up!',
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
                                controller: emailController,
                                cursorColor: indigo,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your email address';
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
                                obscureText:
                                    LoginCubit.get(context).isShowPassword,
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
                                      LoginCubit.get(context)
                                          .changePasswordVisibility();
                                    },
                                    child:
                                        LoginCubit.get(context).isShowPassword
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
                                height: 30.0,
                              ),
                              gradientButton(
                                  context: context,
                                  title: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  onPressed: () {
                                    if (formState.currentState.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  }),
                            ],
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
