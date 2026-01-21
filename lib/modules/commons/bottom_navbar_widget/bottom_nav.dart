import 'package:flutter/material.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/modules/commons/appBars_widgets/home_screen.dart';
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
    return Scaffold(
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
          children: [PageStorage(bucket: bucket, child: currentScreen)],
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
        height: Dimension.mssslargeSize,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: Dimension.xmmLarge, // reduced height
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  currentTab == 0 ? Icons.home_filled : Icons.home_outlined,
                  color: currentTab == 0
                      ? AppColors.brandColor
                      : AppColors.blackColor,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    currentScreen = const MainScreen();
                    currentAppbar = const Appbar();
                    currentTab = 0;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.category,
                  color: currentTab == 1
                      ? AppColors.brandColor
                      : AppColors.blackColor,
                  size: 24,
                ),
                onPressed: () {
                  // Handle categories
                },
              ),
              IconButton(
                icon: Icon(
                  currentTab == 2 ? Icons.favorite : Icons.favorite_outline,
                  color: currentTab == 2
                      ? AppColors.brandColor
                      : AppColors.blackColor,
                  size: 24,
                ),
                onPressed: () {
                  // Handle favourites
                },
              ),
              IconButton(
                icon: Icon(
                  currentTab == 3 ? Icons.person : Icons.person_outline,
                  color: currentTab == 3
                      ? AppColors.brandColor
                      : AppColors.blackColor,
                  size: 24,
                ),
                onPressed: () {
                  // Handle profile
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
