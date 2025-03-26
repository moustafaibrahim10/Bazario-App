import 'package:shop_app/models/favourite_model/change_favourite_model.dart';

abstract class BazzStates{}
class InitialState extends BazzStates{}
class ChangeBottomIndexState extends BazzStates{}

class BazzHomeLoadingState extends BazzStates{}
class BazzHomeSuccessState extends BazzStates{}
class BazzHomeFilledState extends BazzStates
{
  final String error;
  BazzHomeFilledState(this.error);
}
class BazzCategoriesModelSuccessState extends BazzStates{}
class BazzCategoriesModelFilledState extends BazzStates
{
  final String error;
  BazzCategoriesModelFilledState(this.error);
}

class ChangeFavoriteState extends BazzStates{}
class ChangeFavoriteStateSuccess extends BazzStates
{
  final ChangeFavoriteModel model;
  ChangeFavoriteStateSuccess(this.model);
}
class ChangeFavoriteStateError extends BazzStates
{
  final String error;
  ChangeFavoriteStateError(this.error);
}
class GetFavoriteStateLoading extends BazzStates {}
class GetFavoriteStateSuccess extends BazzStates {}
class GetFavoriteStateError extends BazzStates {
  final String error;
  GetFavoriteStateError(this.error);
}
class GetUserDataStateLoading extends BazzStates
{
}
class GetUserDataStateSuccess extends BazzStates
{
}
class GetUserDataStateError extends BazzStates
{
  final String error;
  GetUserDataStateError(this.error);
}

class GetUpdateUserStateLoading extends BazzStates
{
}
class GetUpdateUserStateSuccess extends BazzStates
{
}
class GetUpdateUserStateError extends BazzStates
{
  final String error;
  GetUpdateUserStateError(this.error);
}

class ChangeCartStateLoading extends BazzStates{}
class ChangeCartStateSuccess extends BazzStates
{
  final ChangeFavoriteModel model;
  ChangeCartStateSuccess(this.model);
}
class ChangeCartStateError extends BazzStates
{
  final String error;
  ChangeCartStateError(this.error);
}

class ReadMoreTextState extends BazzStates{}


class GetCartDataStateLoading extends BazzStates {}
class GetCartDataStateSuccess extends BazzStates {}
class GetCartDataStateError extends BazzStates {
  final String error;
  GetCartDataStateError(this.error);
}

