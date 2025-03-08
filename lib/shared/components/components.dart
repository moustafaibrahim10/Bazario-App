import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/login_screen/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart' as Fluttertoast;

Widget defaultTextFormField({
  required TextEditingController contorller,
  required String? Function(String?)? validator,
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


