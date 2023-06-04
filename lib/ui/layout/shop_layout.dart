import 'package:aliexpo/ui/layout/cubit/cubit.dart';
import 'package:aliexpo/ui/layout/cubit/states.dart';
import 'package:aliexpo/ui/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLyaout extends StatelessWidget {
  // const ShopLyaout({Key? key}) : super(key: key);
  var controllerSearchField = TextEditingController();

  ShopLyaout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Container(
                child: defaultFormaFielde(
                    controllerField: controllerSearchField,
                    border: 'rounded',
                    dense: true,
                    text: 'Search',
                    prefixIcon: Icons.search,
                    validatorField: (value) {
                      return null;
                    }),
              ),
            ),
            body: cubit.screens[cubit.index],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: cubit.itmes,
              currentIndex: cubit.index,
              onTap: (value) {
                cubit.onNavigation(indexChange: value);
              },
            ),
          );
        });
  }
}
