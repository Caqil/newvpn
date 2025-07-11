import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  // Primary Colors
  static const Color primaryColor = CupertinoColors.systemBlue;
  static const Color primaryDarkColor = Color(0xFF0056B3);
  static const Color primaryLightColor = Color(0xFF4A90E2);

  // Accent Colors
  static const Color accentColor = CupertinoColors.systemGreen;
  static const Color secondaryColor = CupertinoColors.systemOrange;

  // Background Colors
  static const Color backgroundColor = CupertinoColors.systemBackground;
  static const Color surfaceColor = CupertinoColors.systemGroupedBackground;
  static const Color cardColor =
      CupertinoColors.secondarySystemGroupedBackground;

  // Text Colors
  static const Color primaryTextColor = CupertinoColors.label;
  static const Color secondaryTextColor = CupertinoColors.secondaryLabel;
  static const Color tertiaryTextColor = CupertinoColors.tertiaryLabel;
  static const Color quaternaryTextColor = CupertinoColors.quaternaryLabel;

  // Status Colors
  static const Color connectedColor = CupertinoColors.systemGreen;
  static const Color connectingColor = CupertinoColors.systemOrange;
  static const Color disconnectedColor = CupertinoColors.systemRed;
  static const Color warningColor = CupertinoColors.systemYellow;
  static const Color errorColor = CupertinoColors.systemRed;
  static const Color infoColor = CupertinoColors.systemBlue;

  // VPN Specific Colors
  static const Color vpnActiveColor = Color(0xFF00C851);
  static const Color vpnInactiveColor = Color(0xFFFF4444);
  static const Color vpnConnectingColor = Color(0xFFFF8800);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF4A90E2),
    Color(0xFF0056B3),
  ];

  static const List<Color> connectedGradient = [
    Color(0xFF00C851),
    Color(0xFF007E33),
  ];

  static const List<Color> disconnectedGradient = [
    Color(0xFFFF4444),
    Color(0xFFCC0000),
  ];

  // Border Colors
  static const Color borderColor = CupertinoColors.separator;
  static const Color activeBorderColor = primaryColor;

  // Shadow Colors
  static const Color shadowColor = CupertinoColors.systemGrey4;

  // Opacity values
  static const double lowOpacity = 0.1;
  static const double mediumOpacity = 0.3;
  static const double highOpacity = 0.7;

  // Border Radius
  static const double smallRadius = 8.0;
  static const double mediumRadius = 12.0;
  static const double largeRadius = 16.0;
  static const double extraLargeRadius = 24.0;

  // Spacing
  static const double extraSmallSpacing = 4.0;
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 16.0;
  static const double largeSpacing = 24.0;
  static const double extraLargeSpacing = 32.0;

  // Text Styles
  static const TextStyle largeTitle = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: primaryTextColor,
  );

  static const TextStyle title1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: primaryTextColor,
  );

  static const TextStyle title2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: primaryTextColor,
  );

  static const TextStyle title3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );

  static const TextStyle headline = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );

  static const TextStyle body = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static const TextStyle callout = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static const TextStyle subhead = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static const TextStyle footnote = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: secondaryTextColor,
  );

  static const TextStyle caption1 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: secondaryTextColor,
  );

  static const TextStyle caption2 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: secondaryTextColor,
  );

  // Button Styles
  static const TextStyle buttonText = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: CupertinoColors.white,
  );

  static const TextStyle linkText = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  );

  // Icon Sizes
  static const double smallIconSize = 16.0;
  static const double mediumIconSize = 24.0;
  static const double largeIconSize = 32.0;
  static const double extraLargeIconSize = 48.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Cupertino Theme Data
  static CupertinoThemeData get cupertinoTheme => const CupertinoThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    barBackgroundColor: surfaceColor,
    textTheme: CupertinoTextThemeData(
      primaryColor: primaryTextColor,
      textStyle: body,
      navTitleTextStyle: headline,
      navLargeTitleTextStyle: largeTitle,
      tabLabelTextStyle: caption1,
    ),
  );

  // Material Theme Data (for compatibility)
  static ThemeData get materialTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceColor,
      foregroundColor: primaryTextColor,
      elevation: 0,
    ),
    cardTheme:  CardThemeData(color: cardColor, elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: CupertinoColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(mediumRadius),
        ),
      ),
    ),
  );

  // Dark Theme (for future use)
  static CupertinoThemeData get darkCupertinoTheme => const CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryLightColor,
    scaffoldBackgroundColor: CupertinoColors.black,
    barBackgroundColor: CupertinoColors.systemGrey6,
    textTheme: CupertinoTextThemeData(primaryColor: CupertinoColors.white),
  );
}

// VPN Status Theme Extensions
extension VpnStatusTheme on ThemeConfig {
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'connected':
        return ThemeConfig.connectedColor;
      case 'connecting':
      case 'disconnecting':
        return ThemeConfig.connectingColor;
      case 'disconnected':
        return ThemeConfig.disconnectedColor;
      case 'error':
        return ThemeConfig.errorColor;
      default:
        return ThemeConfig.secondaryTextColor;
    }
  }

  static IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'connected':
        return CupertinoIcons.checkmark_shield_fill;
      case 'connecting':
        return CupertinoIcons.arrow_clockwise;
      case 'disconnecting':
        return CupertinoIcons.arrow_clockwise;
      case 'disconnected':
        return CupertinoIcons.shield;
      case 'error':
        return CupertinoIcons.exclamationmark_shield_fill;
      default:
        return CupertinoIcons.shield;
    }
  }
}
