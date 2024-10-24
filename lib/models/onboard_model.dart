class OnbordingContent {
  String? image;
  String? title;
  String? discription;

  OnbordingContent({this.image, this.title, this.discription});
}

List<OnbordingContent> contents = [
  OnbordingContent(
      title: 'Etape 1 : Identifiez-vous avec un titre d''identité.',
      image: 'assets/onboarding/informations.png',
      discription:
          "You can connect with friends, family and colleagues anytime, anywhere in the world."),
  OnbordingContent(
      title: 'Etape 2 : Ajoutez les informations de contact de vos proches. ',
      image: 'assets/onboarding/following.png',
      discription:
          "You will be able to send messages and images, and connect with people all over the world, "
          "¡Get ready for a unique chat experience!"),
  OnbordingContent(
      title: 'Etape 3 : Uploadez des fichiers dans votre coffre fort.',
      image: 'assets/onboarding/upload.png',
      discription:
          "You will be able to engage in conversations, share experiences and make new friends, "
          "¡Don't wait any longer and start chatting now!"),
  OnbordingContent(
      title: 'Etape 4 : C''est tout. Nous nous occupons du reste.',
      image: 'assets/onboarding/email_campaign.png',
      discription:
          "You will be able to engage in conversations, share experiences and make new friends, "
          "¡Don't wait any longer and start chatting now!"),
];
