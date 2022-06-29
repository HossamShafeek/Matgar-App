import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/product_details/product_details_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  Widget actionIcon = Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            titleSpacing: 0,
            title: TextFormField(
              onEditingComplete: () {
                if (searchController.text.isEmpty) {
                  return null;
                } else {
                  cubit.search(text: searchController.text);
                }
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Search must not be empty';
                }
                return null;
              },
              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
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
              IconButton(
                onPressed: () {
                  if (searchController.text.isEmpty) {
                    return null;
                  } else {
                    cubit.search(text: searchController.text);
                  }
                },
                icon: Icon(
                  IconBroken.Search,
                  color: indigo,
                  size: 30,
                ),
              )
            ],
          ),
          body: cubit.searchModel != null
              ? ModalProgressHUD(
            inAsyncCall: state is ShopLoadingSearchState,
            color: Colors.white,
            opacity: 0.5,
                  child: buildItem(cubit.searchModel.data.data, cubit),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 70.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/search.png',
                        ),
                        Text('Search now!'),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  buildItem(List<Product> model, ShopCubit cubit) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15.0),
      physics: BouncingScrollPhysics(),
      itemCount: model.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        child: InkWell(
          onTap: () {
            navigatorPush(context, ProductDetailsScreen());
            cubit.getProductDetailsModel(id: model[index].id);
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
                      imageUrl: model[index].image,
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
                          model[index].name,
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${model[index].price} EGP',
                              style: TextStyle(
                                color: indigo,
                                fontSize: 12,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cubit.changeFavorites(model[index].id);
                              },
                              child: Icon(
                                IconBroken.Heart,
                                color: cubit.favorites[model[index].id]
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
