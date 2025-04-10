import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BazzCubit.get(context);
    return BlocConsumer<BazzCubit, BazzStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Cart Screen'),
          ),
          body: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 150,
                child: Row(
                  children: [
                    Image(image: NetworkImage('${cubit.cartData?.data?.cartItems?[index].product?.image}'), width: 120, height: 120),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  cubit.cartData?.data?.cartItems?[index].product?.name.toString() ?? 'default name',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ),
                              IconButton(onPressed: ()
                              {
                                cubit.deleteCartData(id: cubit.cartData?.data?.cartItems?[index].product?.id);
                              },
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                          Text(
                              cubit.cartData?.data?.cartItems?[index].product?.toString() ?? 'default description',
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                cubit.cartData?.data?.cartItems?[index].product?.price.toString() ?? 'default price',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.remove),
                                  ),
                                  Text("1"),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
            itemCount: cubit.cartData?.data?.cartItems?.length??0,
          ),
        );
      },
    );
  }
}
