import 'package:flutter/material.dart';

// Couleurs principales
const Color primaryColor = Color(0xFF5F00BA);  // Violet foncé
const Color secondaryColor = Color(0xFF8A2BE2);  // Violet plus clair
const Color accentColor = Color(0xFFFF6F61);  // Rouge orangé

// Couleurs de fond
const Color backgroundColorLight = Color(0xFFFFFFFF);  // Blanc
const Color backgroundColorDark = Color(0xFFF4F4F9);  // Gris très clair

// Couleurs de texte
const Color titleTextColor = Color(0xFF363636);  // Noir pour les titres
const Color bodyTextColor = Color(0xFFE5E5E5);  // Gris clair pour le texte principal
const Color secondaryTextColor = Color(0xFF7D7D7D);  // Gris moyen pour le texte secondaire

// Couleurs d'état
const Color successColor = Color(0xFF4CAF50);  // Vert pour le succès
const Color errorColor = Color(0xFFFF3B30);  // Rouge pour les erreurs
const Color warningColor = Color(0xFFFFC107);  // Jaune pour les avertissements

// Styles de texte avec les polices choisies
const TextStyle titleTextStyle = TextStyle(
  fontFamily: 'Playfair Display',
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: titleTextColor,
);

const TextStyle subtitleTextStyle = TextStyle(
  fontFamily: 'Playfair Display',
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: titleTextColor,
);

const TextStyle bodyTextStyle = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontSize: 18,
  color: bodyTextColor,
);

const TextStyle secondaryTextStyle = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontSize: 16,
  color: secondaryTextColor,
);