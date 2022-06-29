import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class OrdersScreen extends StatelessWidget {
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
              'Orders',
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
          body: (state is! ShopLoadingGetOrdersState)
              ? ListView.separated(
                  padding: const EdgeInsets.all(15.0),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            onPressed: (context) {
                              cubit.cancelOrder(id: cubit.ordersModel.data.ordersDetails[index].id);
                              cubit.getOrders();
                            },
                            foregroundColor: Colors.red,
                            icon: IconBroken.Close_Square,
                            label: 'Cancel',
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ],
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[50],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('Date:'),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        cubit.ordersModel.data
                                            .ordersDetails[index].date,
                                        style: TextStyle(color: indigo),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Total:'),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        cubit.ordersModel.data
                                            .ordersDetails[index].total
                                            .toString(),
                                        style: TextStyle(color: indigo),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                cubit
                                    .ordersModel.data.ordersDetails[index].status,
                                style: TextStyle(color: cubit.ordersModel.data.ordersDetails[index].status=='New'?indigo:Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.0,
                    );
                  },
                  itemCount: cubit.ordersModel.data.ordersDetails.length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
