import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';

class PopularDestinations extends StatelessWidget {
  const PopularDestinations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextCustom(
              "Popular Destinations",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            TextCustom("See All", fontSize: 13, color: WarnaApp.wrBlue),
          ],
        ),

        SizedBox(height: 12),

        SizedBox(
          width: 200.w,
          height: 200.h,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(30),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  "assets/images/places/gunung.jpeg",
                  fit: BoxFit.cover,
                ),

                Positioned(
                  top: 12,
                  right: 12,
                  child: Center(
                    child: Image.asset(
                      "assets/images/arrow_north.png",
                      width: 30.w,
                      height: 30.h,
                    ),
                  ),
                ),

                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: WarnaApp.wrBlack.withValues(alpha: 0.5),
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom(
                          "Mount Bromo",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: WarnaApp.wrWhite,
                        ),

                        SizedBox(height: 2),

                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 12.sp,
                              color: WarnaApp.wrWhite,
                            ),
                            SizedBox(width: 2),
                            TextCustom(
                              "East Java",
                              fontSize: 11.sp,
                              color: WarnaApp.wrWhite,
                            ),
                          ],
                        ),

                        SizedBox(height: 4),

                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star_rounded,
                              size: 14.sp,
                              color: WarnaApp.wrYellow,
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
        ),
      ],
    );
  }
}
