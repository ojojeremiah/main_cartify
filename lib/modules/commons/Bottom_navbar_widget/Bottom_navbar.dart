import 'package:flutter/material.dart';
import 'package:main_cartify/modules/commons/AppBars_widgets/MainScree.dart';
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
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            title: currentAppbar),
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
            onPressed: () {

            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          // notchMargin: 0,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      minWidth: 10,
                      onPressed: () {
                        setState(() {
                          currentScreen = const MainScreen();
                          currentAppbar = const Appbar();
                          currentTab = 0;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).width / 25,
                            left: MediaQuery.sizeOf(context).width / 35,
                            right: MediaQuery.sizeOf(context).width / 15),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              currentTab == 0
                                  ? Icons.home_filled
                                  : Icons.home_outlined,
                              size: 30,
                              color: currentTab == 0
                                  ? AppColors.brandColor
                                  : AppColors.blackColor,
                            ),
                            // Text(
                            //   'Home',
                            //   style: TextStyle(color: currentTab == 0 ? AppColors.brandColor : AppColors.blackColor),
                            // )
                          ],
                        ),
                      ),
                    ),
                    MaterialButton(
                      minWidth: 30,
                      onPressed: () {
                        // setState(() {
                        //   currentScreen = const Categories();
                        //   currentTab = 1;
                        //   currentAppbar = const CategoriesAppbar();
                        // });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            size: 30,
                            Icons.category,
                            color: currentTab == 1
                                ? AppColors.brandColor
                                : AppColors.blackColor,
                          ),
                          // Text(
                          //   'Home',
                          //   style: TextStyle(color: currentTab == 0 ? AppColors.brandColor : AppColors.blackColor),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 30,
                      onPressed: () {
                        setState(() {
                          // currentScreen = Favourites();
                          // currentAppbar = const FavouritesAppBar();
                          // currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            size: 30,
                            currentTab == 2
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: currentTab == 2
                                ? AppColors.brandColor
                                : AppColors.blackColor,
                          ),
                          // Text(
                          //   'Home',
                          //   style: TextStyle(color: currentTab == 0 ? AppColors.brandColor : AppColors.blackColor),
                          // )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 30,
                      onPressed: () {
                        setState(() {
                          // currentScreen = const Profile();
                          // currentAppbar = const ProfileAppBar();
                          // currentTab = 3;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).width / 75,
                            left: MediaQuery.sizeOf(context).width / 15,
                            right: MediaQuery.sizeOf(context).width / 35),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              size: 30,
                              currentTab == 3
                                  ? Icons.person
                                  : Icons.person_outline,
                              color: currentTab == 3
                                  ? AppColors.brandColor
                                  : AppColors.blackColor,
                            ),
                            // Text(
                            //   'Home',
                            //   style: TextStyle(color: currentTab == 0 ? AppColors.brandColor : AppColors.blackColor),
                            // )
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
