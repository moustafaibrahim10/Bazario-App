import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../models/favourite_model/get_favorites_models.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BazzCubit, BazzStates>(
      listener: (context, state)
      {
        if (state is ChangeFavoriteStateSuccess)
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
        var favData = BazzCubit.get(context).getFavorites?.data?.data;
        if (favData == null || favData.isEmpty) {
          return Center(child: Text('No favorites found'));
        }

        return ConditionalBuilder(
          condition:state is! GetFavoriteStateLoading,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFavItem(favData[index],context),
              separatorBuilder: (context, index) => Divider(),
              itemCount: BazzCubit.get(context).getFavorites!.data!.data!.length ?? 0,

          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model,context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage( model.product!.image!),
                  width: 120,
                ),
                if (model.product!.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.product!.name!
                    ,maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.product!.price!.toString(),
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            // height: 1.3,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          model.product!.oldPrice!.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      CircleAvatar(
                         backgroundColor: BazzCubit.get(context).favourite[model.product!.id!]! ? Colors.blue : Colors.grey,
                        radius: 16,
                        child: IconButton(
                          onPressed: () {
                               BazzCubit.get(context).changeFavorites(model.product!.id!);
                          },
                          icon: Icon(
                            color: Colors.white,
                            Icons.favorite_outline,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
