import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          appBar: AppBar(
            titleSpacing: 0,
            title: TextFormField(
              onEditingComplete: () {
                if(searchController.text.isEmpty){
                  return null;
                }
                else
                {
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
                  if(searchController.text.isEmpty){
                    return null;
                  }
                  else
                  {
                  }
                },
                icon: Icon(IconBroken.Search,color: indigo,size: 30,),
              )
            ],
          ),
          body: Column(
            children: [
            ],
          ),
        );
      },
    );
  }
}