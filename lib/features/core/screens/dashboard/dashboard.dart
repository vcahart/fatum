import 'package:flutter/material.dart';
import '/constants/sizes.dart';
import '/constants/text_strings.dart';
import '/features/core/screens/dashboard/widgets/appbar.dart';
import '/features/core/screens/dashboard/widgets/diningHallGrid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 16) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Future<String> getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userName = "user"; // Default fallback name
    if (user != null) {
      try {
        DocumentSnapshot bmiForm = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .collection('forms')
            .doc('bmiForm')
            .get();

        if (bmiForm.exists) {
          Map<String, dynamic>? data = bmiForm.data() as Map<String, dynamic>?;
          if (data != null && data.containsKey('name')) {
            userName = capitalize(data['name']);
          }
        }
      } catch (e) {
        print("Error fetching user name: $e");
      }
    }
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    //Dark mode
    // Example dining hall data - ideally, this would come from a model or service
    final List<Map<String, String>> diningHalls = [
      {
        'displayName': 'Oakes \n Rachel-Carson', // Display name for UI
        'firebaseName': 'RachelCarsonOakesDiningHall', // Firestore Document ID
        'image': 'assets/images/dashboard/oc.png', // Image path
      },
      {
        'displayName': 'Porter \n Kresge',
        'firebaseName': 'PorterKresgeDiningHall',
        'image': 'assets/images/dashboard/pk.png',
      },
      {
        'displayName': 'College 9\n John R Lewis',
        'firebaseName': 'CollegeNineJohnR.LewisDiningHall',
        'image': 'assets/images/dashboard/cj.png',
      },
      {
        'displayName': 'Cowell \n Stevenson',
        'firebaseName': 'CowellStevensonDiningHall',
        'image': 'assets/images/dashboard/cs.png',
      },
      {
        'displayName': 'Crown \n Merrill',
        'firebaseName': 'CrownMerrillDiningHall',
        'image': 'assets/images/dashboard/cm.png',
      },
      {
        'displayName': 'Cafés',
        'firebaseName': 'CafesDiningHall', // Example, adjust based on actual Firestore document ID
        'image': 'assets/images/dashboard/cafe.png',
      },
    ];


    return SafeArea(
      child: Scaffold(
        appBar: DashboardAppBar(isDark: isDark),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(tDashboardTitle, style: txtTheme.bodyMedium),
              Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: FutureBuilder<String>(
                        future: getUserName(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          String displayName = snapshot.hasData ? snapshot.data! : "User";
                          return Text(
                            '${getGreeting()}, $displayName!',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Text(tDashboardHeading, style: txtTheme.displayMedium),
              const SizedBox(height: tDashboardPadding),

              // Wrapped GridView.builder in an Expanded widget
              DiningHallGrid(diningHalls: diningHalls)
            ],
          ),
        ),
      ),
    );
  }
}
