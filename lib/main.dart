import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/Bloc_Observer/Bloc_Observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/onboarding_screen/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
   bool onBoarding =  CacheHelper.getData(key: 'onBoarding') ?? false;
   token =  CacheHelper.getData(key: 'token');
   print(token);

   Widget? widget;
  if(onBoarding)
    {
      if(token !=null)
        {
          widget = ShopLayout();
        }
      else
        {
          widget = LoginScreen();
        }
    }
  else
    {
      widget = OnBoarding_Screen();
    }

  runApp( MyApp( startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BazzCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()..getCartData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
          ),
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Jannah',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            elevation: 20.0,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
