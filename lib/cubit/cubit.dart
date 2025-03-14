import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/favourite_model/change_favourite_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

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

  void getHomeData() {
    emit(BazzHomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      model = HomeModel.fromJson(value!.data);

      model!.data!.products.forEach((element) {
        favourite.addAll({element.id!: element.inFavorites!});
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
}
