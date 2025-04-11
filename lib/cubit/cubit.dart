import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/favourite_model/change_favourite_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../models/cart_model/cart_model.dart';
import '../models/categories_model/categories_model.dart';
import '../models/favourite_model/get_favorites_models.dart';
import '../models/login_model/login_model.dart';
import '../modules/categories_screen/cateogries_screen.dart';
import '../modules/favourite_screen/favourite_screen.dart';
import '../modules/home_screen/home_screen.dart';
import '../modules/settings_screen/settings_screen.dart';
import '../shared/components/constants.dart';
import '../shared/network/remote/end_points.dart';

class BazzCubit extends Cubit<BazzStates> {
  BazzCubit() : super(InitialState());

  static BazzCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomIndexState());
  }

  HomeModel? model;
  Map<int, bool> favourite = {};
  Map<int, bool> cart = {};

  void getHomeData() {
    emit(BazzHomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      model = HomeModel.fromJson(value!.data);

      model!.data!.products.forEach((element) {
        favourite.addAll({element.id!: element.inFavorites!});
        cart.addAll({element.id!: element.inCart!});
      });
      emit(BazzHomeSuccessState());
      //print(model);
      print(favourite.toString());
    }).catchError((error) {
      print(error);
      emit(BazzHomeFilledState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value!.data);
      emit(BazzCategoriesModelSuccessState());
    }).catchError((error) {
      print(error);
      emit(BazzCategoriesModelFilledState(error));
    });
  }

  ChangeFavoriteModel? changeFavouriteModel;

  void changeFavorites(int productId) {
    favourite[productId] = !favourite[productId]!;
    emit(ChangeFavoriteState());
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {'product_id': productId}).then((value) {
      changeFavouriteModel = ChangeFavoriteModel.fromJson(value!.data);
      // print(favourite[productId]);
      if (!changeFavouriteModel!.status!) {
        favourite[productId] = !favourite[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ChangeFavoriteStateSuccess(changeFavouriteModel!));
    }).catchError((error) {
      favourite[productId] = !favourite[productId]!;
      emit(ChangeFavoriteStateError(error.toString()));
    });
  }

  ChangeFavoriteModel? changeCartModel;
  void changeCartItems(int productId) {
    cart[productId] = !cart[productId]!;
    emit(ChangeCartStateLoading());
    DioHelper.postData(
        url: CART,
        token: token,
        data: {'product_id': productId}).then((value) {
      changeCartModel = ChangeFavoriteModel.fromJson(value!.data);
      // print(favourite[productId]);
      if (!changeCartModel!.status!)
      {
        cart[productId] = !cart[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ChangeCartStateSuccess(changeCartModel!));
    }).catchError((error) {
      cart[productId] = !cart[productId]!;
      emit(ChangeCartStateError(error.toString()));
    });
  }

  GetFavorites? getFavorites;

  void getFavoritesData() {
    emit(GetFavoriteStateLoading());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      getFavorites = GetFavorites.fromJson(value!.data);
   //   print(getFavorites);
      emit(GetFavoriteStateSuccess());
    }).catchError((error) {
     // print(error);
      emit(GetFavoriteStateError(error));
    });
  }

  LoginModel? userModel;

  void getUserData() {
    emit(GetUserDataStateLoading());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel=LoginModel.fromJson(value!.data);
      print(userModel!.data!.name);
      emit(GetUserDataStateSuccess());
    }).catchError((error)
    {
      print(error);
      emit(GetUserDataStateError(error));
    });
  }
  void getUpdateUser(
  {
    required String name,
    required String email,
    required String phone,
}) {
    emit(GetUpdateUserStateLoading());
    DioHelper.putData(
      url: UPDATEPROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value)
    {
      userModel=LoginModel.fromJson(value!.data);
      print(userModel!.data!.name);
      emit(GetUpdateUserStateSuccess());
    }).catchError((error)
    {
      print(error);
      emit(GetUpdateUserStateError(error));
    });
  }
  bool isExpanded=true;
  void readMoreText()
  {
    isExpanded=!isExpanded;
    emit(ReadMoreTextState());
  }

  GetCartData? cartData;

  void getCartData() {
    emit(GetCartDataStateLoading());
    DioHelper.getData(
      url: CART,
      token: token,
    ).then((value) {
      print('Raw cart API response: ${value!.data}');
      cartData = GetCartData.fromJson(value!.data);
      print('Cart data fetched: ${cartData?.data?.cartItems?.length} items');
      emit(GetCartDataStateSuccess());
    }).catchError((error) {
      print('Error fetching cart data: $error');
      print('Error type: ${error.runtimeType}');
      emit(GetCartDataStateError(error.toString()));
    });
  }
  void deleteCartData({required int id})
  {
    emit(DeleteCartDataStateLoading());
    DioHelper.delData(
        url:"$DELETECART$id",
    token: token,
    ).then((value)
    {
      print(value);
      getCartData();
      emit(DeleteCartDataStateSuccess());
    }).catchError((error)
    {
      print(error);
      emit(DeleteCartDataStateError(error));

    });
  }
}
