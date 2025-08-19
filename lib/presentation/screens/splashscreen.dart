import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:main_cartify/domain/model/splash.dart';
import 'package:main_cartify/presentation/screens/login.dart';
import 'package:main_cartify/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _currPageValue = 0.0;
  PageController pageController = PageController(viewportFraction: 1.0);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 1.5,
                width: double.maxFinite,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: screens.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.sizeOf(context).width / 3,
                                ),
                                child: Image.asset(screens[index].image),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: 290,
                                child: Text(
                                  screens[index].header,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.sizeOf(context).width / 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: 300,
                                child: Text(
                                  screens[index].text,
                                  style: const TextStyle(
                                    color: AppColors.smallText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Center(
              child: DotsIndicator(
                dotsCount: screens.length,
                position: _currPageValue, // already double
                decorator: DotsDecorator(
                  activeColor: AppColors.successColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 300,
                  decoration: const BoxDecoration(
                    color: AppColors.brandColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Get Started",
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
