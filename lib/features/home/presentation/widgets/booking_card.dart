import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Transform.translate(
              offset: const Offset(0, 4),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Opacity(
                  opacity: 0.15,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      WarnaApp.wrBlack,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset('assets/images/banner.png'),
                  ),
                ),
              ),
            ),
            Image.asset('assets/images/banner.png'),
          ],
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 22, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Container(
                    width: 83.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: WarnaApp.wrGreen2,
                    ),
                    child: Center(
                      child: TextCustom(
                        "Upcoming",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: WarnaApp.wrWhite,
                      ),
                    ),
                  ),

                  SizedBox(width: 8),

                  TextCustom(
                    "24 March 2026",
                    fontSize: 10,
                    color: WarnaApp.wrBlack.withValues(alpha: 0.5),
                  ),
                ],
              ),

              SizedBox(height: 4),

              Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  TextCustom(
                    "CGK",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),

                  SizedBox(width: 14),

                  Image.asset(
                    "assets/images/train.png",
                    width: 24.w,
                    height: 24.h,
                  ),

                  SizedBox(width: 26),

                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: 100,
                    lineThickness: 1,
                    dashLength: 6,
                    dashGapLength: 4,
                    dashColor: WarnaApp.wrBlue,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 10.sp,
                    color: WarnaApp.wrBlue,
                  ),

                  SizedBox(width: 18.w),

                  Image.asset(
                    "assets/images/train.png",
                    width: 24.w,
                    height: 24.h,
                  ),

                  SizedBox(width: 14),

                  TextCustom(
                    "DPS",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextCustom(
                    "05:30",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: WarnaApp.wrBlack.withValues(alpha: 0.5),
                  ),
                  TextCustom(
                    "1h 30m",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: WarnaApp.wrBlack.withValues(alpha: 0.5),
                  ),
                  TextCustom(
                    "09:30",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: WarnaApp.wrBlack.withValues(alpha: 0.5),
                  ),
                ],
              ),

              SizedBox(height: 8),

              Row(
                children: [
                  TextCustom(
                    "Santosa",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: WarnaApp.wrBlack.withValues(alpha: 0.5),
                  ),

                  SizedBox(width: 8),

                  Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: WarnaApp.wrBlue,
                    ),
                  ),

                  SizedBox(width: 8),

                  TextCustom(
                    "Economy",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: WarnaApp.wrBlack.withValues(alpha: 0.5),
                  ),

                  SizedBox(width: 8),

                  Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: WarnaApp.wrBlue,
                    ),
                  ),

                  SizedBox(width: 8),

                  TextCustom(
                    "Direct",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: WarnaApp.wrBlack.withValues(alpha: 0.5),
                  ),
                ],
              ),

              SizedBox(height: 5),

              Center(
                child: Divider(
                  thickness: 1,
                  color: WarnaApp.wrBlack.withValues(alpha: 0.1),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextCustom(
                    "Booking ID : ",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: WarnaApp.wrBlue,
                  ),
                  TextCustom(
                    "WAYAWW",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: WarnaApp.wrBlue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
