import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/modules/commons/brands_widget/brands.dart';
import 'package:main_cartify/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      setState(() {
        isLoading = true;
      });
    });
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(Dimension.small),
            child: Text(
              'Brands',
              style: TextStyle(fontSize: Dimension.xmsmallSize),
            ),
          ),
          isLoading
              ? const Brands()
              : Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: const Brands()),
          const Padding(
            padding: EdgeInsets.all(Dimension.small),
            child: Text(
              'Popular Shoes',
              style: TextStyle(fontSize: Dimension.xmsmallSize),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(Dimension.mediumsize),
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.lightCardColor,
                  borderRadius: BorderRadius.all(Radius.circular(Dimension.msmall))),
              // margin: EdgeInsets.only(
              //     left: MediaQuery.sizeOf(context).width / 30,
              //     right: MediaQuery.sizeOf(context).width / 30),
              height: Dimension.xmmLarge,
              width: MediaQuery.sizeOf(context).width / 0.5,
              child: Stack(
                children: [
                  Container(
                    height: Dimension.mlargesize,
                    width: Dimension.xxlargeSize,
                    margin: const EdgeInsets.only(left: Dimension.xmmmedium, top: Dimension.small, right: Dimension.xmmmedium),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.small),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/beautiful-nike.jpg'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: Dimension.small, left: Dimension.xmmLarge),
                        child: const Text(
                          'Nike air Jordan',
                          style: TextStyle(fontSize: Dimension.msmall),
                        ),
                      ),
                      Container(
                        margin:  EdgeInsets.only(left: 120.sp),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_outline,
                              color: Colors.redAccent,
                              size: Dimension.mmediumsize,
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: Dimension.mxlargesize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Row(
                          children: [
                            Text('Review'),
                            Text('(4.9'),
                            Icon(
                              Icons.star,
                              size: Dimension.xsmallSize,
                              color: Colors.orange,
                            ),
                            Text(')')
                          ],
                        ),
                        Container(
                            height: Dimension.xmmmedium,
                            width: Dimension.xmmmedium,
                            margin: const EdgeInsets.only(left: Dimension.mlargesize),
                            decoration: BoxDecoration(
                                color: AppColors.brandColor,
                                borderRadius: BorderRadius.circular(Dimension.xmmmedium)),
                            child: const Icon(
                              Icons.add,
                              size: Dimension.mediumsize,
                              color: AppColors.lightCardColor,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: Dimension.xmslargeSize, left: Dimension.slargeSize),
                    child: const Text('\$ 98.9'),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Padding(
                padding: EdgeInsets.all(Dimension.msmall),
                child: Text(
                  'New Arrivals',
                  style: TextStyle(fontSize: Dimension.xmsmallSize),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'view all',
                    style: TextStyle(color: AppColors.blackColor),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

