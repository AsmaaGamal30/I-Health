import 'package:flutter/material.dart';
import 'package:i_health/layout/home_layout.dart';
import 'package:i_health/modules/login_screen.dart';
import 'package:i_health/shared/componants/components.dart';
import 'package:i_health/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<BoardingModel> boarding =
      [
        BoardingModel(
            image: 'assets/images/onboarding_one.jpeg',
            title: 'I-Health',
            body: 'offers you alot of\ninformation about covid-19\nall over the world',
        ),
        BoardingModel(
          image: 'assets/images/onboarding_two.jpeg',
          title: '',
          body: 'You can record all your drugs\nappointments in our\nprescription',
        ),
        BoardingModel(
          image: 'assets/images/onboarding_three.jpeg',
          title: '',
          body: 'Let\'s start our\njourney',
        ),
      ];
  var boardController = PageController();
  bool isLast = false;
  void finish()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value!)
        {
          navigateAndFinish(context, LoginScreen());
        }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0,left: 20.0,bottom: 20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController ,
                physics: BouncingScrollPhysics(),
                onPageChanged:(int index)
                {
                  if(index == boarding.length-1)
                    {
                      setState(() {
                        isLast = true;
                      });
                    }
                  else
                    {
                      setState(() {
                        isLast = false;
                      });
                    }
                },
                itemBuilder: (context, index) =>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey ,
                    activeDotColor: Colors.deepPurple,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                    ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.deepPurple,
                  onPressed: ()
                  {
                    if(isLast)
                      {
                        finish();
                      }
                    else
                      {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),


              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
          child: Image(
            image: AssetImage('${model.image}'),

          ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          color: Colors.deepPurple,
          fontSize: 20.0
        ),
      ),
      SizedBox(
        height: 5.0,
      ),
      Text(
          '${model.body}',
        style: TextStyle(
               fontSize: 20.0
  ),
      ),
      SizedBox(
        height: 50.0,
      ),



    ],
  );
}
