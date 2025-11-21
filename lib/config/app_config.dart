class AppConfig {
  final String appName;
  final String apiBaseUrl;
  final bool enableAnalytics;

  const AppConfig({
    required this.appName,
    required this.apiBaseUrl,
    required this.enableAnalytics,
  });
}

const AppConfig kDevConfig = AppConfig(
  appName: 'HeyBirdy (Dev)',
  apiBaseUrl: 'https://api.dev.heybirdy.example',
  enableAnalytics: true,
);

const AppConfig kProdConfig = AppConfig(
  appName: 'HeyBirdy',
  apiBaseUrl: 'https://api.heybirdy.example',
  enableAnalytics: true,
);

