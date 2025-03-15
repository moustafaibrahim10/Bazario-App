import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/search_cubit/search_cubit.dart';
import 'package:shop_app/modules/search_screen/search_cubit/search_states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    children: [
                    defaultTextFormField(
                    contorller: searchController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter a text to search';
                      }
                      return null;
                    },
                    labelText: 'Search',
                    prefixicon: Icon(Icons.search),
                    onSubmitted: (value) {
                      SearchCubit.get(context).getSearch(value!);
                    }),
                SizedBox(
                  height: 10,
                ),
                     if (state is GetSearchLoading)
                          LinearProgressIndicator()
                          ,
                          SizedBox(
                          height: 10,
                          ),
                          Expanded(
                          child: ListView.separated(
                          itemBuilder: (context,index) => buildListProduct(SearchCubit.get(context).model?.data?.data?[index],context),
                          separatorBuilder: (context,index) =>Divider(
                          color: Colors.grey,
                          ),
                          itemCount: SearchCubit.get(context).model?.data?.data?.length ?? 0,
                          ),
                          )
                          ]
                          ,
                          ),
              )
          ,
          );
        },
      ),
    );
  }
}
