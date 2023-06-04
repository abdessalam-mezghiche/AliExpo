import 'package:aliexpo/modules/login/login.dart';
import 'package:aliexpo/shared/components/components.dart';
import 'package:aliexpo/shared/components/constants.dart';
import 'package:aliexpo/shared/network/local/shared_preferences.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Welcom to Cart screen',
      )),
      body: Container(
        child: TextButton(
            onPressed: () {
              print('----->1-token : $token');
              CacheHelper.removeData(key: 'token').then((value) {
                if (value == true) {
                  print('----->2-token : $token');
                  NavigateAndFinish(context, Login());
                }
              });
            },
            child: const Text('Logout')),
      ),
    );
  }
}
