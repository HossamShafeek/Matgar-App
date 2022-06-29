import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_app/models/carts_model.dart';
import 'package:shop_app/modules/order/order_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

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
              "My Cart",
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
          body: cubit.cartsModel.data.cartItems.length != 0
              ? buildItem(cubit.cartsModel.data.cartItems, cubit)
              : Padding(
                  padding: const EdgeInsets.only(bottom: 70.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/cart.png',
                        ),
                        Text('Cart is empty!'),
                      ],
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
                        if(cubit.cartsModel.data.total!=0){
                          navigatorPush(context, OrderScreen());
                        }
                      },
                      title: Text(
                        'CheckOut',
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
        );
      },
    );
  }

  buildItem(List<CartItems> model, ShopCubit cubit) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15.0),
      physics: BouncingScrollPhysics(),
      itemCount: model.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        child: Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                onPressed: (context) {
                  cubit.addAndRemoveFromCart(
                      cubit.cartsModel.data.cartItems[index].product.id);
                },
                foregroundColor: Colors.red,
                icon: IconBroken.Delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(8.0),
              ),
            ],
          ),
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
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if(cubit.cartsModel.data.cartItems[index].quantity>1){
                                      cubit.addQuantity(
                                          id: cubit.cartsModel.data
                                              .cartItems[index].id,
                                          quantity: cubit.cartsModel.data
                                              .cartItems[index].quantity-1);
                                    }else{
                                      cubit.addAndRemoveFromCart(
                                          cubit.cartsModel.data.cartItems[index].product.id);
                                    }
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    '${cubit.cartsModel.data.cartItems[index].quantity}',
                                    style:
                                        TextStyle(fontSize: 16, color: indigo),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    cubit.addQuantity(
                                        id: cubit.cartsModel.data
                                            .cartItems[index].id,
                                        quantity: cubit.cartsModel.data
                                            .cartItems[index].quantity+1);
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: indigo,
                                    size: 20,
                                  ),
                                ),
                              ],
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
