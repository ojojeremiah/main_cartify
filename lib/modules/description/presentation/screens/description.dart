import 'package:flutter/material.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/l10n/app_localizations.dart';
import 'package:main_cartify/modules/commons/app_textstyles/app_textstyles.dart';
import 'package:main_cartify/utils/app_colors.dart';

class Descriptions extends StatefulWidget {
  const Descriptions({super.key});

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
        title: Container(
          margin: const EdgeInsets.only(left: Dimension.mmsslargeSize),
          child: Text(
            AppLocalizations.of(context)!.searchHere,
            style: AppTextstyles.blackColorms
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimension.ssmallestSize),
              child: Container(
                margin: const EdgeInsets.only(
                  top: Dimension.xmmmedium,
                  left: Dimension.msssslargeSize,
                ),
                height: Dimension.xslargeSize,
                child: Image.network(''),
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
                    Container(
                      margin: const EdgeInsets.only(top: Dimension.mediumsize),
                      child: Text(
                        '',
                        // overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                        // widget.products.title!,
                        // style: const TextStyle(
                        //   fontWeight: FontWeight.bold,
                        // ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: Dimension.mediumsize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '',
                            // '\$ ${widget.products.price}',
                            style: AppTextstyles.xsmallSize
                          ),
                          Text(
                            '',
                            // '(${widget.products.rating!.count!} reviews )',
                            style: TextStyle(
                              fontSize: Dimension.msmall,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: Dimension.xlargeSize),
                      child: Row(
                        children: [
                          Text(
                            '',
                            // "${widget.products.rating!.rate!}",
                            style: AppTextstyles.xsmallSize
                          ),
                          const Icon(
                            Icons.star_outlined,
                            color: Colors.orange,
                            size: Dimension.xsmallSize,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Dimension.mediumsize),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        '',
                        // widget.products.description!,
                        style: AppTextstyles.colorgrey
                      ),
                    ),
                    Container(
                      width: Dimension.xxslargeSize,
                      margin: const EdgeInsets.only(
                        top: Dimension.xmmmedium,
                        left: Dimension.msmall,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.brandColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Dimension.xmmmedium),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // widget.productController
                          //     .updateProducts(widget.products);
                        },
                        child: Text(
                          'Add to Cart',
                          style: AppTextstyles.xsmallSizelight
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
