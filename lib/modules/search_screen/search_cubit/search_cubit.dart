import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/search_cubit/search_states.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);


}