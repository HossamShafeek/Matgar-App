import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatelessWidget {

  PageController indicatorController = PageController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          body: (state is !ShopLoadingGetProductDetailsState)? AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.black.withOpacity(0.3),
              statusBarIconBrightness: Brightness.light,
            ),
            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: cubit.productDetailsModel.productData.images.length,
                  itemBuilder: (context, index, n) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: cubit.productDetailsModel.productData.images[index],
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            strokeWidth: 3,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      cubit.onPageChange(index);
                    },
                    //autoPlay: true,
                    height: MediaQuery.of(context).size.height / 2.5,
                    viewportFraction: 1,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 260),
                    child: AnimatedSmoothIndicator(
                      count: cubit.productDetailsModel.productData.images.length,
                      activeIndex: cubit.activeIndex,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey[400],
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 5,
                        activeDotColor: indigo,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 35.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.3),
                    radius: 20,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        IconBroken.Arrow___Left_2,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ):Center(child: CircularProgressIndicator(),),

          floatingActionButton: (state is !ShopLoadingGetProductDetailsState)?FloatingActionButton(
              child: Icon(
                IconBroken.Heart,
                color: cubit.favorites[cubit.productDetailsModel.productData.id]?Colors.red:Colors.grey,
                size: 25,
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                cubit.changeFavorites(cubit.productDetailsModel.productData.id);
              }):Center(child: CircularProgressIndicator(),),

          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,


          bottomNavigationBar: (state is !ShopLoadingGetProductDetailsState)?BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 9.0,
            elevation: 30.0,
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  bottom: 20.0,
                  top: 30.0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.productDetailsModel.productData.name,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 5.0),
                      child: Text(
                        'About',
                        style: TextStyle(fontSize: 18,color: indigo),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Text(
                          cubit.productDetailsModel.productData.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text('${cubit.productDetailsModel.productData.price} EPG' ,style: TextStyle(fontSize: 18,color: indigo),),
                              Text('Price' ,style: TextStyle(fontSize: 15),),
                            ],
                          ),
                          SizedBox(width: 10.0,),
                          Expanded(
                            child: gradientButton(
                                context: context,
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    !cubit.carts[cubit.productDetailsModel.productData.id]?Text(
                                      'Add to cart',
                                      style: TextStyle(color: Colors.white,fontSize: 18,),
                                    ):Text(
                                      'In cart',
                                      style: TextStyle(color: Colors.white,fontSize: 18,),
                                    ),
                                    SizedBox(width: 5.0,),
                                    Icon(
                                      IconBroken.Buy,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  cubit.addAndRemoveFromCart(cubit.productDetailsModel.productData.id);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ):Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
