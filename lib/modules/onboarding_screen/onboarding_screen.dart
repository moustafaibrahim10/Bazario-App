import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}


class OnBoarding_Screen extends StatefulWidget {
  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {

  List<BoardingModel> BoardingItem = [
    BoardingModel(
        image: 'assets/images/onBoarding4.png',
        title: 'Smart Shopping Made Easy',
        body:
        'Discover the joy of effortless shopping with your loved ones. Find everything you need in one place!'),
    BoardingModel(
        image: 'assets/images/onBoarding3.png',
        title: 'A Fun Shopping Experience',
        body:
        'Enjoy quality time with your family while picking out the best deals and essentials together'),
    BoardingModel(
        image: 'assets/images/onBoarding2.png',
        title: 'Shop Together, Smile Together',
        body:
        'Create beautiful memories as you explore, choose, and shop for your favorite items with ease.'),
  ];

  var BoardController = PageController();

  bool islast = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              text: 'skip',
              function: ()
              {
                CacheHelper.saveData(key: "onBoarding", value: true);
                pushAndFinish(context: context, widget: LoginScreen());
              }
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == BoardingItem.length - 1) {
                    setState(() {
                      islast = true;
                    });
                  } else {
                    setState(() {
                      islast = false;
                    });
                  }
                },
                controller: BoardController,
                itemBuilder: (context, index) =>
                    BuildBoardingItem(BoardingItem[index]),
                itemCount: 3,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: BoardController,
                  count: BoardingItem.length,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      CacheHelper.saveData(key: "onBoarding", value: true);
                      pushAndFinish(context: context, widget: LoginScreen());
                    } else {
                      BoardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.easeInOutCubicEmphasized,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
