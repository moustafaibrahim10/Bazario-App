import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../cubit/states.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login_screen/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BazzCubit, BazzStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BazzCubit.get(context);
        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      'Welcome ${nameController.text}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              defaultTextFormField(
                contorller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your name";
                  }
                  return null;
                },
                labelText: 'Name',
                prefixicon: Icon(Icons.person),
              ),
              SizedBox(
                height: 20,
              ),
              defaultTextFormField(
                contorller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your email";
                  }
                  return null;
                },
                labelText: 'Email Address',
                prefixicon: Icon(Icons.email),
              ),
              SizedBox(
                height: 20,
              ),
              defaultTextFormField(
                contorller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your phone";
                  }
                  return null;
                },
                labelText: 'Phone',
                prefixicon: Icon(Icons.phone),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()
                  {

                  },
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    CacheHelper.removeData(key: 'token');
                    pushAndFinish(context: context, widget: LoginScreen());
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    ;
  }
}
