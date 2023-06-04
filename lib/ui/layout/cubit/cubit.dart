import 'package:aliexpo/ui/layout/cubit/states.dart';
import 'package:aliexpo/data/models/categories_model.dart';
import 'package:aliexpo/data/models/favorites_model.dart';
import 'package:aliexpo/data/models/home_model.dart';
import 'package:aliexpo/ui/modules/account/account.dart';
import 'package:aliexpo/ui/modules/cart/cart.dart';
import 'package:aliexpo/ui/modules/categories/categories.dart';
import 'package:aliexpo/ui/modules/favorite/favorite.dart';
import 'package:aliexpo/ui/modules/home/home.dart';
import 'package:aliexpo/ui/shared/components/constants.dart';
import 'package:aliexpo/data/network/end_ponts.dart';
import 'package:aliexpo/data/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> itmes = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outline), label: 'Favorite'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.perm_identity), label: 'Account'),
  ];

  List<Widget> screens = [
    const Home(),
    const Categories(),
    const Favorite(),
    const Cart(),
    const Account()
  ];

  int index = 2;

  HomeModel? homeData;

  CategoriesModel? categoriesData;

  void onNavigation({required int indexChange}) {
    index = indexChange;
    emit(ShopNavigationState());
  }

  Map<int, bool?> isFavorite = {};
  void getData() {
    emit(HomeLodingState());
    Diohelper.getData(url: HOME, token: token)?.then((value) {
      homeData = HomeModel.fromJson(value.data);
      homeData!.data?.products?.forEach((element) {
        isFavorite.addAll({element.id: element.inFavorites});
      });

      emit(HomeSuccesslState(homeData));
    }).catchError((error) {
      print('>>error>>${error.toString()}');
      emit(HomeErorrlState());
    });
  }

  void getCategories() {
    print('get Data categories >_<');
    emit(CategoriesLodingState());
    Diohelper.getData(url: CATEGORIES)?.then((value) {
      categoriesData = CategoriesModel.fromJson(value.data);
      print('>>categories Data>>${categoriesData?.status}');
      emit(CategoriesSuccesslState(homeData));
    }).catchError((error) {
      print('>>error>>${error.toString()}');
      emit(CategoriesErorrlState());
    });
  }

  changeFavoritesData? dataFavorites;
  void changeFavorites(productId, index) {
    print(' --------|01|----------  ');

    emit(FavoritesLodingState());
    Diohelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        ?.then((value) {
      print(' --------|02| $token----------  ');
      dataFavorites = changeFavoritesData.fromJson(value.data);
      if (dataFavorites?.status == true) {
        print(' --------|03|----------  ');
        emit(FavoritesSuccesslState(dataFavorites?.message));
      } else {
        print(' --------|04| ${dataFavorites?.message}----------  ');
        homeData?.data?.products![index].inFavorites =
            !(homeData?.data?.products![index].inFavorites)!;
        emit(FavoritesSuccessFalselState(dataFavorites?.message));
      }
    }).catchError((error) {
      print(' --------|05|----------  ');
      homeData?.data?.products![index].inFavorites =
          !(homeData?.data?.products![index].inFavorites)!;
      emit(FavoritesErorrlState(dataFavorites?.message));
    });
  }
}
