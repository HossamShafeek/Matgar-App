import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(
      {@required this.image, @required this.title, @required this.body});
}

List<BoardingModel> boarding = [
  BoardingModel(
      image: 'assets/images/onboard1.png',
      title: 'On Boarding Screen',
      body:
          'Online shopping is a form of electronic commerce which allows consumers to directly buy goods or services from a seller over the Internet using a mobile app.'),
  BoardingModel(
      image: 'assets/images/onboard2.png',
      title: 'On Boarding Screen',
      body:
          'Online shopping is a form of electronic commerce which allows consumers to directly buy goods or services from a seller over the Internet using a mobile app.'),
  BoardingModel(
      image: 'assets/images/onboard3.png',
      title: 'On Boarding Screen',
      body:
          'Online shopping is a form of electronic commerce which allows consumers to directly buy goods or services from a seller over the Internet using a mobile app.'),
];

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SvgPicture.asset(
            'assets/images/splash.svg',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: submit,
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )),
                  ),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (int index) {
                        if (index == boarding.length - 1) {
                          setState(() {
                            isLast = true;
                          });
                        } else {
                          setState(() {
                            isLast = false;
                          });
                        }
                      },
                      controller: boardController,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildBoardingItem(boarding[index]);
                      },
                      itemCount: boarding.length,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: SmoothPageIndicator(
                        controller: boardController,
                        count: boarding.length,
                        effect: ExpandingDotsEffect(
                          dotColor: Colors.grey[400],
                          dotHeight: 10,
                          dotWidth: 10,
                          expansionFactor: 4,
                          spacing: 5,
                          activeDotColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  !isLast
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: TextButton(
                                onPressed: () {
                                  boardController.nextPage(
                                      duration: Duration(milliseconds: 750),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Next',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    Baseline(
                                        baseline: 33,
                                        baselineType: TextBaseline.alphabetic,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 30,
                                        ))
                                  ],
                                )),
                          ),
                        )
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: TextButton(
                                onPressed: submit,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Get Started',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    Baseline(
                                        baseline: 33,
                                        baselineType: TextBaseline.alphabetic,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 30,
                                        ))
                                  ],
                                )),
                          ),
                        ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.asset(
            '${model.image}',
            width: 280,
            height: 280,
          )),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
                fontFamily: 'CMSansSerif', fontSize: 22, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }));
      }
    });
  }
}
