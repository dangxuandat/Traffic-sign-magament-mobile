import 'dart:convert';
import '../../core/network/api_client.dart';
import '../../core/storage/secure_storage.dart';
import '../../shared/models/user.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final SecureStorage _storage;

  AuthRepository({ApiClient? apiClient, SecureStorage? storage})
      : _apiClient = apiClient ?? ApiClient(),
        _storage = storage ?? SecureStorage();

  Future<User> login(String email, String password) async {
    final response = await _apiClient.post(
      '/auth/login',
      body: {'email': email, 'password': password},
      auth: false,
    );

    await _storage.saveToken(response['accessToken']);
    await _storage.saveRefreshToken(response['refreshToken']);
    
    final user = User.fromJson(response['user']);
    await _storage.saveUserData(jsonEncode(user.toJson()));
    
    return user;
  }

  Future<User> register(String email, String password, String displayName) async {
    final response = await _apiClient.post(
      '/auth/register',
      body: {
        'email': email,
        'password': password,
        'displayName': displayName,
      },
      auth: false,
    );

    await _storage.saveToken(response['accessToken']);
    await _storage.saveRefreshToken(response['refreshToken']);
    
    final user = User.fromJson(response['user']);
    await _storage.saveUserData(jsonEncode(user.toJson()));
    
    return user;
  }

  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout');
    } catch (_) {
      // Ignore logout API errors
    } finally {
      await _storage.clearAll();
    }
  }

  Future<User?> getCurrentUser() async {
    final userData = await _storage.getUserData();
    if (userData == null) return null;
    
    try {
      return User.fromJson(jsonDecode(userData));
    } catch (_) {
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    return await _storage.isLoggedIn();
  }

  Future<void> refreshToken() async {
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    final response = await _apiClient.post(
      '/auth/refresh',
      body: {'refreshToken': refreshToken},
      auth: false,
    );

    await _storage.saveToken(response['accessToken']);
    await _storage.saveRefreshToken(response['refreshToken']);
  }
}
