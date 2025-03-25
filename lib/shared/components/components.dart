import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../cubit/cubit.dart';
import '../../modules/login_screen/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart' as Fluttertoast;

Widget defaultTextFormField({
  required TextEditingController contorller,
  required String? Function(String?)? validator,
   String? Function(String?)? onSubmitted,
  required String labelText,
  required Widget prefixicon,
  bool? obscure = false,
  Widget? suffix,
}) =>
    TextFormField(
      controller: contorller,
      obscureText: obscure!,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefixicon,
        suffixIcon: suffix,
        focusColor: Colors.blue,
      ),
      validator: validator,
      onFieldSubmitted:onSubmitted ,
    );

Widget defaultTextButton({
  required String text,
  required Function() function,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

Future pushAndFinish({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Widget buildListProduct( model,context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 125,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage( model.image!),
                width: 120,
              ),
              if (model.discount != 0)
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
                Text(model.name!
                  ,maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10,),
                Text(model.description!
                  ,maxLines: 2,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10,),

                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price!.toString(),
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
                    if (model.discount != 0)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: BazzCubit.get(context).favourite[model.id!]! ? Colors.blue : Colors.grey,
                      radius: 16,
                      child: IconButton(
                        onPressed: () {
                          BazzCubit.get(context).changeFavorites(model.id!);
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



