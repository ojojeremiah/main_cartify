import 'package:flutter/material.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/modules/commons/appBars_widgets/mainscreen.dart';
import 'package:main_cartify/modules/home/features/homescreen/presentation/screens/home.dart';
import 'package:main_cartify/utils/app_colors.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTab = 0;
  final List<Widget> screens = [
    const MainScreen(),
    // const Categories(),
    // Favourites(),
    // const Profile(),
  ];

  final List<Widget> appBar = [
    const Appbar(),
    // const CategoriesAppbar(),
    // const FavouritesAppBar(),
    // const ProfileAppBar()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const MainScreen();
  Widget currentAppbar = const Appbar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[100],
          toolbarHeight: Dimension.mmslargeSize,
          automaticallyImplyLeading: false,
          title: currentAppbar,
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              PageStorage(
                bucket: bucket,
                child: currentScreen,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.brandColor,
          child: const Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.lightCardColor,
          ),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: Dimension.mssslargeSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      minWidth: Dimension.small,
                      onPressed: () {
                        setState(() {
                          currentScreen = const MainScreen();
                          currentAppbar = const Appbar();
                          currentTab = 0;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).width / Dimension.mmediumsize,
                          left: MediaQuery.sizeOf(context).width / Dimension.slargeSize,
                          right: MediaQuery.sizeOf(context).width / Dimension.msmall,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              currentTab == 0
                                  ? Icons.home_filled
                                  : Icons.home_outlined,
                              size: Dimension.xmmmedium,
                              color: currentTab == 0
                                  ? AppColors.brandColor
                                  : AppColors.blackColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    MaterialButton(
                      minWidth: Dimension.xmmmedium,
                      onPressed: () {
                        // Handle categories
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            size: Dimension.xmmmedium,
                            Icons.category,
                            color: currentTab == Dimension.xssmallest
                                ? AppColors.brandColor
                                : AppColors.blackColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: Dimension.xmmmedium,
                      onPressed: () {
                        // Handle favourites
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            size: Dimension.xmmmedium,
                            currentTab == Dimension.xsmallest
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: currentTab == Dimension.xsmallest
                                ? AppColors.brandColor
                                : AppColors.blackColor,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: Dimension.xmmmedium,
                      onPressed: () {
                        // Handle profile
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).width / Dimension.mslargeSize,
                          left: MediaQuery.sizeOf(context).width / Dimension.msmall,
                          right: MediaQuery.sizeOf(context).width / Dimension.slargeSize,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              size: Dimension.xmmmedium,
                              currentTab == Dimension.ssmallest
                                  ? Icons.person
                                  : Icons.person_outline,
                              color: currentTab == Dimension.ssmallest
                                  ? AppColors.brandColor
                                  : AppColors.blackColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
