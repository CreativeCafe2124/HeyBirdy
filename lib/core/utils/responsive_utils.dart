import 'package:flutter/material.dart';

/// Responsive breakpoints for HeyBirdy app
class ResponsiveBreakpoints {
  /// Mobile phones: width < 600dp
  static const double mobile = 600;

  /// Tablets (small): 600dp <= width < 900dp
  static const double tablet = 900;

  /// Tablets (large) and desktop: width >= 900dp
  static const double desktop = 900;
}

/// Responsive layout utilities for adaptive UI across all platforms
class ResponsiveUtils {
  /// Get the current screen width
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get the current screen height
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get the current device orientation
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  /// Check if current device is mobile (width < 600dp)
  static bool isMobile(BuildContext context) {
    return getWidth(context) < ResponsiveBreakpoints.mobile;
  }

  /// Check if current device is tablet (600dp <= width < 900dp)
  static bool isTablet(BuildContext context) {
    return getWidth(context) >= ResponsiveBreakpoints.mobile &&
        getWidth(context) < ResponsiveBreakpoints.tablet;
  }

  /// Check if current device is desktop/large tablet (width >= 900dp)
  static bool isDesktop(BuildContext context) {
    return getWidth(context) >= ResponsiveBreakpoints.desktop;
  }

  /// Get adaptive padding based on screen size
  static EdgeInsets getAdaptivePadding(BuildContext context) {
    final width = getWidth(context);

    if (width < ResponsiveBreakpoints.mobile) {
      return const EdgeInsets.all(16.0); // Mobile
    } else if (width < ResponsiveBreakpoints.tablet) {
      return const EdgeInsets.all(20.0); // Small tablet
    } else {
      return const EdgeInsets.all(24.0); // Large tablet / desktop
    }
  }

  /// Get adaptive spacing value
  static double getAdaptiveSpacing(BuildContext context,
      {double mobile = 16.0, double tablet = 20.0, double desktop = 24.0}) {
    final width = getWidth(context);

    if (width < ResponsiveBreakpoints.mobile) {
      return mobile;
    } else if (width < ResponsiveBreakpoints.tablet) {
      return tablet;
    } else {
      return desktop;
    }
  }

  /// Get adaptive grid column count for GridView
  /// - Mobile: 2 columns
  /// - Tablet (small): 3 columns
  /// - Tablet (large) / Desktop: 4 columns
  static int getAdaptiveGridColumns(BuildContext context) {
    final width = getWidth(context);

    if (width < ResponsiveBreakpoints.mobile) {
      return 2; // Mobile
    } else if (width < ResponsiveBreakpoints.tablet) {
      return 3; // Small tablet
    } else {
      return 4; // Large tablet / desktop
    }
  }

  /// Get adaptive font size
  static double getAdaptiveFontSize(
    BuildContext context, {
    double mobile = 14.0,
    double tablet = 16.0,
    double desktop = 18.0,
  }) {
    final width = getWidth(context);

    if (width < ResponsiveBreakpoints.mobile) {
      return mobile;
    } else if (width < ResponsiveBreakpoints.tablet) {
      return tablet;
    } else {
      return desktop;
    }
  }

  /// Get adaptive icon size
  static double getAdaptiveIconSize(
    BuildContext context, {
    double mobile = 24.0,
    double tablet = 28.0,
    double desktop = 32.0,
  }) {
    final width = getWidth(context);

    if (width < ResponsiveBreakpoints.mobile) {
      return mobile;
    } else if (width < ResponsiveBreakpoints.tablet) {
      return tablet;
    } else {
      return desktop;
    }
  }

  /// Get adaptive widget size
  static double getAdaptiveSize(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    final width = getWidth(context);

    if (width < ResponsiveBreakpoints.mobile) {
      return mobile;
    } else if (width < ResponsiveBreakpoints.tablet) {
      return tablet;
    } else {
      return desktop;
    }
  }

  /// Get maximum content width for constrained layouts
  static double getMaxContentWidth(BuildContext context) {
    final width = getWidth(context);

    if (width < ResponsiveBreakpoints.mobile) {
      return width - 32; // Mobile: full width - padding
    } else if (width < ResponsiveBreakpoints.tablet) {
      return 800; // Tablet: constrained width
    } else {
      return 1200; // Desktop: constrained width
    }
  }

  /// Get number of cards per row based on screen width
  /// Useful for card-based layouts
  static int getCardsPerRow(BuildContext context, {double cardMinWidth = 250}) {
    final width = getWidth(context);
    return (width / cardMinWidth).floor();
  }

  /// Get device type enum for switch statements
  static DeviceType getDeviceType(BuildContext context) {
    final width = getWidth(context);

    if (width < ResponsiveBreakpoints.mobile) {
      return DeviceType.mobile;
    } else if (width < ResponsiveBreakpoints.tablet) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Get device info summary (useful for debugging)
  static String getDeviceInfo(BuildContext context) {
    final width = getWidth(context);
    final height = getHeight(context);
    final orientation = isPortrait(context) ? 'Portrait' : 'Landscape';
    final deviceType = getDeviceType(context);

    return 'Width: ${width.toStringAsFixed(0)}dp, Height: ${height.toStringAsFixed(0)}dp, Orientation: $orientation, Type: $deviceType';
  }
}

/// Device type enumeration
enum DeviceType { mobile, tablet, desktop }
