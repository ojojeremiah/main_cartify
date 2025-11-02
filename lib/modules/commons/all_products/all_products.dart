import 'package:flutter/material.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/products.dart';
import 'package:main_cartify/utils/app_colors.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  void initState() {
    super.initState();
    context.read<ProductNotifier>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productNotifier = context.watch<ProductNotifier>();

    return SizedBox(
      height: 2000,
      child: GridView.extent(
        physics: const NeverScrollableScrollPhysics(),
        maxCrossAxisExtent: Dimension.xmsslargeSize,
        mainAxisSpacing: Dimension.ssmallestSize,
        crossAxisSpacing: Dimension.ssmallestSize,
        padding: const EdgeInsets.all(Dimension.ssmallestSize),
        children: productNotifier.products.map((item) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) =>
              //     // Descriptions(products: item),
              //   )
              // );
            },
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.lightCardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimension.msmall),
                    ),
                  ),
                  margin: const EdgeInsets.only(left: Dimension.small),
                  height: Dimension.xxslargeSize,
                  width: Dimension.msxlargesize,
                ),
                Container(
                  height: Dimension.msssslargeSize,
                  width: Dimension.mmmsslargeSize,
                  margin: const EdgeInsets.only(
                    left: Dimension.mediumsize,
                    top: Dimension.small,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.small),
                    image: DecorationImage(
                      image: NetworkImage(item.image ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: Dimension.xxssmallest,
                  left: Dimension.mediumsize,
                  child: IconButton(
                    onPressed: () {
                      // favouriteNotifier.updateFavourites(item);
                    },
                    icon: Icon(
                      // isFavourite
                      //     ? Icons.favorite
                      Icons.favorite_outline,
                      color: Colors.redAccent,
                      size: Dimension.mediumsize,
                    ),
                  ),
                ),
                Positioned(
                  top: Dimension.mmssslargeSize,
                  left: Dimension.mediumsize,
                  right: Dimension.mediumsize,
                  child: Text(
                    item.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: Dimension.mxssmall,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: Dimension.msslargeSize,
                  left: Dimension.mediumsize,
                  child: Row(
                    children: [
                      Text('Review (${item.rating?.rate ?? 0})'),
                      const Icon(
                        Icons.star,
                        size: Dimension.xsmallSize,
                        color: Colors.orange,
                      ),
                      const Text(')'),
                    ],
                  ),
                ),
                Positioned(
                  top: Dimension.msslargeSize,
                  right: Dimension.xxssmallest,
                  child: IconButton(
                    onPressed: () {
                      // shoppingCartNotifier.updateProducts(item);
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        color: AppColors.brandColor,
                        borderRadius: BorderRadius.circular(
                          Dimension.mediumsize,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.lightCardColor,
                        size: Dimension.mediumsize,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: Dimension.mxsslargeSize,
                  left: Dimension.mediumsize,
                  child: Text('\$ ${item.price}'),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
