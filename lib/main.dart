import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get_ev/FrontPage.dart';
import 'package:get_ev/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:get_ev/LoginPage.dart';
import 'package:get_ev/Signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_ev/CartPage.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Wishlist()),
        ChangeNotifierProvider(create: (_) => CartModel()),
         
      ],child: 
    
    ScreenUtilInit(
      designSize: const Size(412, 868),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp(
        title: 'My App',
        home: FrontPage(),
      ),
    )
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0; // Initialize _currentIndex

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: 200.h,
                width: 200.w,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: [
                  "All your favorite\nhealthy food",
                  "Delivery at your doorstep",
                ].map((text) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  text.startsWith("All your")
                                      ? "assets/images/ddryfruit.jpg"
                                      : "assets/images/delivery.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            text.startsWith("All your")
                                ? "A healthy lifestyle awaits you"
                                : "Fast and convenient",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
              DotsIndicator(
                dotsCount: 2,
                position: _currentIndex.toInt(),
                decorator: DotsDecorator(
                  color: Colors.grey,
                  activeColor: Colors.orange,
                  size: Size(10, 10),
                  activeSize: Size(12, 12),
                ),
              ),
              SizedBox(height: 80.h),
              Container(
                height: 55.h,
                width: 270.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenHeight * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignupPage();
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    ),
                  ),
                  child: Text(
                    "Get started",
                    style: TextStyle(fontSize: 17.sp),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 55.h,
                width: 270.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenHeight * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                      
                    ),
                  ),
                  child: Text(
                    "Sign in",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
