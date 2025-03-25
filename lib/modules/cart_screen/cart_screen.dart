import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/cubit.dart';

import '../../cubit/states.dart';
import '../../shared/components/components.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BazzCubit, BazzStates>(
      listener: (context, state)
      {
        if (state is ChangeCartStateSuccess)
        {

          if (!state.model.status!)
          {
            Fluttertoast.showToast(
              msg:state.model.message!,
              backgroundColor: Colors.red,);
          }
        }

      },
      builder: (context, state) {
        var cubit = BazzCubit.get(context);
        // var favData = BazzCubit.get(context).getFavorites?.data?.data;
        // if (favData == null || favData.isEmpty) {
        //   return Center(child: Text('No favorites found'));
        // }

        return ConditionalBuilder(
          condition:state is! ChangeCartStateLoading,
          builder: (context) {
            if (cubit.getFavorites?.data?.data?.length == 0)
            {
              return Center(child: Text('No favorites found'));
            }
            else
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildListProduct(cubit.getFavorites?.data?.data?[index].product,context),
                separatorBuilder: (context, index) => Divider(),
                itemCount: BazzCubit.get(context).getFavorites!.data!.data!.length ?? 0,

              );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
