import 'package:aliexpo/modules/login/login.dart';
import 'package:aliexpo/shared/components/components.dart';
import 'package:aliexpo/shared/network/local/shared_preferences.dart';
import 'package:aliexpo/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoadingScreen extends StatelessWidget {
  // const OnBoadingScreen({Key? key}) : super(key: key);
  var BoardingController = PageController();
  bool isLstePage = false;
  List<BoardingModel> Boarding = [
    BoardingModel(
        image: 'assets/images/OnBoarding_01.jpg',
        title: 'Shopping starts here',
        body: 'Diverse and high quality products'),
    BoardingModel(
        image: 'assets/images/OnBoarding_02.jpg',
        title: 'Multiple options',
        body: 'Many different options in shape, size and color'),
    BoardingModel(
        image: 'assets/images/OnBoarding_03.jpg',
        title: 'Add to cart',
        body: 'When you add to the cart, you will get offers and discounts'),
  ];

  OnBoadingScreen({Key? key}) : super(key: key);
  void onSubmit({required context}) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) NavigateAndFinish(context, Login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                onSubmit(context: context);
              },
              child: const Text('SKIP'))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: BoardingController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildBoardingItem(Boarding[index]),
              itemCount: Boarding.length,
              onPageChanged: (value) {
                if (value == Boarding.length - 1) {
                  isLstePage = true;
                } else {
                  isLstePage = false;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(children: [
              SmoothPageIndicator(
                controller: BoardingController,
                count: Boarding.length,
                effect: const ExpandingDotsEffect(
                    spacing: 8.0,
                    dotWidth: 14.0,
                    dotHeight: 14.0,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor),
              ),
              const Spacer(),
              FloatingActionButton(
                  onPressed: () {
                    if (!isLstePage) {
                      BoardingController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    } else {
                      onSubmit(context: context);
                    }
                  },
                  elevation: 0,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ))
            ]),
          )
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              model.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              model.body,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
}
