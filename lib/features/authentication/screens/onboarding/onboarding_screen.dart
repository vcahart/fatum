import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../../../utils/AnimatedDot.dart';
import '../../controllers/onboarding_controller.dart';
import '../../models/onboard_model.dart';

import 'package:fatum/styles/styles.dart';

class OnboardingScreen extends StatelessWidget {
  final OnBoardingController _onBoardingController =
      Get.put(OnBoardingController()); // Initialiser avec GetX

  Future<void> _storeOnboardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Logo Row
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/logo.png', height: 70, width: 70),
                Obx(() => _onBoardingController.currentPage.value == 0
                    ? Image.asset(
                        'assets/onboarding/stripe.png',
                        height: 70,
                        width: 170,
                      )
                    : SizedBox.shrink()),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: PageController(
                  initialPage: _onBoardingController.currentPage.value),
              onPageChanged: _onBoardingController.onPageChangedCallback,
              itemCount: _onBoardingController.pages.length,
              itemBuilder: (_, i) {
                final OnbordingContent model = _onBoardingController.pages[i];
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(model.image!, height: 156, width: 156),
                      const SizedBox(height: 60),
                      model.getFormattedTitle(
                        context,
                        const TextStyle(
                          fontFamily: 'Playfair Display',
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: titleTextColor,
                        ),
                        const TextStyle(
                          fontFamily: 'Playfair Display',
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        model.title!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 138, 138, 138),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Animated Dots
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onBoardingController.pages.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: AnimatedDot(
                      isActive:
                          _onBoardingController.currentPage.value == index,
                    ),
                  ),
                ),
              )),
          // Button
          Container(
            height: 60,
            margin: const EdgeInsets.all(40),
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                  _onBoardingController.animateToNextSlide();
        
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Obx(() => Text(
                    _onBoardingController.currentPage.value ==
                            _onBoardingController.pages.length - 1
                        ? "Démarrer"
                        : "Suivant",
                  )),
            ),
          ),
        ],
      ),
    );
  }
}