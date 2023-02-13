import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

@immutable
class CustomTheme {
  const CustomTheme({
    this.primaryColor = const Color(0xFF356859),
    this.tertiaryColor = const Color(0xFFFF5722),
    this.neutralColor = const Color(0xFFFFFBE6),
});

  final primaryColor, tertiaryColor, neutralColor;

  ThemeData toThemeData() {
    return ThemeData(useMaterial3: true);
  }

  ThemeData _base() {
    final primaryTextTheme = GoogleFonts.lektonTextTheme();
    final secondaryTextTheme = GoogleFonts.montserratTextTheme();
    final textTheme = primaryTextTheme.copyWith(displaySmall: secondaryTextTheme.displaySmall);

    return ThemeData(textTheme: textTheme);
  }

  Scheme _scheme() {
    final base = CorePalette.of(primaryColor.value);
    final primary = base.primary;
    final tertiary = CorePalette.of(tertiaryColor.value).primary;
    final neutral = CorePalette.of(neutralColor.value).neutral;
    return Scheme(primary: primary.get(40), onPrimary: primary.get(100), primaryContainer: primary.get(90), onPrimaryContainer: primary.get(10), secondary: base.secondary.get(40), onSecondary: base.secondary.get(100), secondaryContainer: base.secondary.get(90), onSecondaryContainer: base.secondary.get(10), tertiary: tertiary.get(40), onTertiary: tertiary.get(100), tertiaryContainer: tertiary.get(90), onTertiaryContainer: tertiary.get(10), error: base.error.get(40), onError: base.error.get(100), errorContainer: base.error.get(90), onErrorContainer: base.error.get(10), background: neutral.get(99), onBackground: neutral.get(10), surface: neutral.get(99), onSurface: neutral.get(10), outline: base.neutralVariant.get(50), outlineVariant: base.neutralVariant.get(80), surfaceVariant: base.neutralVariant.get(90), onSurfaceVariant: base.neutralVariant.get(30), shadow: neutral.get(0), scrim: neutral.get(0), inverseSurface: neutral.get(20), inverseOnSurface: neutral.get(95), inversePrimary: primary.get(80),);
  }


}