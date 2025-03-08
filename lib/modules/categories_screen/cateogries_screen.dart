import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';

class CategoriesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BazzCubit , BazzStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = BazzCubit.get(context);
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) => buildCat(cubit.categoriesModel!.data!.data[index]),
            separatorBuilder: (context,state) =>Container(
              height: 1,
              color: Colors.grey,
            ), itemCount: cubit.categoriesModel!.data!.data.length);
      },
    );
  }
  Widget buildCat(DataModel model)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(image: NetworkImage('${model.image}'),
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text('${model.name}',style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          ),
          Spacer(),
          IconButton(onPressed: (){},
              icon:Icon(Icons.arrow_forward_ios,))
        ],
      ),
    );
  }
}