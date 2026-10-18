
import 'package:material_ui/material_ui.dart';
import 'package:ulin/features/home/presentation/widgets/booking_card.dart';
import 'package:ulin/features/home/presentation/widgets/booking_menu.dart';
import 'package:ulin/features/home/presentation/widgets/home_header.dart';
import 'package:ulin/features/home/presentation/widgets/home_search_field.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
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
                  //booking_menu.dart
                  const BookingMenu(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
