// API Configuration for Flutter Mobile App
// Contains all environment-specific settings

class AppConfig {
  // API Endpoints
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api/v1',
  );
  
  static const String huggingFaceApiUrl = String.fromEnvironment(
    'HUGGINGFACE_API_URL',
    defaultValue: 'https://your-username-your-space.hf.space',
  );

  // Map Configuration (OpenStreetMap)
  static const String osmTileUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const double defaultLatitude = 10.762622; // Ho Chi Minh City
  static const double defaultLongitude = 106.660172;
  static const double defaultZoom = 13.0;

  // Coin Configuration
  static const int initialCoins = 20;
  static const int submissionCost = 5;
  static const int mapAccessCost = 2;
  static const int voteReward = 1;
  static const int maxDailyVoteRewards = 5;
  static const int submissionApprovalReward = 10;

  // Voting Configuration
  static const int minVotesRequired = 5;
  static const int votingPeriodDays = 7;
  static const double approvalThreshold = 0.70;
  static const double rejectionThreshold = 0.30;

  // App Settings
  static const String appName = 'TSL - Traffic Sign Location';
  static const String appVersion = '1.0.0';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
}
