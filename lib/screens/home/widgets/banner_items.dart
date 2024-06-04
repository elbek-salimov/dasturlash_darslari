import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/models/banner/banner_model.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

class BannerItems extends StatelessWidget {
  const BannerItems({super.key, required this.banners});

  final List<BannerModel> banners;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(
        banners.length,
        (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 25.w),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 160.h,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: banners[index].bannerImageUrl.isNotEmpty
                          ? banners[index].bannerImageUrl
                          : 'https://www.sleepworld.com/on/demandware.static/Sites-Sleepworld-Site/-/default/dw5a35aafc/images/large_missing.jpg',
                      placeholder: (context, url) => Shimmer.fromColors(
                        enabled: true,
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14.h, left: 16.w),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banners[index].bannerSubTitle,
                          style: AppTextStyle.sfProRoundedMedium
                              .copyWith(fontSize: 16.w),
                        ),
                        16.getH(),
                        Text(
                          banners[index].bannerTitle,
                          style: AppTextStyle.sfProRoundedBold
                              .copyWith(fontSize: 22.w),
                        ),
                        10.getH(),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.w),
                            ),
                            side: BorderSide(color: Colors.white, width: 2.w),
                          ),
                          onPressed: () {
                            final uri =
                                Uri.tryParse(banners[index].bannerOnTapUrl);
                            if (uri != null && uri.isAbsolute) {
                              launchUrl(uri);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Incorrect URL: ${banners[index].bannerOnTapUrl}'),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Continue',
                            style: AppTextStyle.sfProRoundedSemiBold
                                .copyWith(fontSize: 16.w),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      options: CarouselOptions(
        height: 160.h,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.easeInOutBack,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
