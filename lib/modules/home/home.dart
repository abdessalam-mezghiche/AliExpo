import 'package:aliexpo/layout/cubit/cubit.dart';
import 'package:aliexpo/layout/cubit/states.dart';
import 'package:aliexpo/models/home_model.dart';
import 'package:aliexpo/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                child: productsBuilder(cubit.homeData, context),
              ),
      );
    });
  }

  Widget productsBuilder(HomeModel? model, context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
                items: model?.data?.banners
                    ?.map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                )),
            const SizedBox(
              height: 15,
            ),
            Container(
              // color: Colors.red,
              padding: const EdgeInsets.all(15.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1 / 1.8,
                children: List.generate(
                    model!.data!.products!.length,
                    (index) => buildeGridProduc(
                        model.data!.products![index], context, index)),
              ),
            )
          ],
        ),
      );

  Widget buildeGridProduc(model, context, index) {
    var cubit = ShopCubit.get(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: 200,
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
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              '${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(height: 1.4),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
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
                      color: model.inFavorites ? defaultColor : Colors.grey,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
