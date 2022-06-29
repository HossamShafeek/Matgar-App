import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/models/carts_model.dart';
import 'package:shop_app/models/change_carts_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/change_password_model.dart';
import 'package:shop_app/models/faqs_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/orders_model.dart';
import 'package:shop_app/models/product_details_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  HomeModel homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorite});
      });
      homeModel.data.products.forEach((element) {
        carts.addAll({element.id: element.inCart});
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error.toString()));
      print(error.toString());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState(error.toString()));
      print(error.toString());
    });
  }

  Map<int, bool> favorites = {};

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopSuccessChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoritesState(error.toString()));
      print(error.toString());
    });
  }

  FavouritesModel favouritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState(error.toString()));
      print(error.toString());
    });
  }

  Map<int, bool> carts = {};

  ChangeCartsModel changeCartsModel;

  void addAndRemoveFromCart(int productId) {
    carts[productId] = !carts[productId];
    emit(ShopSuccessAddAndRemoveFromCartState());
    DioHelper.postData(
      url: CARTS,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeCartsModel = ChangeCartsModel.fromJson(value.data);
      if (!changeCartsModel.status) {
        carts[productId] = !carts[productId];
      } else {
        getCarts();
      }
      print(changeCartsModel.message);
      emit(ShopSuccessAddAndRemoveFromCartState());
    }).catchError((error) {
      carts[productId] = !carts[productId];
      emit(ShopErrorAddAndRemoveFromCartState(error.toString()));
      print(error.toString());
    });
  }

  CartsModel cartsModel;

  void getCarts() {
    emit(ShopLoadingGetCartsState());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      cartsModel = CartsModel.fromJson(value.data);
      emit(ShopSuccessGetCartsState());
    }).catchError((error) {
      emit(ShopErrorGetCartsState(error.toString()));
      print(error.toString());
    });
  }

  void addQuantity({@required int id, @required int quantity}) {
    DioHelper.putData(
        url: 'carts/${id}',
        token: token,
        data: {'quantity': quantity}).then((value) {
      getCarts();
      emit(ShopSuccessAddQuantityState());
    }).catchError((error) {
      emit(ShopErrorAddQuantityState(error.toString()));
    });
  }

  LoginModel userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      emit(ShopErrorGetUserDataState(error.toString()));
      print(error.toString());
    });
  }

  void updateUserFullName(
      {@required String name,
      @required email,
      @required phone,
      @required image}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image
    }).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState(error.toString()));
      print(error.toString());
    });
  }

  ProductDetailsModel productDetailsModel;

  void getProductDetailsModel({
    int id,
  }) {
    emit(ShopLoadingGetProductDetailsState());
    DioHelper.getData(
      url: 'products/$id',
      token: token,
    ).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ShopSuccessGetProductDetailsState());
    }).catchError((error) {
      emit(ShopErrorGetProductDetailsState(error.toString()));
      print(error.toString());
    });
  }

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ShopChangeModeState());
      });
    }
  }

  void addAddress({
    @required String name,
    @required String city,
    @required String region,
    @required String details,
    @required String notes,
  }) {
    emit(ShopLoadingAddAddressState());
    DioHelper.postData(
      url: ADDRESS,
      token: token,
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': '3123123',
        'longitude': '2121545',
      },
    ).then((value) {
      addOrder(idAddress: value.data['data']['id']);
      emit(ShopSuccessAddAddressState());
    }).catchError((error) {
      emit(ShopErrorAddAddressState(error.toString()));
      print(error.toString());
    });
  }

  void addOrder({
    @required int idAddress,
  }) {
    emit(ShopLoadingAddOrderState());
    DioHelper.postData(
      url: ORDERS,
      token: token,
      data: {
        'address_id': idAddress,
        'payment_method': 1,
        'use_points': false,
      },
    ).then((value) {
      getCarts();
      emit(ShopSuccessAddOrderState());
    }).catchError((error) {
      emit(ShopErrorAddOrderState(error.toString()));
    });
  }

  FaqsModel faqsModel;

  void getFAQs() {
    emit(ShopLoadingGetFAQsState());
    DioHelper.getData(
      url: FAQS,
    ).then((value) {
      faqsModel = FaqsModel.fromJson(value.data);
      emit(ShopSuccessGetFAQsState());
    }).catchError((error) {
      emit(ShopErrorGetFAQsState(error.toString()));
    });
  }

  bool expansionIcon = false;

  void changeExpansionIcon(bool value) {
    expansionIcon = value;
    emit(ShopChangeExpansionIconState());
  }

  OrdersModel ordersModel;

  void getOrders() {
    emit(ShopLoadingGetOrdersState());
    DioHelper.getData(
      url: ORDERS,
      token: token,
    ).then((value) {
      ordersModel = OrdersModel.fromJson(value.data);
      emit(ShopSuccessGetOrdersState());
    }).catchError((error) {
      emit(ShopErrorGetOrdersState(error.toString()));
    });
  }

  void cancelOrder({@required int id}) {
    DioHelper.getData(
      url: 'orders/${id}/cancel',
      token: token,
    ).then((value) {
      emit(ShopSuccessCancelOrderState());
    }).catchError((error) {
      emit(ShopErrorCancelOrderState());
    });
  }

  bool isShowPassword1 = true;

  void changePasswordVisibility1() {
    isShowPassword1 = !isShowPassword1;
    emit(ShopChangePasswordVisibility1State());
  }

  bool isShowPassword2 = true;

  void changePasswordVisibility2() {
    isShowPassword2 = !isShowPassword2;
    emit(ShopChangePasswordVisibility2State());
  }

  ChangePasswordModel changePasswordModel;

  void changePassword({
    @required String currentPassword,
    @required String newPassword,
  }) {
    emit(ShopLoadingChangePasswordState());
    DioHelper.postData(
      url: CHANGE_PASSWORD,
      token: token,
      data: {
        'current_password':currentPassword,
        'new_password':newPassword,
      },
    ).then((value) {
      changePasswordModel=ChangePasswordModel.fromJson(value.data);
      print('=======================================');
      print(value.data);
      print('=======================================');
      emit(ShopSuccessChangePasswordState(changePasswordModel));
    }).catchError((error){
      emit(ShopErrorChangePasswordState(error.toString()));
      print(error.toString());
    });
  }

  SearchModel searchModel;

  void search({@required String text}) {
    emit(ShopLoadingSearchState());
    DioHelper.postData(
      url: PRODUCTS_SEARCH,
      token: token,
      data: {
        'text':text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchState());
    }).catchError((error){
      emit(ShopErrorSearchState(error.toString()));
    });
  }

  File profileImage;

  final picker = ImagePicker();

  // Implementing the image picker
  Future<void> getImageFromGallery() async {
    final XFile pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      List<int> imageBytes = profileImage.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      print('***************************');
      print(base64Image);
      print('***************************');
      emit(ShopProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ShopProfileImagePickedErrorState());
    }
  }

  Future<void> getImageFromCamera() async {
    final XFile pickedImage = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 1800, maxWidth: 1800);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      List<int> imageBytes = profileImage.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      emit(ShopProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ShopProfileImagePickedErrorState());
    }
  }

  int activeIndex = 0;

  void onPageChange(int index) {
    activeIndex = index;
    emit(ShopOnPageChangeState());
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isOpenDrawer = false;

  double xOffset2 = 0;
  double yOffset2 = 0;
  double scaleFactor2 = 1;

  void openDrawer() {
    xOffset = 230;
    yOffset = 130;
    scaleFactor = 0.7;

    isOpenDrawer = true;

    xOffset2 = 205;
    yOffset2 = 170;
    scaleFactor2 = 0.6;
    emit(OpenDrawerState());
  }

  void closeDrawer() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;

    isOpenDrawer = false;

    xOffset2 = 0;
    yOffset2 = 0;
    scaleFactor2 = 1;
    emit(CloseDrawerState());
  }
}
