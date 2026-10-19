import 'package:flutter/material.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';

class BookingMenu extends StatelessWidget {
  const BookingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              
            },
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: WarnaApp.wrWhite,
                    border: Border.all(color: WarnaApp.wrGreen, width: 2)
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/booking_menu/vacation.png',
                      width: 20,
                      height: 20,
                      color: WarnaApp.wrGreen,
                    ),
                  ),
                ),
                TextCustom("Places", fontSize: 11, color: WarnaApp.wrBlack),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              
            },
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: WarnaApp.wrWhite,
                    border: Border.all(color: WarnaApp.wrGreen, width: 2)
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/booking_menu/hotel.png',
                      width: 20,
                      height: 20,
                      color: WarnaApp.wrGreen,
                    ),
                  ),
                ),
                TextCustom("Hotels", fontSize: 11, color: WarnaApp.wrBlack),
              ],
            ),
          ),
      
          GestureDetector(
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: WarnaApp.wrWhite,
                    border: Border.all(color: WarnaApp.wrGreen, width: 2)
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/train.png',
                      width: 20,
                      height: 20,
                      color: WarnaApp.wrGreen,
                    ),
                  ),
                ),
                TextCustom("Trains", fontSize: 11, color: WarnaApp.wrBlack),
              ],
            ),
          ),
      
          GestureDetector(
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: WarnaApp.wrWhite,
                    border: Border.all(color: WarnaApp.wrGreen, width: 2)
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/booking_menu/bus.png',
                      width: 20,
                      height: 20,
                      color: WarnaApp.wrGreen,
                    ),
                  ),
                ),
                TextCustom("Bus", fontSize: 11, color: WarnaApp.wrBlack),
              ],
            ),
          ),
      
          
        ],
      ),
    );
  }
}
