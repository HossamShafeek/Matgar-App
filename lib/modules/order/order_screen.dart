import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/layout/animated_drawer.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class OrderScreen extends StatelessWidget {
  var formState = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessAddOrderState){
          navigatorReplacement(context, AnimatedDrawer());
          MotionToast.success(
            title: "Success",
            titleStyle: TextStyle(fontWeight: FontWeight.bold),
            description: 'Thanks For Your Order, '
                'it will be speedy, have a nice day.',
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
        return ModalProgressHUD(
          inAsyncCall: state is ShopLoadingAddAddressState,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Order',
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
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                          )),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: indigo,
                          ),
                          imageBuilder: (context, imageProvider) => CircleAvatar(
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
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formState,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: indigo,
                              thickness: 1.2,
                              indent: 10.0,
                              endIndent: 10.0,
                            ),
                          ),
                          Text(
                            'Enter Your Address',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: indigo,
                              thickness: 1.2,
                              indent: 10.0,
                              endIndent: 10.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        cursorColor: indigo,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Name',
                          prefixIcon: Icon(IconBroken.User),
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          errorBorder: enabledBorder,
                          focusedErrorBorder: focusedBorder,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: cityController,
                        cursorColor: indigo,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'City',
                          prefixIcon: Icon(IconBroken.Location),
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          errorBorder: enabledBorder,
                          focusedErrorBorder: focusedBorder,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: regionController,
                        cursorColor: indigo,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your region';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Region',
                          prefixIcon: Icon(IconBroken.Location),
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          errorBorder: enabledBorder,
                          focusedErrorBorder: focusedBorder,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: detailsController,
                        cursorColor: indigo,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your details';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Details',
                          prefixIcon: Icon(IconBroken.Document),
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          errorBorder: enabledBorder,
                          focusedErrorBorder: focusedBorder,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: notesController,
                        cursorColor: indigo,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your notes';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Notes',
                          prefixIcon: Icon(IconBroken.Paper),
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          errorBorder: enabledBorder,
                          focusedErrorBorder: focusedBorder,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                height: 135,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Price:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${cubit.cartsModel.data.total} EGP',
                            style: TextStyle(
                              color: indigo,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      gradientButton(
                        context: context,
                        onPressed: () {
                          if(formState.currentState.validate()){
                            cubit.addAddress(
                                name: nameController.text,
                                city: cityController.text,
                                region: regionController.text,
                                details: detailsController.text,
                                notes: notesController.text,
                            );
                          }
                        },
                        title: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 10,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
