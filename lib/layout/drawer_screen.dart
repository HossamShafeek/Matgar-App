import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/cart/cart_screen.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        ShopCubit cubit = ShopCubit.get(context);
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: indigo,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 45, left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35,
                      child: CachedNetworkImage(
                        imageUrl:cubit.userModel.data.image,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            )),
                        errorWidget: (context, url, error) => Icon(Icons.error,color: indigo,),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundImage: imageProvider,
                          radius: 32.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cubit.userModel.data.name,
                              maxLines: 1,
                              style: TextStyle(
                                //overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              cubit.userModel.data.email,
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                BuildButtons(context,cubit),
                Row(
                  children: [
                    Icon(
                      IconBroken.Logout,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        CacheHelper.removeData(key: 'token').then((value) {
                          cubit.closeDrawer();
                          navigatorReplacement(context, LoginScreen());
                        });
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget BuildButtons(context,ShopCubit cubit){
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              cubit.closeDrawer();
            },
            child: Row(
              children: [
                Icon(
                  IconBroken.Home,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              cubit.closeDrawer();
            },
            child: Row(
              children: [
                Icon(
                  IconBroken.Category,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Categories',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              navigatorPush(context, FavouritesScreen());
              cubit.closeDrawer();
            },
            child: Row(
              children: [
                Icon(
                  IconBroken.Heart,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Favorites',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              navigatorPush(context, SearchScreen());
              cubit.closeDrawer();
            },
            child: Row(
              children: [
                Icon(
                  IconBroken.Search,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Search',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              navigatorPush(context, CartScreen());
              cubit.closeDrawer();
            },
            child: Row(
              children: [
                Icon(
                  IconBroken.Buy,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Cart',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              navigatorPush(context, ProfileScreen());
              cubit.closeDrawer();
            },
            child: Row(
              children: [
                Icon(
                  IconBroken.Profile,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              navigatorPush(context, SettingsScreen());
              cubit.closeDrawer();
              cubit.getFAQs();
            },
            child: Row(
              children: [
                Icon(
                  IconBroken.Setting,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
