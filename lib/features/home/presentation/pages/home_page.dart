import 'package:material_ui/material_ui.dart';
import 'package:ulin/features/home/presentation/widgets/booking_card.dart';
import 'package:ulin/features/home/presentation/widgets/booking_menu.dart';
import 'package:ulin/features/home/presentation/widgets/home_header.dart';
import 'package:ulin/features/home/presentation/widgets/home_search_field.dart';
import 'package:ulin/features/home/presentation/widgets/hotel_recommendations.dart';
import 'package:ulin/features/home/presentation/widgets/popular_destinations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/bg_home.png",
                  fit: BoxFit.fitWidth,
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //home_header.dart
                      const HomeHeader(),
                      SizedBox(height: 24),
                      //home_search_field.dart
                      const HomeSearchField(),
                      SizedBox(height: 16),
                      //booking_card.dart
                      const BookingCard(),
                      SizedBox(height: 6),
                      //booking_menu.dart
                      const BookingMenu(),
                      SizedBox(height: 12),
                      //popular_destinations.dart
                      const PopularDestinations(),
                      SizedBox(height: 20),
                      //hotels_recommendation.dart
                      const HotelsRecommendation(),
                    ],
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
