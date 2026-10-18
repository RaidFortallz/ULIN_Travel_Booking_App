import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _OnboardingPage(item: _items[index]);
                },
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: 314,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: _items.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 3,
                    dotWidth: 8,
                    expansionFactor: 3,
                    spacing: 6,
                    activeDotColor: WarnaApp.wrGreen,
                    dotColor: WarnaApp.wrGrey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            GestureDetector(
              onTap: () => context.push('/login'),
              child: Container(
                width: 287,
                height: 43,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: WarnaApp.wrGreen,
                ),
                child: const Center(
                  child: TextCustom(
                    "Log in",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: WarnaApp.wrWhite,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () => context.push('/register'),
              child: Container(
                width: 287,
                height: 43,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: WarnaApp.wrWhite,
                  border: Border.all(color: WarnaApp.wrGreen),
                ),
                child: const Center(
                  child: TextCustom(
                    "Create Account",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: WarnaApp.wrBlack,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 44),
          ],
        ),
      ),
    );
  }
}

class _onboardingItems {
  final String image1;
  final String image2;
  final String image3;
  final String line1;
  final String line2;
  final String highlight;
  final String description;

  const _onboardingItems({
    required this.image1,
    required this.image2,
    required this.image3,
    required this.line1,
    required this.line2,
    required this.highlight,
    required this.description,
  });
}

const List<_onboardingItems> _items = [
  _onboardingItems(
    image1: 'assets/images/onboarding/onb1.png',
    image2: 'assets/images/onboarding/onb2.png',
    image3: 'assets/images/onboarding/onb7.png',
    line1: "Discovers",
    line2: "Amazing",
    highlight: "Destinations",
    description: "We believe traveling around the world shouldn't be hard.",
  ),
  _onboardingItems(
    image1: 'assets/images/onboarding/onb3.png',
    image2: 'assets/images/onboarding/onb4.png',
    image3: 'assets/images/onboarding/onb8.png',
    line1: "Book",
    line2: "",
    highlight: "Reservations",
    description:
        "We are here to help you book tours with locals on-the-go and experience a wonderful trip. ",
  ),
  _onboardingItems(
    image1: 'assets/images/onboarding/onb5.png',
    image2: 'assets/images/onboarding/onb6.png',
    image3: 'assets/images/onboarding/onb9.png',
    line1: "Find New",
    line2: "Locations",
    highlight: "To Visit",
    description:
        "Worried about new places to visit and explore ? We’ve got you covered.",
  ),
];

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.item});

  final _onboardingItems item;

  @override
  Widget build(BuildContext context) {
    const double canvasWidth = 314;
    const double canvasHeight = 320;
    const double frontWidth = 262;
    const double sidePadding = (canvasWidth - frontWidth) / 2;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: SizedBox(
          width: canvasWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: canvasWidth,
                height: canvasHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // gambar 1
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Image.asset(
                        item.image1,
                        width: 133,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // gambar 2
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Image.asset(
                        item.image2,
                        width: 161,
                        height: 193,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // gambar 3
                    Positioned(
                      bottom: 0,
                      left: sidePadding,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          item.image3,
                          width: frontWidth,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: sidePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      item.line1,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    TextCustom(
                      item.line2,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/images/cust_box.png', width: 260),
                        Positioned(
                          top: 4,
                          left: 20,
                          child: TextCustom(
                            item.highlight,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: WarnaApp.wrWhite,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              TextCustom(
                item.description,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
