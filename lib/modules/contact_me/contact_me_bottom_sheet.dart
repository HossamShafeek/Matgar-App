import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';


Future<void>openLink(String link)async{
  var urlink=link;
  if(await canLaunch((urlink))){
    await launch (urlink);
  }
  else{
    await launch (urlink);
  }
}

void bottomSheetContactMe(
    {@required BuildContext context, @required ShopCubit cubit}) {
  showBarModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (context) => Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                'Contact Me',
                style: TextStyle(
                  color: indigo,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 25,
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Image.asset(
                                'assets/images/hossam.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('Hossam Shafeek',style: TextStyle(),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        final url = 'https://www.facebook.com/profile.php?id=100003941214627';
                                        openLink(url);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          'assets/images/facebook.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap:(){
                                        final url = 'https://wa.me/+2001010040257';
                                        openLink(url);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          'assets/images/whatsapp.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        final url = 'https://www.instagram.com/Hossam.shafeek/?fbclid=IwAR2ahyKd_Our1Dm3YxqFAYUZad32xU47GcHxMTC-AenUMj-_k_ZQtWiBPYA';
                                        openLink(url);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          'assets/images/instagram.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    gradientButton(
                      context: context,
                      title: Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
