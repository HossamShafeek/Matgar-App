import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/modules/update_user_data/update_user_data_bottom_sheet.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateUserState) {
          if (state.userData.status) {
            MotionToast.success(
              title: "Success",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: state.userData.message,
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
            print(state.userData.message);
            MotionToast.error(
              title: "Error",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: state.userData.message,
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
        ShopCubit cubit = ShopCubit.get(context);

        return ModalProgressHUD(
          inAsyncCall: state is ShopLoadingUpdateUserState,
          color: Colors.white,
          opacity: 0.5,
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
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  centerTitle: true,
                  title: Text(
                    'Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      IconBroken.Arrow___Left_2,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        navigatorPush(context, SettingsScreen());
                        cubit.getFAQs();
                      },
                      icon: Icon(
                        IconBroken.Setting,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 88,
                              backgroundColor: indigo,
                              child: CircleAvatar(
                                radius: 84,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 80,
                                  child:  CachedNetworkImage(
                                    imageUrl:cubit
                                        .userModel.data.image !=
                                        null
                                        ?
                                    cubit.userModel.data.image:'https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-6.jpg',
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: indigo,
                                    ),
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                          backgroundImage: imageProvider,
                                          radius: 80,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                child: IconButton(
                                  splashRadius: 22,
                                  onPressed: () {
                                    bottomSheetUpdateUserData(context: context, cubit: cubit);
                                  },
                                  icon: Icon(IconBroken.Camera),
                                ),
                                radius: 22,
                                backgroundColor: Colors.grey[50],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            cubit.userModel.data.name,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Text(
                          cubit.userModel.data.email,
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        profileItem(
                            context: context,
                            title: 'Full Name',
                            content: cubit.userModel.data.name,
                            onTap: () {
                              bottomSheetUpdateUserData(context: context, cubit: cubit);
                            }),
                        profileItem(
                            context: context,
                            title: 'Email',
                            content: cubit.userModel.data.email,
                            onTap: () {
                              bottomSheetUpdateUserData(context: context, cubit: cubit);
                            }),
                        profileItem(
                            context: context,
                            title: 'phone',
                            content: cubit.userModel.data.phone,
                            onTap: () {
                              bottomSheetUpdateUserData(context: context, cubit: cubit);
                            }),
                        SizedBox(
                          height: 40,
                        ),
                        gradientButton(
                          context: context,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                IconBroken.Logout,
                                color: Colors.white,
                              )
                            ],
                          ),
                          onPressed: () {
                            logout(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}

