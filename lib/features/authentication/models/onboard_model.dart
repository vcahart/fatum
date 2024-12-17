import 'package:flutter/material.dart';

class OnbordingContent {
  String? image;
  String? title;
  String? description;

  OnbordingContent({this.image, this.title, this.description});
  // Méthode pour formater le titre avec RichText
  RichText getFormattedTitle(BuildContext context, TextStyle normalStyle, TextStyle highlightedStyle) {
    // Fonction qui découpe le texte sur les % et applique le style
    List<TextSpan> parseText(String text) {
      List<TextSpan> spans = [];
      RegExp regex = RegExp(r'%([^%]+)%');
      int start = 0;

      // Trouver toutes les occurrences de mots entourés de %
      for (var match in regex.allMatches(text)) {
        // Ajouter le texte avant %
        if (match.start > start) {
          spans.add(TextSpan(
            text: text.substring(start, match.start),
            style: normalStyle,
          ));
        }

        // Ajouter le texte entouré de % avec le style différent
        spans.add(TextSpan(
          
          text: match.group(1),  // Le mot entouré de %
          style: highlightedStyle,
        ));

        start = match.end;
      }

      // Ajouter le reste du texte
      if (start < text.length) {
        spans.add(TextSpan(
          
          text: text.substring(start),
          style: normalStyle,
        ));
      }

      return spans;
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        
        children: parseText(title ?? ''),
      ),
    );
  }
}
