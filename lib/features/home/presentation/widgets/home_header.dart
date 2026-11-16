import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';
import 'package:ulin/features/auth/presentation/bloc/auth_bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    final avatarUrl = user?.avatarUrl;

    return Row(
      children: [
        Container(
          width: 43.w,
          height: 43.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: WarnaApp.wrGreen,
          ),
          child: avatarUrl != null
              ? ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: avatarUrl,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(Icons.person, color: WarnaApp.wrWhite),
        ),

        SizedBox(width: 10),

        Expanded(child: TextCustom("Hi, ${user?.displayName ?? ''}", fontSize: 18, maxLines: 1, overflow: TextOverflow.ellipsis,)),

        SizedBox(width: 10),

        Container(
          width: 38.w,
          height: 38.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: WarnaApp.wrWhite,
            boxShadow: [BoxShadow(color: WarnaApp.wrBlack, blurRadius: 0.1)],
          ),
          child: Center(
            child: Image.asset(
              'assets/images/button/setting.png',
              width: 26.w,
              height: 26.h,
            ),
          ),
        ),

        SizedBox(width: 10),

        Container(
          width: 38.w,
          height: 38.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: WarnaApp.wrWhite,
            boxShadow: [BoxShadow(color: WarnaApp.wrBlack, blurRadius: 0.1)],
          ),
          child: Center(
            child: Image.asset(
              'assets/images/button/notif.png',
              width: 24.w,
              height: 24.h,
            ),
          ),
        ),
      ],
    );
  }
}
