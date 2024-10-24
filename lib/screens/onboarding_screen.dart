import 'package:flutter/material.dart';
import 'package:fatum/models/onboard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fatum/styles/styles.dart'; // Importation des styles

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      Image.asset(
                        contents[i].image!,
                        height: 156,
                        width: 156,
                      ),
                      const SizedBox(height: 60),
                      Text(
                        contents[i].title!,
                        textAlign: TextAlign.center,
                        style: titleTextStyle, // Utilisation de la variable de style
                      ),
                      const SizedBox(height: 50),
                      Text(
                        contents[i].discription!,
                        textAlign: TextAlign.center,
                        style: secondaryTextStyle, // Utilisation de la variable de style
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.all(40),
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  _storeOnboardInfo();
                  Future.delayed(const Duration(milliseconds: 200))
                      .then((value) {
                    Navigator.pushNamed(context, '/welcome');
                  });
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.easeInOut,
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor, // Utilisation de la variable de couleur
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child:
                  Text(currentIndex == contents.length - 1 ? "Démarrer" : "Suivant"),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryColor, // Utilisation de la variable de couleur
      ),
    );
  }
}
