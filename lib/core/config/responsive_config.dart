/// Responsive design configuration for HeyBirdy
/// Centralized configuration for all responsive breakpoints and values
library responsive_config;

/// Define all responsive breakpoints used across the app
class ResponsiveConfig {
  // === BREAKPOINTS ===
  /// Mobile devices: phones with width < 600dp (4.5" - 5.5")
  static const double mobileBreakpoint = 600;

  /// Tablet devices: width 600dp - 900dp (5.5" - 7")
  static const double tabletBreakpoint = 900;

  /// Desktop devices: width > 900dp (tablets 10"+, laptops)
  static const double desktopBreakpoint = 900;

  // === MOBILE DEVICE SIZING ===
  /// Padding for mobile devices (phones)
  static const double mobilePadding = 16.0;

  /// Spacing between elements on mobile
  static const double mobileSpacing = 16.0;

  /// Grid columns on mobile (2 column layout)
  static const int mobileGridColumns = 2;

  /// Aspect ratio for info cards on mobile (height/width)
  static const double mobileCardAspectRatio = 1.5;

  /// Font size for body text on mobile
  static const double mobileFontSize = 14.0;

  /// Font size for large/headline text on mobile
  static const double mobileHeadlineFontSize = 24.0;

  /// Icon size on mobile
  static const double mobileIconSize = 24.0;

  /// Bottom navigation bar height on mobile
  static const double mobileBottomNavHeight = 80.0;

  /// Chart/widget height on mobile
  static const double mobileChartHeight = 180.0;

  // === TABLET DEVICE SIZING ===
  /// Padding for tablet devices (small tablets, large phones)
  static const double tabletPadding = 20.0;

  /// Spacing between elements on tablet
  static const double tabletSpacing = 20.0;

  /// Grid columns on tablet (3 column layout)
  static const int tabletGridColumns = 3;

  /// Aspect ratio for info cards on tablet
  static const double tabletCardAspectRatio = 2.0;

  /// Font size for body text on tablet
  static const double tabletFontSize = 16.0;

  /// Font size for large/headline text on tablet
  static const double tabletHeadlineFontSize = 28.0;

  /// Icon size on tablet
  static const double tabletIconSize = 28.0;

  /// Bottom navigation bar height on tablet
  static const double tabletBottomNavHeight = 80.0;

  /// Chart/widget height on tablet
  static const double tabletChartHeight = 250.0;

  // === DESKTOP DEVICE SIZING ===
  /// Padding for desktop (large tablets, laptops)
  static const double desktopPadding = 24.0;

  /// Spacing between elements on desktop
  static const double desktopSpacing = 24.0;

  /// Grid columns on desktop (4 column layout)
  static const int desktopGridColumns = 4;

  /// Aspect ratio for info cards on desktop
  static const double desktopCardAspectRatio = 2.5;

  /// Font size for body text on desktop
  static const double desktopFontSize = 16.0;

  /// Font size for large/headline text on desktop
  static const double desktopHeadlineFontSize = 32.0;

  /// Icon size on desktop
  static const double desktopIconSize = 32.0;

  /// Bottom navigation bar height on desktop
  static const double desktopBottomNavHeight = 100.0;

  /// Chart/widget height on desktop
  static const double desktopChartHeight = 350.0;

  // === ANDROID SPECIFIC ===
  /// Android status bar height (approximate)
  static const double androidStatusBarHeight = 24.0;

  /// Android navigation bar height (approximate)
  static const double androidNavBarHeight = 48.0;

  // === iOS SPECIFIC ===
  /// iOS status bar height (safe area)
  static const double iosStatusBarHeight = 44.0;

  /// iOS home indicator height (safe area)
  static const double iosHomeIndicatorHeight = 34.0;

  // === WINDOWS SPECIFIC ===
  /// Windows title bar height
  static const double windowsTitleBarHeight = 32.0;

  /// Windows taskbar height
  static const double windowsTaskbarHeight = 48.0;

  // === ANIMATION & TRANSITION ===
  /// Default animation duration for responsive changes
  static const Duration animationDuration = Duration(milliseconds: 300);

  // === CONSTRAINTS ===
  /// Maximum content width for centered layouts
  static const double maxContentWidth = 1200.0;

  /// Minimum touch target size (Material Design guidelines)
  static const double minTouchTargetSize = 48.0;

  // === CUSTOM GETTERS FOR CONVENIENCE ===

  /// Get all mobile values as a map
  static Map<String, double> getMobileConfig() => {
        'padding': mobilePadding,
        'spacing': mobileSpacing,
        'fontSize': mobileFontSize,
        'iconSize': mobileIconSize,
        'cardAspectRatio': mobileCardAspectRatio,
        'bottomNavHeight': mobileBottomNavHeight,
        'chartHeight': mobileChartHeight,
      };

  /// Get all tablet values as a map
  static Map<String, double> getTabletConfig() => {
        'padding': tabletPadding,
        'spacing': tabletSpacing,
        'fontSize': tabletFontSize,
        'iconSize': tabletIconSize,
        'cardAspectRatio': tabletCardAspectRatio,
        'bottomNavHeight': tabletBottomNavHeight,
        'chartHeight': tabletChartHeight,
      };

  /// Get all desktop values as a map
  static Map<String, double> getDesktopConfig() => {
        'padding': desktopPadding,
        'spacing': desktopSpacing,
        'fontSize': desktopFontSize,
        'iconSize': desktopIconSize,
        'cardAspectRatio': desktopCardAspectRatio,
        'bottomNavHeight': desktopBottomNavHeight,
        'chartHeight': desktopChartHeight,
      };

  /// Verify all configuration values are positive
  static bool validateConfig() {
    final values = [
      mobileBreakpoint,
      tabletBreakpoint,
      mobilePadding,
      mobileSpacing,
      tabletPadding,
      tabletSpacing,
      desktopPadding,
      desktopSpacing,
    ];

    for (final value in values) {
      if (value <= 0) {
        throw Exception('Invalid responsive configuration: $value must be > 0');
      }
    }
    return true;
  }
}
