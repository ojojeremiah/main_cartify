import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/utils/app_colors.dart';

class Brands extends StatefulWidget {
  const Brands({super.key});

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  final Map<String, bool> _brandState = {
    'adidas': true,
    'puma': true,
    'nike': true,
    'jordan': true,
    'louis': true,
    'fila': true,
  };

  void _toggle(String key) {
    setState(() {
      _brandState[key] = !_brandState[key]!;
    });
  }

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
            _BrandItem(
              logo: "assets/svg/adidas.svg",
              label: "Adidas",
              expanded: !_brandState['adidas']!,
              onTap: () => _toggle('adidas'),
            ),
            _BrandItem(
              logo: "assets/svg/puma.svg",
              label: "Puma",
              expanded: !_brandState['puma']!,
              onTap: () => _toggle('puma'),
            ),
            _BrandItem(
              logo: "assets/svg/nike-logo.svg",
              label: "Nike",
              expanded: !_brandState['nike']!,
              onTap: () => _toggle('nike'),
            ),
            _BrandItem(
              logo: "assets/svg/jordan.svg",
              label: "Jordans",
              expanded: !_brandState['jordan']!,
              onTap: () => _toggle('jordan'),
            ),
            _BrandItem(
              logo: "assets/svg/louis-vuitton.svg",
              label: "Louis Vuitton",
              expanded: !_brandState['louis']!,
              onTap: () => _toggle('louis'),
            ),
            _BrandItem(
              logo: "assets/svg/fila.svg",
              label: "Fila",
              expanded: !_brandState['fila']!,
              onTap: () => _toggle('fila'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandItem extends StatelessWidget {
  final String logo;
  final String label;
  final bool expanded;
  final VoidCallback onTap;

  const _BrandItem({
    required this.logo,
    required this.label,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
      child: Container(
        width: expanded ? Dimension.mxsslargeSize : Dimension.smlargeSize,
        height: Dimension.smlargeSize,
        margin: const EdgeInsets.only(right: Dimension.mediumsize),
        decoration: BoxDecoration(
          color: expanded ? AppColors.brandColor : AppColors.lightCardColor,
          borderRadius: BorderRadius.circular(Dimension.xmmmedium),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              const SizedBox(width: Dimension.xxssmallest),

              /// Fixed-size rounded icon container
              Container(
                height: Dimension.smmlargeSize ,
                width: Dimension.smmlargeSize,
                decoration: BoxDecoration(
                  color: AppColors.lightCardColor,
                  borderRadius: BorderRadius.circular(Dimension.xmmmedium),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimension.ssmallestSize),
                  child: SvgPicture.asset(
                    logo,
                    // fit: BoxFit.contain,
                  ),
                ),
              ),

              if (expanded) ...[
                const SizedBox(width: Dimension.xxssmallest),
                Expanded(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.lightCardColor,
                      fontSize: Dimension.mxssmall,
                    ),
                  ),
                ),
                const SizedBox(width: Dimension.xxssmallest),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
