import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/l10n/app_localizations.dart';

import 'package:main_cartify/utils/app_colors.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    // final searchBarSize = MediaQuery.sizeOf(context).width;
    return Row(
      children: [
        Container(
          width: Dimension.xmmlargeSize,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Dimension.xmmLarge)),
          ),
          // margin: const EdgeInsets.only(top: 10, left: 21),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.mmediumsize),
                color: AppColors.lightCardColor,
              ),
              height: MediaQuery.sizeOf(context).height / Dimension.xsmallSize,
              width: Dimension.xmlargeSize,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.search,
                    size: Dimension.mmediumsize,
                    color: AppColors.blackColor,
                  ),
                  Text(
                    // 'Search here',
                    AppLocalizations.of(context)!.searchHere,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: Dimension.smallSize,
                    ),
                  ),
                  const Icon(
                    Icons.mic_outlined,
                    size: Dimension.mmediumsize,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: MediaQuery.sizeOf(context).width / Dimension.smallestSize,
            margin: EdgeInsets.only(
              left: MediaQuery.sizeOf(context).width / Dimension.largeSize,
            ),
            height: MediaQuery.sizeOf(context).height / Dimension.xmsmallSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(Dimension.small)),
            ),
            child: SvgPicture.asset(
              'assets/svg/filter.svg',
              width: Dimension.msmall,
            ),
          ),
        ),
      ],
    );
  }
}
