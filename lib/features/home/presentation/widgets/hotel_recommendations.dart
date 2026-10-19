import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';

class HotelsRecommendation extends StatelessWidget {
  const HotelsRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextCustom(
              "Hotel Recommendations for you",
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
            TextCustom("See All", fontSize: 13.sp, color: WarnaApp.wrBlue),
          ],
        ),

        SizedBox(height: 8),

        Container(
          width: double.infinity,
          height: 100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: WarnaApp.wrWhite,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 99.w,
                  height: double.infinity,
                  child: Image.asset(
                    "assets/images/places/gunung.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom("Swiss-Belhotel Rainforest Kuta", fontSize: 11.sp, fontWeight: FontWeight.w600, color: WarnaApp.wrGreen, maxLines: 1, overflow: TextOverflow.ellipsis,),
                
                      SizedBox(height: 4,),
                
                      TextCustom("Jl. Sunset Road No. 101, Kuta, Bali , Indonesia", fontSize: 11.sp,  maxLines: 1, overflow: TextOverflow.ellipsis, color: WarnaApp.wrBlack.withValues(alpha: 0.4),),
                
                      SizedBox(height: 14,),
                
                      Row(
                        children: [
                          Icon(Icons.star_outlined, color: WarnaApp.wrYellow, size: 18,),
                          SizedBox(width: 3,),
                          TextCustom("4-Star Hotel", fontSize: 11, fontWeight: FontWeight.w500,)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
