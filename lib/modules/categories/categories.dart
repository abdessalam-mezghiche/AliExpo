import 'package:aliexpo/layout/cubit/cubit.dart';
import 'package:aliexpo/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).categoriesData;
          return Scaffold(
            body: model == null
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    child: GridView.count(
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 1 / 1.2,
                      children: List.generate(
                          model.data!.data!.length,
                          (index) =>
                              buildeGridcategori(model.data?.data![index])),
                    ),
                  ),
          );
        });
  }

  Widget buildeGridcategori(dataModel) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Image(
            image: NetworkImage('${dataModel.image}'),
            height: 200,
          ),
          Text('${dataModel.name}')
        ],
      ),
    );
  }
}
