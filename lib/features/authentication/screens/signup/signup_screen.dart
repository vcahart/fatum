import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/signup_controller.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Inscription",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Form(
                    key: controller.signupFormKey,
                    child: Column(
                      children: [
                        if (controller.step.value == 1) ...[
TextFormField(
  controller: controller.inputController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    if (controller.isEmailMode.value) {
      // Validation de l'e-mail
      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
        return 'Adresse e-mail invalide';
      }
    } else {
      // Validation du numéro de téléphone (10 à 15 chiffres, avec ou sans préfixe +)
      if (!RegExp(r"^\+?[0-9]{10,15}$").hasMatch(value)) {
        return 'Numéro de téléphone invalide';
      }
    }
    return null;
  },
  decoration: InputDecoration(
    labelText: controller.isEmailMode.value ? 'Adresse e-mail' : 'Numéro de téléphone',
    prefixIcon: Icon(controller.isEmailMode.value ? Icons.email : Icons.phone),
  ),
),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () => controller.isEmailMode.value = !controller.isEmailMode.value,
                            child: Text(controller.isEmailMode.value
                                ? "Je préfère utiliser un numéro de téléphone"
                                : "Je préfère utiliser une adresse e-mail"),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: controller.isLoading.value ? null : () => controller.checkEmailOrPhone(),
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text("Continuer"),
                          ),
                        ]
                        else if (controller.step.value == 2) ...[
                          if (controller.isEmailMode.value) ...[
                            if (!controller.isRegistered.value) ...[
                              TextFormField(
                                controller: controller.passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Le mot de passe est obligatoire';
                                  }
                                  if (value.length < 6) {
                                    return 'Le mot de passe doit comporter au moins 6 caractères';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Mot de passe',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: controller.confirmPasswordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez confirmer votre mot de passe';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Confirmer le mot de passe',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: controller.isLoading.value ? null : () => controller.authenticateUser(),
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text("S'inscrire"),
                              ),
                            ]  else ...[
                              TextFormField(
                                controller: controller.passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Le mot de passe est obligatoire';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Mot de passe',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: controller.isLoading.value ? null : () => controller.authenticateUser(),
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text("Se connecter"),
                              ),
                            ],
                          ] else ...[
                            const Text("Veuillez entrer le code OTP envoyé sur votre numéro de téléphone."),
                            // Ajouter ici un champ de saisie pour le code OTP et un bouton pour vérifier
                          ]
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
