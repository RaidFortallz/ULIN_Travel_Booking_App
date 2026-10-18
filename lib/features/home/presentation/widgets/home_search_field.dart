import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/textfield_custom.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextfieldCustom(
      hintText: "Where to go?",
      prefix: Align(
        alignment: Alignment.centerLeft,
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Image.asset(
            'assets/images/button/search.png',
            width: 24.w,
            height: 24.h,
            color: WarnaApp.wrBlue,
          ),
        ),
      ),
    );
  }
}
