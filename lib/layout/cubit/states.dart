import 'package:aliexpo/models/home_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopNavigationState extends ShopStates {}

class ShopSearchNavigateState extends ShopStates {}

// Home
class HomeLodingState extends ShopStates {}

class HomeSuccesslState extends ShopStates {
  HomeModel? homeData;

  HomeSuccesslState(this.homeData);
}

class HomeErorrlState extends ShopStates {}

// Categories

class CategoriesLodingState extends ShopStates {}

class CategoriesSuccesslState extends ShopStates {
  HomeModel? data;

  CategoriesSuccesslState(this.data);
}

class CategoriesErorrlState extends ShopStates {}

// Favorites

class FavoritesLodingState extends ShopStates {}

class FavoritesSuccesslState extends ShopStates {
  String? data;

  FavoritesSuccesslState(this.data);
}

class FavoritesErorrlState extends ShopStates {
  String? data;

  FavoritesErorrlState(this.data);
}

class FavoritesSuccessFalselState extends ShopStates {
  String? data;

  FavoritesSuccessFalselState(this.data);
}
