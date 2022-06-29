import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

var formState = GlobalKey<FormState>();

TextEditingController emailController = TextEditingController();

TextEditingController fullNameController = TextEditingController();

TextEditingController phoneController = TextEditingController();

void bottomSheetUpdateUserData(
    {@required BuildContext context, @required ShopCubit cubit}) {
  showBarModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (context) => Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                'Update Data',
                style: TextStyle(
                  color: indigo,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 35,
                ),
                child: Form(
                  key: formState,
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
                                backgroundImage: cubit.profileImage != null
                                    ? Image.file(
                                  cubit.profileImage,
                                  fit: BoxFit.cover,
                                ).image
                                    : NetworkImage(
                                    'https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-6.jpg'),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              child: IconButton(
                                splashRadius: 22,
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        actions: <Widget>[
                                          Center(
                                            child: Column(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    cubit
                                                        .getImageFromCamera()
                                                        .then((value) {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Icon(IconBroken.Camera),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text('Camera'),
                                                    ],
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    cubit
                                                        .getImageFromGallery()
                                                        .then((value) {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Icon(IconBroken.Image_2),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text('Gallery'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                ),
                                icon: Icon(IconBroken.Camera),
                              ),
                              radius: 22,
                              backgroundColor: Colors.grey[50],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
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
                          prefixIcon: Icon(IconBroken.User),
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
                        height: 20,
                      ),
                      gradientButton(
                        context: context,
                        title: Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          if (formState.currentState.validate()) {
                            cubit.updateUserFullName(
                              name: fullNameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              image: base64Image,
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}