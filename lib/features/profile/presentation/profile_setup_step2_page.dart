import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';

class ProfileSetupStep2Page extends StatelessWidget {
  const ProfileSetupStep2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextCustom(
          "Add Profile Picture",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: GestureDetector(
              onTap: () => context.push('/emailverification'),
              child: TextCustom(
                "Skip",
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: WarnaApp.wrBlue,
              ),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 175.w,
                  height: 175.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: WarnaApp.wrGrey,
                  ),
                  child: Center(child: Icon(Icons.person, size: 110)),
                ),
              ),

              SizedBox(height: 50),

              Container(
                width: double.infinity,
                height: 51.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: WarnaApp.wrGreen),
                  color: WarnaApp.wrWhite,
                ),
                child: Center(
                  child: TextCustom(
                    "Select Profile Picture",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: WarnaApp.wrBlue,
                  ),
                ),
              ),

              SizedBox(height: 50),

              TextCustom(
                "Your Photo Should :",
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: WarnaApp.wrBlack,
                    ),
                  ),
                  SizedBox(width: 10),

                  TextCustom(
                    "Show your face clearly",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: WarnaApp.wrBlack,
                    ),
                  ),
                  SizedBox(width: 10),

                  TextCustom(
                    "Be a close-up face",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: WarnaApp.wrBlack,
                    ),
                  ),
                  SizedBox(width: 10),

                  TextCustom(
                    "Be clear and sharp",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),

              SizedBox(height: 60),

              Center(
                child: GestureDetector(
                  onTap: () => context.push('/emailverification'),
                  child: Container(
                    width: 156.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: WarnaApp.wrGreen,
                    ),
                    child: Center(
                      child: TextCustom(
                        "Save",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: WarnaApp.wrWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
