import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/modules/change_password/change_password_bottom_sheet.dart';
import 'package:shop_app/modules/contact_me/contact_me_bottom_sheet.dart';
import 'package:shop_app/modules/orders/orders_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangePasswordState){
          if(state.changePasswordModel.status){
            MotionToast.success(
              title: "Success",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: state.changePasswordModel.message,
              descriptionStyle: TextStyle(
                //overflow: TextOverflow.ellipsis,
              ),
              animationType: ANIMATION.FROM_LEFT,
              position: MOTION_TOAST_POSITION.TOP,
              borderRadius: 10.0,
              width: 300,
              height: 65,
            ).show(context);
          }
        }else if(state is ShopErrorChangePasswordState){
          MotionToast.error(
            title: "Error",
            titleStyle: TextStyle(fontWeight: FontWeight.bold),
            description: state.error,
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
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Settings',
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.indigo,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: InkWell(
                  onTap: () {
                    navigatorPush(context, ProfileScreen());
                  },
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: indigo,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 22.5,
                      child: CachedNetworkImage(
                        imageUrl: cubit.userModel.data.image,
                        placeholder: (context, url) =>
                            Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                )),
                        errorWidget: (context, url, error) =>
                            Icon(
                              Icons.error,
                              color: indigo,
                            ),
                        imageBuilder: (context, imageProvider) =>
                            CircleAvatar(
                              backgroundImage: imageProvider,
                              radius: 21,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: (state is! ShopLoadingGetFAQsState) ? ModalProgressHUD(
            inAsyncCall: state is ShopLoadingChangePasswordState,
            color: Colors.white,
            opacity: 0.5,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        'Account',
                        style: TextStyle(
                          color: indigo,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        navigatorPush(context, ProfileScreen());
                      },
                      dense: true,
                      horizontalTitleGap: -4,
                      //minLeadingWidth: 0,
                      minVerticalPadding: 15.0,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      tileColor: Colors.grey[50],
                      leading: Icon(
                        IconBroken.Profile,
                        color: indigo,
                        size: 26,
                      ),
                      title: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: Icon(
                        IconBroken.Arrow___Right_2,
                        color: indigo,
                        size: 26,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      onTap: () {
                        bottomSheetChangePassword(context: context, cubit: cubit);
                      },
                      dense: true,
                      horizontalTitleGap: -4,
                      //minLeadingWidth: 0,
                      minVerticalPadding: 15.0,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      tileColor: Colors.grey[50],
                      leading: Icon(
                        IconBroken.Password,
                        color: indigo,
                        size: 26,
                      ),
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: Icon(
                        IconBroken.Arrow___Right_2,
                        color: indigo,
                        size: 26,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      onTap: () {
                        navigatorPush(context, OrdersScreen());
                        cubit.getOrders();
                      },
                      dense: true,
                      horizontalTitleGap: -4,
                      //minLeadingWidth: 0,
                      minVerticalPadding: 15.0,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      tileColor: Colors.grey[50],
                      leading: Icon(
                        IconBroken.Buy,
                        color: indigo,
                        size: 26,
                      ),
                      title: Text(
                        'Orders',
                        style: TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: Icon(
                        IconBroken.Arrow___Right_2,
                        color: indigo,
                        size: 26,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Legal',
                        style: TextStyle(
                          color: indigo,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      horizontalTitleGap: -4,
                      //minLeadingWidth: 0,
                      minVerticalPadding: 15.0,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      tileColor: Colors.grey[50],
                      leading: Icon(
                        IconBroken.Shield_Done,
                        color: indigo,
                        size: 26,
                      ),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: Icon(
                        IconBroken.Arrow___Right_2,
                        color: indigo,
                        size: 26,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      onTap: () {
                        bottomSheetContactMe(context: context, cubit: cubit);
                      },
                      dense: true,
                      horizontalTitleGap: -4,
                      //minLeadingWidth: 0,
                      minVerticalPadding: 15.0,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      tileColor: Colors.grey[50],
                      leading: Icon(
                        IconBroken.Activity,
                        color: indigo,
                        size: 26,
                      ),
                      title: Text(
                        'Contact Me',
                        style: TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: Icon(
                        IconBroken.Arrow___Right_2,
                        color: indigo,
                        size: 26,
                      ),
                    ),
                    // SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'FAQ',
                        style: TextStyle(
                          color: indigo,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.faqsModel.data.faqsDetails.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: ExpansionTile(
                            backgroundColor: Colors.grey[50],
                            collapsedBackgroundColor: Colors.grey[50],
                            iconColor: indigo,
                            childrenPadding: EdgeInsets.only(
                                left: 15.0, right: 15.0, bottom: 15.0),
                            collapsedIconColor: indigo,
                            tilePadding: EdgeInsets.symmetric(horizontal: 10.0),
                            controlAffinity: ListTileControlAffinity.trailing,
                            trailing: cubit.expansionIcon
                                ? Icon(IconBroken.Arrow___Up_2)
                                : Icon(IconBroken.Arrow___Down_2),
                            title: Row(
                              children: [
                                Icon(IconBroken.Info_Circle, color: indigo,
                                  size: 26,),
                                SizedBox(width: 10.0,),
                                Text(
                                  cubit.faqsModel.data.faqsDetails[index]
                                      .question,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            children: [
                              Text(
                                  cubit.faqsModel.data.faqsDetails[index].answer),
                            ],
                            onExpansionChanged: (value) {
                              cubit.changeExpansionIcon(value);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10.0,);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ) : Center(child: CircularProgressIndicator(),),
          bottomNavigationBar: BottomAppBar(
            elevation: 10,
            color: Colors.white,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: gradientButton(
                context: context,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
            ),
          ),
        );
      },
    );
  }
}
