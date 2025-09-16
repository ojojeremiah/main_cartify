import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/utils/app_colors.dart';

class Brands extends StatefulWidget {
  const Brands({
    super.key,
  });

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  bool selected = true;
  bool puma = true;
  bool nike = true;
  bool jordan = true;
  bool louis = true;
  bool fila = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimension.mediumsize,
          top: Dimension.small,
        ),
        child: Row(
          children: [
            AnimatedSize(
              duration: const Duration(seconds: 1),
              alignment: selected ? Alignment.topLeft : Alignment.centerLeft,
              curve: Curves.fastOutSlowIn,
              child: Container(
                alignment: selected ? Alignment.topLeft : Alignment.centerLeft,
                width: selected ? Dimension.smlargeSize : Dimension.msslargeSize,
                height: selected ? Dimension.smmlargeSize : Dimension.mssslargeSize,
                decoration: BoxDecoration(
                    color: selected
                        ? AppColors.lightCardColor
                        : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                margin: const EdgeInsets.only(right: Dimension.mediumsize),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: Dimension.xxssmallest),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                        child: SvgPicture.asset(
                          'assets/svg/adidas.svg',
                          width: selected ? Dimension.smmlargeSize : Dimension.ssmlargeSize,
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.clip,
                        selected ? '' : 'Addidas',
                        style: const TextStyle(
                            color: AppColors.lightCardColor, fontSize: Dimension.msmall),
                      )
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(seconds: 1),
              alignment: puma ? Alignment.topLeft : Alignment.centerLeft,
              curve: Curves.fastOutSlowIn,
              child: Container(
                alignment: puma ? Alignment.topLeft : Alignment.centerLeft,
                width: puma ? Dimension.smlargeSize : Dimension.msslargeSize,
                height: puma ? Dimension.smmlargeSize : Dimension.mssslargeSize,
                decoration: BoxDecoration(
                    color:
                        puma ? AppColors.lightCardColor : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                margin: const EdgeInsets.only(right: Dimension.mediumsize),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      puma = !puma;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 3),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                        child: SvgPicture.asset(
                          'assets/svg/puma.svg',
                          width: puma ? Dimension.smmlargeSize : Dimension.ssmlargeSize,
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.clip,
                        puma ? '' : 'Puma',
                        style: const TextStyle(
                            color: AppColors.lightCardColor, fontSize: Dimension.xsmallSize),
                      )
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(seconds: 1),
              alignment: nike ? Alignment.topLeft : Alignment.centerLeft,
              curve: Curves.fastOutSlowIn,
              child: Container(
                alignment: nike ? Alignment.topLeft : Alignment.centerLeft,
                width: nike ? Dimension.mssslargeSize : Dimension.msslargeSize,
                height: nike ? Dimension.smlargeSize : Dimension.mssslargeSize,
                decoration: BoxDecoration(
                    color:
                        nike ? AppColors.lightCardColor : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                margin: const EdgeInsets.only(right: Dimension.mediumsize),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      nike = !nike;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 1),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                        child: SvgPicture.asset(
                          'assets/svg/nike-logo.svg',
                          width: nike ? Dimension.smlargeSize : 47,
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.clip,
                        nike ? '' : 'Nike',
                        style: const TextStyle(
                            color: AppColors.lightCardColor, fontSize: Dimension.xsmallSize),
                      )
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(seconds: 1),
              alignment: jordan ? Alignment.topLeft : Alignment.centerLeft,
              curve: Curves.fastOutSlowIn,
              child: Container(
                alignment: jordan ? Alignment.topLeft : Alignment.centerLeft,
                width: jordan ? 73 : Dimension.msslargeSize,
                height: jordan ? Dimension.mssslargeSize : Dimension.mssslargeSize,
                decoration: BoxDecoration(
                    color: jordan
                        ? AppColors.lightCardColor
                        : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                margin: const EdgeInsets.only(right: Dimension.mediumsize),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      jordan = !jordan;
                    });
                  },
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: jordan
                            ? const EdgeInsets.only(left: 0, right: 0)
                            : const EdgeInsets.only(
                                left: Dimension.small, right: Dimension.small, top: Dimension.small, bottom: Dimension.small),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimension.ssmallestSize),
                          child: SvgPicture.asset(
                            'assets/svg/jordan.svg',
                            width: jordan ? Dimension.smlargeSize : Dimension.xmmmedium,
                          ),
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.clip,
                        jordan ? '' : ' Jordans ',
                        style: const TextStyle(color: AppColors.lightCardColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(seconds: 1),
              alignment: louis ? Alignment.topLeft : Alignment.centerLeft,
              curve: Curves.fastOutSlowIn,
              child: Container(
                alignment: louis ? Alignment.topLeft : Alignment.centerLeft,
                width: louis ? Dimension.smlargeSize : Dimension.msmall,
                height: louis ? Dimension.smmlargeSize : Dimension.mssslargeSize,
                decoration: BoxDecoration(
                    color:
                        louis ? AppColors.lightCardColor : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                margin: const EdgeInsets.only(right: Dimension.mediumsize),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      louis = !louis;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: Dimension.ssmlargeSize,
                        width: Dimension.smmlargeSize,
                        margin: const EdgeInsets.only(left: Dimension.xxssmallest),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimension.ssmallestSize),
                          child: SvgPicture.asset(
                            'assets/svg/louis-vuitton.svg',
                            height: Dimension.mediumsize,
                            width: louis ? Dimension.smmlargeSize : Dimension.ssmlargeSize,
                          ),
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.clip,
                        louis ? '' : ' Louis Vuitton ',
                        style: const TextStyle(color: AppColors.lightCardColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(seconds: 1),
              alignment: fila ? Alignment.topLeft : Alignment.centerLeft,
              curve: Curves.fastOutSlowIn,
              child: Container(
                alignment: fila ? Alignment.topLeft : Alignment.centerLeft,
                width: fila ? Dimension.smmlargeSize : Dimension.msslargeSize,
                height: fila ? Dimension.smmlargeSize : Dimension.mssslargeSize,
                decoration: BoxDecoration(
                    color:
                        fila ? AppColors.lightCardColor : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                margin: const EdgeInsets.only(right: Dimension.mediumsize),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      fila = !fila;
                    });
                  },
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: Dimension.smmlargeSize,
                        width: Dimension.smmlargeSize,
                        margin: fila
                            ? const EdgeInsets.only(left: 0, right: 0)
                            : const EdgeInsets.only(left: Dimension.small, right: Dimension.small),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(Dimension.xmmmedium))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: Dimension.xxssmallest, right: Dimension.xxssmallest),
                          child: SvgPicture.asset(
                            'assets/svg/fila.svg',
                            width: fila ? Dimension.mssslargeSize : Dimension.smlargeSize,
                          ),
                        ),
                      ),
                      Text(
                        // overflow: TextOverflow.clip,
                        fila ? '' : 'Fila',
                        style: const TextStyle(color: AppColors.lightCardColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
