import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/modules/product_details/product_details_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Favourites",
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: indigo,
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
                  onTap: (){
                    navigatorPush(context, ProfileScreen());
                  },
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: indigo,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 22.5,
                      child: CachedNetworkImage(
                        imageUrl:cubit.userModel.data.image,
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
          body: cubit.favouritesModel.data.data.length != 0
              ? buildItem(cubit.favouritesModel.data.data, cubit)
              : Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/nodata.png',
                        ),
                        Text('Favorites are empty!'),
                      ],
                    ),
                  ),
              ),
        );
      },
    );
  }

  buildItem(List<FavouritesData> model, ShopCubit cubit) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15.0),
      physics: BouncingScrollPhysics(),
      itemCount: model.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        child: InkWell(
          onTap: () {
            navigatorPush(context, ProductDetailsScreen());
            cubit.getProductDetailsModel(id: model[index].product.id);
          },
          child: Container(
            width: double.infinity,
            height: 105,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[50],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: 90,
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: model[index].product.image,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: indigo,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model[index].product.name,
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${model[index].product.price} EGP',
                              style: TextStyle(
                                color: indigo,
                                fontSize: 12,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cubit.changeFavorites(model[index].product.id);
                              },
                              child: Icon(
                                IconBroken.Heart,
                                color: cubit.favorites[model[index].product.id]
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
