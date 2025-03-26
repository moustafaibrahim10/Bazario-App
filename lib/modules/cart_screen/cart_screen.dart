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

        return Scaffold(
          appBar: AppBar(
            title: Text('Cart Screen',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
          ),
          body: ConditionalBuilder(
            condition:state is! ChangeCartStateLoading,
            builder: (context) {
              if (cubit.cartData?.data?.cartItems?.length == 0)
              {
                return Center(child: Text('No Cart Data found'));
              }
              else
                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildListProduct(cubit.cartData?.data?.cartItems?[index].product,context),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: cubit.cartData?.data?.cartItems?.length ?? 0,

                );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
