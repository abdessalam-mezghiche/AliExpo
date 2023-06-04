import 'package:aliexpo/ui/modules/login/login.dart';
import 'package:aliexpo/ui/shared/components/components.dart';
import 'package:aliexpo/data/network/local/shared_preferences.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Welcom to Account screen',
      )),
      body: Container(
        child: TextButton(
            onPressed: () {
              CacheHelper.removeData(key: 'token').then((value) {
                if (value == true) {
                  NavigateAndFinish(context, Login());
                }
              });
            },
            child: const Text('Logout')),
      ),
    );
  }
}
