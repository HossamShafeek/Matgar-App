import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/drawer_screen.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class AnimatedDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: cubit.isOpenDrawer?SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ):SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: Stack(
              children: [
                DrawerScreen(),
                AnimatedContainer(
                  transform: Matrix4.translationValues(cubit.xOffset2, cubit.yOffset2, 0)
                    ..scale(cubit.scaleFactor2),
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(cubit.isOpenDrawer ? 20 : 0.0)),
                ),
                HomeLayout()
              ],
            ),
          ),
        );
      },
    );
  }
}
