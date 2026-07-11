import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ============================================================
  // RESTFLOW BRAND COLORS
  // ============================================================

  /// Main Restflow brand color.
  /// Used for primary buttons, active elements, links, icons,
  /// selected tabs, and important interactive components.
  static const Color primary = Color(0xFF007F62);

  /// Lighter green used for hover, pressed, and secondary emphasis.
  static const Color primaryLight = Color(0xFF13A37F);

  /// Dark brand green used for sidebar, dark headers, and dark surfaces.
  static const Color primaryDark = Color(0xFF053D2E);

  /// Slightly lighter sidebar green.
  static const Color primaryDarkLight = Color(0xFF0A503D);

  /// Bright Restflow accent green.
  static const Color primaryAccent = Color(0xFF10C997);

  /// Primary color with 20% opacity.
  static const Color primaryOpacity20 = Color(0x33007F62);

  /// Primary color with 10% opacity.
  static const Color primaryOpacity10 = Color(0x1A007F62);

  /// Primary color with 8% opacity.
  static const Color primaryOpacity08 = Color(0x14007F62);

  /// Soft green background used for badges, selected states,
  /// highlighted containers, and read-only labels.
  static const Color primarySoft = Color(0xFFECFDF5);

  /// Slightly stronger soft green.
  static const Color primarySoftStrong = Color(0xFFD9F8EC);

  /// Green border used around badges and selected controls.
  static const Color primaryBorder = Color(0xFFA7EBCF);

  // ============================================================
  // COMPATIBILITY ALIASES
  // Keep these names temporarily so existing widgets do not break.
  // They now use the Restflow green palette.
  // ============================================================

  static const Color electricBlue = Color(0xFF10A981);

  static const Color purple = Color(0xFF007F62);
  static const Color purpleDeep = Color(0xFF055B46);
  static const Color purpleLight = Color(0xFFD9F8EC);
  static const Color purpleSoft = Color(0xFFF0FDF8);
  static const Color purpleAccent = Color(0xFF10C997);
  static const Color purpleDeepAccent = Color(0xFF064E3B);
  static const Color purpleLavenderLight = Color(0xFFE8FAF3);

  // ============================================================
  // SUCCESS COLORS
  // ============================================================

  static const Color oliveGreen = Color(0xFF3E8E63);
  static const Color oliveGreenOpacity20 = Color(0x333E8E63);
  static const Color oliveGreenLight = Color(0xFFE8F6EE);

  static const Color forestGreen = Color(0xFF166534);

  static const Color success = Color(0xFF16A66A);
  static const Color successDark = Color(0xFF087443);
  static const Color successLight = Color(0xFF6EDBB0);
  static const Color successBg = Color(0xFFF0FDF4);
  static const Color successBright = Color(0xFF22C55E);
  static const Color successBorder = Color(0xFFBBF7D0);

  // ============================================================
  // WARNING COLORS
  // ============================================================

  static const Color amber = Color(0xFFB7791F);
  static const Color amberOpacity20 = Color(0x33B7791F);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningDark = Color(0xFF92400E);
  static const Color warningLight = Color(0xFFFCD34D);
  static const Color warningBg = Color(0xFFFFFBEB);
  static const Color warningBorder = Color(0xFFFDE68A);

  static const Color orange = Color(0xFFEF9F27);
  static const Color darkOrange = Color(0xFF854F0B);
  static const Color brightOrange = Color(0xFFF97316);

  // ============================================================
  // ERROR COLORS
  // ============================================================

  static const Color error = Color(0xFFE5484D);
  static const Color errorDark = Color(0xFFB42318);
  static const Color darkRed = Color(0xFFA32D2D);
  static const Color errorLight = Color(0xFFFFA8A8);
  static const Color errorBg = Color(0xFFFFF1F2);
  static const Color errorBorder = Color(0xFFFECACA);

  // ============================================================
  // INFORMATION COLORS
  // Kept only for informational states, not as a main brand color.
  // ============================================================

  static const Color info = Color(0xFF2563EB);
  static const Color infoDark = Color(0xFF1D4ED8);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoBg = Color(0xFFEFF6FF);
  static const Color infoBorder = Color(0xFFBFDBFE);

  // ============================================================
  // BACKGROUNDS AND SURFACES
  // ============================================================

  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteOpacity80 = Color(0xCCFFFFFF);
  static const Color whiteOpacity20 = Color(0x33FFFFFF);

  /// Main app background.
  static const Color backgroundLight = Color(0xFFF7F8FA);

  /// Main card and dialog surface.
  static const Color surface = Color(0xFFFFFFFF);

  /// Secondary surface for inputs and subtle sections.
  static const Color surfaceLight = Color(0xFFFAFBFC);

  /// Slightly darker surface for disabled or grouped content.
  static const Color surfaceMuted = Color(0xFFF3F4F6);

  /// Green-tinted surface used for selected items.
  static const Color surfaceSelected = Color(0xFFECFDF5);

  // ============================================================
  // BORDERS AND DIVIDERS
  // ============================================================

  static const Color borderLight = Color(0xFFE4E7EC);
  static const Color borderMedium = Color(0xFFD0D5DD);
  static const Color borderDark = Color(0xFF98A2B3);

  static const Color divider = Color(0xFFEAECF0);

  // Existing compatibility colors.
  static const Color warmGray = Color(0xFFE0DDD6);
  static const Color ivory = Color(0xFFF1EFE8);
  static const Color cream = Color(0xFFFAEEDA);

  // ============================================================
  // TEXT COLORS
  // ============================================================

  /// Main heading and strong text color.
  static const Color textPrimary = Color(0xFF101828);

  /// Body text.
  static const Color textSecondary = Color(0xFF475467);

  /// Muted labels, captions, and helper text.
  static const Color textMuted = Color(0xFF98A2B3);

  /// Disabled text.
  static const Color textDisabled = Color(0xFFB8BEC9);

  /// Text displayed over dark green backgrounds.
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  /// Muted sidebar text.
  static const Color textOnDarkMuted = Color(0xFF9AB7AE);

  static const Color mutedGray = Color(0xFF667085);

  // ============================================================
  // DARK COLORS
  // ============================================================

  /// Kept for compatibility with existing code.
  /// Updated to Restflow's dark green instead of dark navy.
  static const Color darkNavy = Color(0xFF053D2E);

  static const Color darkNavyOpacity50 = Color(0x80053D2E);
  static const Color darkNavyOpacity80 = Color(0xCC053D2E);

  static const Color darkSurface = Color(0xFF032E23);
  static const Color darkSurfaceLight = Color(0xFF0A503D);

  // ============================================================
  // SIDEBAR COLORS
  // ============================================================

  static const Color sidebarBackground = Color(0xFF053D2E);

  static const Color sidebarActiveBackground = Color(0xFF1E5143);

  static const Color sidebarHoverBackground = Color(0xFF13483A);

  static const Color sidebarActiveIndicator = Color(0xFF10C997);

  static const Color sidebarText = Color(0xFFFFFFFF);

  static const Color sidebarTextMuted = Color(0xFF91AFA6);

  static const Color sidebarIcon = Color(0xFF91AFA6);

  static const Color sidebarActiveIcon = Color(0xFF10C997);

  // ============================================================
  // INPUT COLORS
  // ============================================================

  static const Color inputBackground = Color(0xFFFAFBFC);
  static const Color inputBorder = Color(0xFFDCE1E7);
  static const Color inputFocusedBorder = Color(0xFF10A981);
  static const Color inputPlaceholder = Color(0xFFA0A8B7);
  static const Color inputDisabledBackground = Color(0xFFF2F4F7);

  // ============================================================
  // GOOGLE COLORS
  // Keep unchanged because these are official Google brand colors.
  // ============================================================

  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color googleRed = Color(0xFFEA4335);
  static const Color googleYellow = Color(0xFFFBBC05);

  // ============================================================
  // RESTFLOW GRADIENTS
  // ============================================================

  /// Main Restflow green gradient.
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF055B46),
      Color(0xFF076B52),
      Color(0xFF08795D),
      Color(0xFF078568),
      Color(0xFF079574),
      Color(0xFF0AA47F),
      Color(0xFF10B68C),
      Color(0xFF10C997),
    ],
    stops: [
      0.0,
      0.14,
      0.28,
      0.42,
      0.56,
      0.70,
      0.84,
      1.0,
    ],
  );

  /// Former electric blue gradient.
  /// Uses Restflow accent greens for compatibility.
  static const LinearGradient electricBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF10C997),
      Color(0xFF007F62),
    ],
  );

  /// Former purple gradient.
  /// Changed to a Restflow horizontal green gradient.
  static const LinearGradient purpleHorizontalGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF007F62),
      Color(0xFF10C997),
    ],
  );

  /// Former purple diagonal gradient.
  /// Changed to a Restflow diagonal green gradient.
  static const LinearGradient purpleDiagonalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF10C997),
      Color(0xFF007F62),
    ],
  );

  /// Former blue soft gradient.
  /// Changed to a soft Restflow green background.
  static const LinearGradient skyBlueSoftGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF0FDF8),
      Color(0x80D9F8EC),
    ],
  );

  static const LinearGradient successSoftGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF0FDF4),
      Color(0x80DCFCE7),
    ],
  );

  /// Former purple soft gradient.
  /// Changed to a soft Restflow green gradient.
  static const LinearGradient purpleSoftGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF0FDF8),
      Color(0x80E8FAF3),
    ],
  );

  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF97316),
      Color(0xFFEA580C),
    ],
  );

  static const LinearGradient orangeSoftGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF7ED),
      Color(0x80FFEDD5),
    ],
  );

  /// Dark sidebar gradient matching the Restflow web product.
  static const LinearGradient sidebarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF064B38),
      Color(0xFF053D2E),
      Color(0xFF032E23),
    ],
  );

  /// Soft selected-item gradient.
  static const LinearGradient selectedSoftGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0x1A10C997),
      Color(0x0D10C997),
    ],
  );
}
