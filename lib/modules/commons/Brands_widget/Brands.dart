import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          left: 20,
          top: 10,
        ),
        child: Row(
          children: [
            AnimatedSize(
              duration: const Duration(seconds: 1),
              alignment: selected ? Alignment.topLeft : Alignment.centerLeft,
              curve: Curves.fastOutSlowIn,
              child: Container(
                alignment: selected ? Alignment.topLeft : Alignment.centerLeft,
                width: selected ? 55 : 130,
                height: selected ? 50 : 60,
                decoration: BoxDecoration(
                    color: selected
                        ? AppColors.lightCardColor
                        : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                margin: const EdgeInsets.only(right: 20),
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
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: SvgPicture.asset(
                          "assets/svg/adidas.svg",
                          width: selected ? 50 : 45,
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.clip,
                        selected ? "" : "Addidas",
                        style: const TextStyle(
                            color: AppColors.lightCardColor, fontSize: 15),
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
                width: puma ? 55 : 130,
                height: puma ? 50 : 60,
                decoration: BoxDecoration(
                    color:
                        puma ? AppColors.lightCardColor : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                margin: const EdgeInsets.only(right: 20),
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
                        margin: const EdgeInsets.only(left: 2),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: SvgPicture.asset(
                          "assets/svg/puma.svg",
                          width: puma ? 50 : 45,
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.clip,
                        puma ? "" : "Puma",
                        style: const TextStyle(
                            color: AppColors.lightCardColor, fontSize: 17),
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
                width: nike ? 60 : 130,
                height: nike ? 55 : 60,
                decoration: BoxDecoration(
                    color:
                        nike ? AppColors.lightCardColor : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                margin: const EdgeInsets.only(right: 20),
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
                                BorderRadius.all(Radius.circular(30))),
                        child: SvgPicture.asset(
                          "assets/svg/nike-logo.svg",
                          width: nike ? 55 : 47,
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.clip,
                        nike ? "" : "Nike",
                        style: const TextStyle(
                            color: AppColors.lightCardColor, fontSize: 17),
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
                width: jordan ? 72 : 135,
                height: jordan ? 60 : 60,
                decoration: BoxDecoration(
                    color: jordan
                        ? AppColors.lightCardColor
                        : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                margin: const EdgeInsets.only(right: 20),
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
                                left: 10, right: 10, top: 10, bottom: 10),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            "assets/svg/jordan.svg",
                            width: jordan ? 55 : 30,
                          ),
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.clip,
                        jordan ? "" : " Jordans ",
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
                width: louis ? 55 : 154,
                height: louis ? 50 : 60,
                decoration: BoxDecoration(
                    color:
                        louis ? AppColors.lightCardColor : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                margin: const EdgeInsets.only(right: 20),
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
                        height: 45,
                        width: 50,
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            "assets/svg/louis-vuitton.svg",
                            height: 20,
                            width: louis ? 50 : 45,
                          ),
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.clip,
                        louis ? "" : " Louis Vuitton ",
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
                width: fila ? 50 : 130,
                height: fila ? 50 : 60,
                decoration: BoxDecoration(
                    color:
                        fila ? AppColors.lightCardColor : AppColors.brandColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                margin: const EdgeInsets.only(right: 20),
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
                        height: 50,
                        width: 50,
                        margin: fila
                            ? const EdgeInsets.only(left: 0, right: 0)
                            : const EdgeInsets.only(left: 10, right: 10),
                        decoration: const BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: SvgPicture.asset(
                            "assets/svg/fila.svg",
                            width: fila ? 60 : 55,
                          ),
                        ),
                      ),
                      Text(
                        // overflow: TextOverflow.clip,
                        fila ? "" : "Fila",
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
