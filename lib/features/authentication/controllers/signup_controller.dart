import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final inputController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isEmailMode = false.obs;
  final isLoading = false.obs;
  final isRegistered = false.obs;
  final step = 1.obs;

  Future<void> checkEmailOrPhone() async {
    if (!signupFormKey.currentState!.validate()) return;
    isLoading(true);

    try {
      final input = inputController.text.trim();

      if (isEmailMode.value) {
        isRegistered.value = await AuthenticationRepository.instance.isUserExistByEmail(input);
      } else {
        // Send OTP for phone
        await AuthenticationRepository.instance.phoneAuthentication(input);
      }
      step.value = 2; // Proceed to the next step
    } catch (e) {
      Get.snackbar("Erreur", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Future<void> authenticateUser() async {
    if (!signupFormKey.currentState!.validate()) return;
    isLoading(true);

    try {
      final input = inputController.text.trim();

      if (isEmailMode.value) {
        if (!isRegistered.value) {
          // Registration with email
          if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
            Get.snackbar("Erreur", "Les mots de passe ne correspondent pas", snackPosition: SnackPosition.BOTTOM);
            isLoading(false);
            return;
          }

          await AuthenticationRepository.instance.registerWithEmailAndPassword(input, passwordController.text.trim());

          await FirebaseFirestore.instance.collection('users').doc(input).set({
            'email': input,
            'authMethod': 'email',
          });
        } else {
          // Login with email
          await AuthenticationRepository.instance.loginWithEmailAndPassword(input, passwordController.text.trim());
        }
      } else {
        // OTP verification for phone is handled separately
      }

      // Handle success (e.g., navigate to another screen)
    } catch (e) {
      Get.snackbar("Erreur", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
