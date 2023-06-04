import 'package:aliexpo/layout/cubit/cubit.dart';
import 'package:aliexpo/layout/cubit/states.dart';
import 'package:aliexpo/layout/shop_layout.dart';
import 'package:aliexpo/shared/components/constants.dart';
import 'package:aliexpo/shared/network/local/shared_preferences.dart';
import 'package:aliexpo/shared/network/remote/dio_helper.dart';
import 'package:aliexpo/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Diohelper.init();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  runApp(MyApp(
    onBoarding: onBoarding,
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final bool? onBoarding;
  final String? token;
  const MyApp({Key? key, this.onBoarding, this.token}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getData()
        ..getCategories(),
      child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              // home: onBoarding != null
              //     ? token != null
              //         ? ShopLyaout()
              //         : Login()
              //     : OnBoadingScreen(),
              home: ShopLyaout(),
            );
          }),
    );
  }
}
