import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 46.w,
      height: 52.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: WarnaApp.wrGreen,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: WarnaApp.wrGrey),
        color: WarnaApp.wrWhite,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ulin1.png',
                  width: 130.w,
                  height: 130.h,
                ),

                SizedBox(height: 60.h),

                TextCustom(
                  "Verify your Email Address",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),

                SizedBox(height: 30.h),

                TextCustom(
                  "kindly check your email for verification link",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: WarnaApp.wrBlack.withValues(alpha: 0.4),
                ),

                SizedBox(height: 30.h),

                Material(
                  color: Colors.transparent,
                  child: Pinput(
                    length: 4,
                    animationCurve: Curves.ease,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: WarnaApp.wrGreen, width: 2),
                      ),
                    ),
                    onCompleted: (code) {},
                  ),
                ),

                SizedBox(height: 26),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCustom("Didn’t recieve a link?", fontSize: 15.sp),

                    SizedBox(width: 7),

                    GestureDetector(
                      onTap: () {},
                      child: TextCustom(
                        "Re-send",
                        fontSize: 15.sp,
                        color: WarnaApp.wrBlue,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 60),

                GestureDetector(
                  onTap: () => context.go('/home'),
                  child: Container(
                    width: 156.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: WarnaApp.wrGreen,
                    ),
                    child: Center(
                      child: TextCustom(
                        "Continue",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: WarnaApp.wrWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
