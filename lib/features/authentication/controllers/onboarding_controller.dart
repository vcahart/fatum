import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import '../../../constants/colors.dart';

import '../models/onboard_model.dart';
import '../screens/welcome/welcome_screen.dart';


class OnBoardingController extends GetxController {
  final LiquidController controller = LiquidController();
  RxInt currentPage = 0.obs;

  // Fonction pour passer à la page suivante
  void animateToNextSlide() {
    if (currentPage.value < pages.length - 1) {
      controller.animateToPage(page: currentPage.value + 1);
    } else {
      Get.offAll(() => WelcomeScreen()); // Naviguer vers la page d'accueil
    }
  }

  // Fonction pour gérer le "skip"
  void skip() {
    Get.offAll(() => WelcomeScreen());
  }

  // Fonction callback lors du changement de page
  void onPageChangedCallback(int activePageIndex) {
    currentPage.value = activePageIndex;
  }

 List<OnbordingContent> pages = [
  OnbordingContent(
    title: '1. %Identifiez-vous% en scannant une pièce d\'identité (Passeport, CNI, Permis, etc.)',
    image: 'assets/onboarding/informations.svg',
    description:
        "En partenariat avec Stripe Identity™, seuls votre nom, prénom et date de naissance seront conservés en mémoire.",
  ),
  OnbordingContent(
    title: '2. Renseignez les %informations de contact% de vos proches.',
    image: 'assets/onboarding/following.svg',
    description:
        "Numéro de téléphone, email, adresse postale : vos proches ne seront pas informés de cette démarche.",
  ),
  OnbordingContent(
    title: '3. Chargez des %fichiers% dans votre %coffre-fort%.',
    image: 'assets/onboarding/upload.svg',
    description:
        "Protégez l'accès par un code PIN à 4 chiffres. Ajoutez-y tout type de contenu (documents, vidéos, images…) et choisissez les destinataires : tous vos proches, ou seulement une personne en particulier.",
  ),
  OnbordingContent(
    title: '4. Voilà, c\'est fait ! %À votre décès,% nous nous chargerons de l\'envoi.',
    image: 'assets/onboarding/email_campaign.svg',
    description:
        "Le gouvernement met régulièrement à jour la liste des décès, que nous utilisons pour déclencher l'envoi de vos fichiers à vos proches.",
  ),
];
}
