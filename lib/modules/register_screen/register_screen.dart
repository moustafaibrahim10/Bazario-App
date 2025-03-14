import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_cubit.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_states.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login_screen/cubit/login_states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState)
          {
            if (state.registerModel.status!)
            {
              CacheHelper.saveData(key: 'token', value: state.registerModel.data!.token);
              token=state.registerModel.data!.token;
              Fluttertoast.showToast(
                  msg: state.registerModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              pushAndFinish(context: context, widget: ShopLayout());
            }
            else
            {
              Fluttertoast.showToast(
                  msg: state.registerModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
        builder: (context,state){
          var cubit= RegisterCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.7,
                            image: AssetImage('assets/images/logo.png'),
                          ),
                        ),
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Register and join our community',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          prefixicon: Icon(Icons.person),
                          contorller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                          labelText: 'Username',
                        ),
                        SizedBox(
                          height: 15.0,
                        ),defaultTextFormField(
                          prefixicon: Icon(Icons.email_outlined),
                          contorller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          labelText: 'Email Address',
                        ),
                        SizedBox(
                          height: 15.0,
                        ),defaultTextFormField(
                          prefixicon: Icon(Icons.phone),
                          contorller: phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Phone';
                            }
                            return null;
                          },
                          labelText: 'Phone',
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          suffix: IconButton(
                            onPressed: () {
                              cubit.changePasswordMode();
                            },
                            icon: cubit.suffix,
                          ),
                          labelText: 'Password',
                          obscure: cubit.obscure,
                          prefixicon: Icon(Icons.lock_outline),
                          contorller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          suffix: IconButton(
                            onPressed: () {
                              cubit.changePasswordMode();
                            },
                            icon: cubit.suffix,
                          ),
                          labelText: 'Confirm Password',
                          obscure: cubit.obscure,
                          prefixicon: Icon(Icons.lock_outline),
                          contorller: confirmPasswordController,
                          validator: (value) {
                            if (confirmPasswordController.text != passwordController.text ) {
                              return 'Confirm Password dosen\'t match password ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}