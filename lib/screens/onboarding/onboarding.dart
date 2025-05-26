import 'package:charging_station/screens/signin/signin.dart';
import 'package:charging_station/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:charging_station/configs/config.dart';
import 'package:charging_station/utils/utils.dart';
import 'package:charging_station/widgets/app_button.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

final onboardingDefault = [
  {
    "title": 'onboard_base_title',
    "description": 'onboard_basic_message',
    "image": Images.intro1,
    "value": 'basic',
    "domain": 'https://demo.listarapp.com',
  },
  {
    "title": 'onboard_professional_title_1',
    "description": 'onboard_professional_message_1',
    "image": Images.intro2,
    "value": 'food',
    "domain": 'https://food.listarapp.com',
  },
  {
    "title": 'onboard_professional_title_2',
    "description": 'onboard_professional_message_2',
    "image": Images.intro3,
    "value": 'real_estate',
    "domain": 'https://realestate.listarapp.com',
  },
];

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children:
              onboardingDefault.map((item) {
                return Container(
                  // padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .605,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.asset(item['image'] ?? ''),
                        ),
                      ),
                      // SizedBox(height: 50),
                      Container(
                        width: double.infinity,
                        height: 210,
                        color: HexColor("#2269be"),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            const SizedBox(height: 12),
                            Text(
                              "Find Your nearest charging station",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sapien suspendisse gravida mi ullamcorper. Tellus nunc in id cursus viverra placerot duis",
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall?.copyWith(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                AppButton(
                                  Translate.of(context).translate('skip'),
                                  type: ButtonType.text,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  children: [
                                    for (
                                      int i = 0;
                                      i < onboardingDefault.length;
                                      i++
                                    )
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 2,
                                        ),
                                        child: IndicatorDot(
                                          isActive: i == _currentPage,
                                        ),
                                      ),
                                  ],
                                ),

                                AppButton(
                                  Translate.of(context).translate('next'),
                                  type: ButtonType.text,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
      // bottomSheet: _buildBottomSheet(),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final bool isActive;

  const IndicatorDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 15 : 8,
      width: isActive ? 15 : 8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
