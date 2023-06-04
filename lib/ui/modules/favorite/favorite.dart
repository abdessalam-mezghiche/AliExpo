import 'package:aliexpo/ui/layout/cubit/cubit.dart';
import 'package:aliexpo/ui/layout/cubit/states.dart';
import 'package:aliexpo/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is FavoritesSuccesslState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("${state.data}"),
        ));
      }
      if (state is FavoritesSuccessFalselState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("${state.data}"),
        ));
      }
      if (state is FavoritesErorrlState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("حدث خطأ بالرجاء التأكد من الانترنت "),
        ));
      }
    }, builder: (context, state) {
      return Container(
        child: cubit.homeData == null
            ? const Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildeGridProduc(
                        cubit.homeData!.data!.products![index], context, index),
                    separatorBuilder: (context1, index1) => SizedBox(
                          height: cubit.homeData!.data!.products![index1]
                                      .inFavorites ==
                                  true
                              ? 15
                              : 0,
                        ),
                    itemCount: cubit.homeData!.data!.products!.length),

                // productsBuilder(cubit.homeData, context),
              ),
      );
    });
  }

  Widget buildeGridProduc(model, context, index) {
    var cubit = ShopCubit.get(context);

    return model.inFavorites == true
        ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      alignment: Alignment.topCenter,
                      width: 150,
                      height: 150,
                      image: NetworkImage(
                        '${model.image}',
                      ),
                    ),
                    if (model.discount != 0)
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '- ${model.discount} %',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${model.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(height: 1.4),
                      ),
                      Row(
                        children: [
                          Text('${model.price.round()} ',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  height: 1.4,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: defaultColor)),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice.round()}',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          const Spacer(),
                          IconButton(
                              padding: const EdgeInsets.all(0.1),
                              iconSize: 20,
                              onPressed: () {
                                model.inFavorites = !model.inFavorites;

                                cubit.changeFavorites(model.id, index);
                              },
                              icon: Icon(
                                model.inFavorites
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: model.inFavorites
                                    ? defaultColor
                                    : Colors.grey,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ))
        : Container(
            height: 0,
          );
  }
}
