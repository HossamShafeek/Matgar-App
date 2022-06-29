import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/product_details/product_details_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return AnimatedContainer(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          transform: Matrix4.translationValues(cubit.xOffset, cubit.yOffset, 0)
            ..scale(cubit.scaleFactor),
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(cubit.isOpenDrawer ? 20.0 : 0.0),
          ),
          child: cubit.homeModel != null && cubit.categoriesModel != null
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AppBar(
                        centerTitle: true,
                        backgroundColor: Colors.white,
                        leading: IconButton(
                          icon: cubit.isOpenDrawer
                              ? Icon(
                                  IconBroken.Arrow___Left_2,
                                  size: 35,
                                  color: indigo,
                                )
                              : Icon(
                                  IconBroken.Filter,
                                  size: 30,
                                  color: indigo,
                                ),
                          onPressed: () {
                            cubit.isOpenDrawer
                                ? cubit.closeDrawer()
                                : cubit.openDrawer();
                          },
                        ),
                        actions: [
                          InkWell(
                            onTap: () {
                              navigatorPush(context, ProfileScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: indigo,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 22.5,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        cubit.userModel.data.image,
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
                                      radius: 21,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 15.0, right: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, ${cubit.userModel.data.name}!',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Find Your Product',
                              style: TextStyle(fontSize: 20, color: indigo),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              onTap: (){
                                navigatorPush(context, SearchScreen());
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Search...',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        child: Icon(
                                          IconBroken.Search,
                                          color: indigo,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                'Categories',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            buildCategories(cubit.categoriesModel),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Most Popular',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'See All',
                                    style:
                                        TextStyle(color: indigo, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            BuildMostPopular(cubit.homeModel,cubit),
                            //BuildMostPopular(),
                          ],
                        ),
                      ),
                    ],
                  ))
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCategories(CategoriesModel model) {
    return Container(
      height: 80,
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: model.data.data.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10.0,
            );
          },
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: model.data.data[index].image,
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        )),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: indigo,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(model.data.data[index].name),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget BuildMostPopular(HomeModel model,ShopCubit cubit) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      itemCount: model.data.products.length,
      staggeredTileBuilder: (index) {
        return StaggeredTile.count(1, index.isEven ? 1.8 : 1.4);
      },
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            navigatorPush(context, ProductDetailsScreen());
            cubit.getProductDetailsModel(id: cubit.homeModel.data.products[index].id);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[50],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: model.data.products[index].image,
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        )),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: indigo,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      model.data.products[index].name,
                      maxLines: 2,
                      style: TextStyle(
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${model.data.products[index].price} EGP',
                        style: TextStyle(
                          color: indigo,
                          fontSize: 12,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          cubit.changeFavorites(model.data.products[index].id);
                        },
                        child: Icon(
                          IconBroken.Heart,
                          color: cubit.favorites[model.data.products[index].id]? Colors.red:Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
