import 'package:flutter/material.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/shopping_cart.dart';
import 'package:main_cartify/utils/app_colors.dart';
import 'package:main_cartify/utils/context_extension.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<ShoppingCartNotifier>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: const BackButton(color: AppColors.blackColor),
        elevation: 0,
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        title: Text(
          context.l10n.cart,
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: Dimension.xmsmallSize,
          ),
        ),
      ),
      body: Column(
        children: [
          /// CART ITEMS
          Expanded(
            child: cart.products.isEmpty
                ? const Center(child: Text('Your Cart is Empty'))
                : ListView.builder(
                    itemCount: cart.products.length,
                    itemBuilder: (context, index) {
                      final product = cart.products[index];

                      return Dismissible(
                        key: Key(product.id.toString()),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(
                            right: Dimension.mediumsize,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: Dimension.mediumsize,
                            vertical: Dimension.small,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.brandColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            color: AppColors.lightCardColor,
                          ),
                        ),

                        /// CONFIRM DELETE
                        confirmDismiss: (direction) async {
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Remove Item'),
                              content: const Text(
                                'Are you sure you want to remove this?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          );

                          if (result == true) {
                            await context
                                .read<ShoppingCartNotifier>()
                                .removeItem(product);
                          }

                          return result;
                        },

                        child: Container(
                          height: Dimension.xmlargeSize,
                          margin: const EdgeInsets.symmetric(
                            horizontal: Dimension.mediumsize,
                            vertical: Dimension.small,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightCardColor,
                            borderRadius: BorderRadius.circular(
                              Dimension.mediumsize,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                /// LEFT SIDE
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: Dimension.small),

                                      Row(
                                        children: [
                                          Text(
                                            'Review (${product.rating?.rate ?? 0}',
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.orange,
                                          ),
                                          const Text(')'),
                                        ],
                                      ),

                                      const SizedBox(height: Dimension.small),

                                      Text(
                                        '\$ ${(product.price ?? 0) * product.quantity}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: Dimension.small),

                                      /// QUANTITY CONTROLS
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              if (product.quantity <= 1) {
                                                await context
                                                    .read<
                                                      ShoppingCartNotifier
                                                    >()
                                                    .removeItem(product);
                                              } else {
                                                await context
                                                    .read<
                                                      ShoppingCartNotifier
                                                    >()
                                                    .deleteProducts(product);
                                              }
                                            },
                                            icon: _circleButton(Icons.remove),
                                          ),
                                          SizedBox(
                                            width: Dimension.xmmmedium,
                                            child: Center(
                                              child: Text(
                                                '${product.quantity}',
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await context
                                                  .read<ShoppingCartNotifier>()
                                                  .updateProducts(product);
                                            },
                                            icon: _circleButton(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                /// IMAGE
                                Container(
                                  width: Dimension.msslargeSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(product.image ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          /// TOTAL SECTION
          Container(
            height: Dimension.msssmallSize,
            padding: const EdgeInsets.all(15),
            color: AppColors.lightCardColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total price:',
                      style: TextStyle(fontSize: Dimension.smallSize),
                    ),
                    Text(
                      '\$ ${cart.total.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: Dimension.xsmallSize),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimension.small),
                      ),
                    ),
                    onPressed: cart.products.isEmpty
                        ? null
                        : () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) =>
                            //         const CheckOut(),
                            //   ),
                            // );
                          },
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimension.xmsmallSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.brandColor,
        borderRadius: BorderRadius.circular(Dimension.mediumsize),
      ),
      padding: const EdgeInsets.all(5),
      child: Icon(
        icon,
        size: Dimension.xmsmallSize,
        color: AppColors.lightCardColor,
      ),
    );
  }
}
