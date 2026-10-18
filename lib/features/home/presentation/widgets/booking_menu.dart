import 'package:flutter/material.dart';
import 'package:ulin/core/constants/colors_theme.dart';

class BookingMenu extends StatelessWidget {
  const BookingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: WarnaApp.wrGreen,
          ),
          child: Center(
            child: Image.asset(
              'assets/images/booking_menu/hotel.png',
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }
}
