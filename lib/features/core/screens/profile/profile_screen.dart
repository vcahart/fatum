
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../authentication/screens/onboarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/common_widgets/buttons/primary_button.dart';
import '/constants/sizes.dart';
import '/constants/text_strings.dart';
import '/features/core/screens/profile/update_profile_screen.dart';
import '/features/core/screens/profile/update_dietary_preferences.dart';
import '/features/core/screens/profile/update_bmi.dart';
import '/features/core/screens/profile/widgets/profile_menu.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '/features/core/screens/update_password/updatepassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/features/core/screens/faq/faq.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<String?> getUserProfileImageUrl() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .get();
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
        return userData?['profileImageUrl']; // Adjust the field name if necessary
      } catch (e) {
        print("Error fetching user profile image URL: $e");
        return null;
      }
    }
    return null;
  }

  Future<String> getRandomImageUrl() async {
    final List<String> imageNames = [
      'pic1.jpg', 'pic2.jpg', 'pic3.jpg', 'pic4.jpg', 'pic5.jpg',
      'pic6.jpg', 'pic7.jpg', 'pic8.jpg', 'pic9.jpg', 'pic10.jpg',
      'pic11.jpg', 'pic12.jpg', 'pic13.jpg',
    ];


    // Logic to fetch image URLs from Firebase Storage
    // For example, let's assume you have a reference to the folder containing images
    // Randomly pick an image
    final String randomImageName = (imageNames..shuffle()).first;
    String imageUrl = await FirebaseStorage.instance.ref(randomImageName).getDownloadURL();

    return imageUrl;
  }



  Future<String> getUserName() async {
  User? user = FirebaseAuth.instance.currentUser;
  String userName = "No Name Available"; // Default value
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
  userName = data['name'];
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left_solid)),
        title: Text(tProfile, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSpace),
          child: Column(
            children: [
              /// -- IMAGE with ICON
              FutureBuilder<String>(
                future: getRandomImageUrl(), // Call the method to get a random image URL
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        radius: 50, // Adjust the radius to fit your layout
                        backgroundImage: NetworkImage(snapshot.data!),
                        backgroundColor: Colors.transparent,
                      );
                    } else {
                      // If there's an error, display a placeholder or an error widget
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade200,
                        child: Icon(Icons.error, color: Colors.grey.shade800),
                      );
                    }
                  } else {
                    // While waiting for the async operation to complete, show a loading indicator.
                    return CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 10),
              FutureBuilder<String>(
                future: getUserName(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(snapshot.data ?? "No Name Available", style: Theme.of(context).textTheme.headlineMedium);
                  } else {
                    // While waiting for the async operation to complete, show a loading indicator.
                    return CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 5),
              Text(FirebaseAuth.instance.currentUser?.email ?? "No email available", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),

              TPrimaryButton(
                  isFullWidth: false,
                  width: 200,
                  text: tEditProfile,
                  onPressed: () => Get.to(() => UpdateProfileScreen())
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(title: "Update Password", icon: LineAwesomeIcons.key_solid, onPress: () => Get.to(() => UpdatePasswordScreen())),
              ProfileMenuWidget(title: "Update BMI", icon: LineAwesomeIcons.address_card, onPress: () => Get.to(() => UpdateBMIScreen())),
              ProfileMenuWidget(
                  title: "Update Dietary Preferences", icon: LineAwesomeIcons.utensils_solid, onPress: () => Get.to(() => UpdateDietaryPreferencesForm())),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "FAQs", icon: LineAwesomeIcons.question_circle, onPress: () => Get.to(() => FAQScreen())),
              ProfileMenuWidget(
                title: "Delete Account",
                icon: LineAwesomeIcons.trash_solid, // Choose an appropriate icon
                textColor: Colors.red,
                endIcon: false,
                onPress: () => _showDeleteUserModal(context),
              ),
              ProfileMenuWidget(
                title: "Logout",
                icon: LineAwesomeIcons.sign_out_alt_solid,
                textColor: Colors.red,
                endIcon: false,
                onPress: () => _showLogoutModal(),
              ),

            ],
          ),
        ),
      ),
    );
  }



  // _showDeleteUserModal(BuildContext context) {
  //   Get.defaultDialog(
  //     title: "Delete Account",
  //     content: Text("This will permanently delete your account and all associated data. Are you sure you want to proceed?"),
  //     onCancel: () => Get.back(),
  //     onConfirm: () {
  //       Get.back(); // Close the dialog
  //       _promptForReauthentication(context); // Prompt for re-authentication
  //     },
  //     textCancel: "Cancel",
  //     textConfirm: "Delete",
  //     confirmTextColor: Colors.white,
  //     buttonColor: Colors.red, // Check if this named parameter exists in your version or adjust accordingly
  //   );
  // }

  _showDeleteUserModal(BuildContext context) {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20), // Added top padding for the title
      title: "DELETE ACCOUNT",
      titleStyle: const TextStyle(fontSize: 20),
      content: Padding(
        padding: const EdgeInsets.all(20), // Adjusted padding
        child: Text(
          "Do you want to permanently delete your account?",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // Side margins for the buttons
          child: ElevatedButton(
            onPressed: () {
              Get.back(); // Close the dialog
              _promptForReauthentication(context); // Prompt for re-authentication
            }, // Increased font size
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Button color for delete action
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: BorderSide.none, // Remove border
              minimumSize: const Size.fromHeight(45), // Height is specified, width will adapt to the padding
            ),
            child: const Text("DELETE", style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // Side margins and reduced bottom margin for the buttons
          child: ElevatedButton(
            onPressed: () => Get.back(), // Increased font size
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey, // Button color for cancel action
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: BorderSide.none, // Remove border
              minimumSize: const Size.fromHeight(45), // Height is specified, width will adapt to the padding
            ),
            child: const Text("CANCEL", style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ],
    );
  }






  _promptForReauthentication(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    // Show dialog to enter password
    Get.defaultDialog(
      title: "Re-authenticate",
      content: Column(
        children: [
          Text("Please enter your password to confirm."),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: "Password"),
          ),
        ],
      ),
      onCancel: () => Get.back(),
      onConfirm: () async {
        Get.back(); // Close the dialog
        try {
          String email = FirebaseAuth.instance.currentUser!.email!;
          AuthCredential credential = EmailAuthProvider.credential(email: email, password: passwordController.text);
          await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
          // Re-authentication successful, proceed with account deletion
          await _deleteUserAccount();
        } catch (error) {
          Get.snackbar("Error", "Re-authentication failed. Please try again.");
        }
      },
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.white,
    );
  }

  Future<void> _deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      // Handle post-deletion logic, e.g., navigate to login screen
      Get.offAll(() => OnboardingScreen()); // Assuming you have a LoginScreen
    } catch (error) {
      Get.snackbar("Error", "Failed to delete account. Please try again.");
    }
  }


  // _showLogoutModal() {
  //   Get.defaultDialog(
  //     title: "Logout",
  //     titleStyle: const TextStyle(fontSize: 20),
  //     content: const Padding(
  //       padding: EdgeInsets.symmetric(vertical: 15.0),
  //       child: Text("Are you sure, you want to Logout?"),
  //     ),
  //     confirm: TPrimaryButton(
  //       isFullWidth: false,
  //       onPressed: () => AuthenticationRepository.instance.logout(),
  //       text: "Yes",
  //     ),
  //     cancel: SizedBox(width: 100, child: OutlinedButton(onPressed: () => Get.back(), child: const Text("No"))),
  //   );
  // }
  _showLogoutModal() {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20),
      title: "CONFIRM LOGOUT",
      titleStyle: const TextStyle(fontSize: 25),
      content: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "Are you sure, you want to Logout?",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: BorderSide.none, // Ensure no borders
              minimumSize: const Size.fromHeight(45),
            ),
            child: const Text("YES", style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: BorderSide.none, // Ensure no borders
              minimumSize: const Size.fromHeight(45),
            ),
            child: const Text("NO", style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ],
    );
  }








}
