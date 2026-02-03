import 'package:flutter/material.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/modules/commons/app_textstyles/app_textstyles.dart';
import 'package:main_cartify/utils/app_colors.dart';
import 'package:main_cartify/utils/context_extension.dart';

class Descriptions extends StatefulWidget {
  final Products products;
  const Descriptions({super.key, required this.products});

  @override
  State<Descriptions> createState() => _DescriptionsState();
}

class _DescriptionsState extends State<Descriptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColors.blackColor),
        elevation: 0,
        backgroundColor: Colors.grey[100],
        title: Text(
          context.l10n.details, 
          style: AppTextstyles.appBarText,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimension.ssmallestSize),
              child: Container(
                margin: const EdgeInsets.only(
                  top: Dimension.xmmmedium,
                  left: Dimension.mslargeSize,
                ),
                height: Dimension.xslargeSize,
                child: Image.network(widget.products.image!),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimension.mediumsize),
              height: Dimension.xxxmlargeSize,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Dimension.xmmmedium),
                  topRight: Radius.circular(Dimension.xmmmedium),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimension.msmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.products.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: Dimension.mediumsize),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ ${widget.products.price}',
                          style: AppTextstyles.xsmallSize,
                        ),
                        Text(
                          '(${widget.products.rating!.count} reviews)',
                          style: TextStyle(
                            fontSize: Dimension.msmall,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimension.small),
                    Row(
                      children: [
                        Text(
                          '${widget.products.rating!.rate}',
                          style: AppTextstyles.xsmallSize,
                        ),
                        const Icon(
                          Icons.star_outlined,
                          color: Colors.orange,
                          size: Dimension.xsmallSize,
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimension.mediumsize),
                    Text(
                      widget.products.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: AppTextstyles.colorgrey,
                    ),
                    const SizedBox(height: Dimension.xmmmedium),
                    Container(
                      width: Dimension.xxslargeSize,
                      margin: const EdgeInsets.only(left: Dimension.msmall),
                      decoration: const BoxDecoration(
                        color: AppColors.brandColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Dimension.xmmmedium),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // add to cart logic
                        },
                        child: Text(
                          'Add to cart', 
                          style: AppTextstyles.xsmallSizelight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
