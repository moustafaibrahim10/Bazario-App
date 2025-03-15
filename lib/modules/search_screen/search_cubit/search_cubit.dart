import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/search_screen/search_cubit/search_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void getSearch(String text) {
  emit(GetSearchLoading());
  DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text':text,
      }
      ).then((value)
  {
    model=SearchModel.fromJson(value!.data);
    emit(GetSearchSuccess());
  }).catchError((error)
  {
    print(error.toString());
    emit(GetSearchError());
  });
  }
}
