import '../models/user_model.dart';
import '../models/device_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/device_service.dart';
import '../utils/helpers.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();
  final DeviceService _deviceService = DeviceService();

  bool _isInitialized = false;
  UserModel? _currentUser;
  AuthState _authState = AuthState.unknown;

  // Initialize auth service
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _apiService.initialize();
    await _storageService.initialize();
    await _deviceService.initialize();

    await _checkAuthState();

    _isInitialized = true;
    print('🔐 Auth service initialized');
  }

  // Check current authentication state
  Future<void> _checkAuthState() async {
    try {
      _currentUser = _storageService.getUser();

      if (_currentUser != null && _storageService.isUserLoggedIn()) {
        if (_deviceService.isRegistered) {
          _authState = AuthState.authenticated;
          print('✅ User authenticated: ${_currentUser!.username}');
        } else {
          _authState = AuthState.deviceNotRegistered;
          print('⚠️ User exists but device not registered');
        }
      } else {
        _authState = AuthState.unauthenticated;
        print('❌ User not authenticated');
      }
    } catch (e) {
      print('❌ Auth state check failed: $e');
      _authState = AuthState.error;
    }
  }

  // Register device and create user account
  Future<AuthResult> registerDevice() async {
    try {
      print('📱 Starting device registration...');

      _authState = AuthState.registering;

      // Ensure device is properly initialized
      if (_deviceService.currentDevice == null) {
        return AuthResult.failure('Device not initialized');
      }

      // Register device with API
      final registrationSuccess = await _deviceService.registerDevice();
      if (!registrationSuccess) {
        _authState = AuthState.error;
        return AuthResult.failure('Device registration failed');
      }

      // Get user data from API
      final deviceId = _deviceService.deviceId!;
      _currentUser = await _apiService.getUser(deviceId);

      if (_currentUser == null) {
        _authState = AuthState.error;
        return AuthResult.failure('Failed to get user data');
      }

      // Save user data
      await _storageService.saveUser(_currentUser!);
      _authState = AuthState.authenticated;

      print('✅ Device registered and user authenticated');
      return AuthResult.success(_currentUser!);
    } catch (e) {
      print('❌ Device registration failed: $e');
      _authState = AuthState.error;
      return AuthResult.failure('Registration failed: $e');
    }
  }

  // Check if device is already registered
  Future<AuthResult> checkDeviceRegistration() async {
    try {
      if (_deviceService.deviceId == null) {
        return AuthResult.failure('Device ID not available');
      }

      final isRegistered = await _deviceService.checkRegistrationStatus();

      if (isRegistered) {
        _currentUser = _storageService.getUser();
        if (_currentUser != null) {
          _authState = AuthState.authenticated;
          return AuthResult.success(_currentUser!);
        }
      }

      _authState = AuthState.deviceNotRegistered;
      return AuthResult.failure('Device not registered');
    } catch (e) {
      print('❌ Registration check failed: $e');
      _authState = AuthState.error;
      return AuthResult.failure('Registration check failed: $e');
    }
  }

  // Refresh user data from API
  Future<AuthResult> refreshUserData() async {
    try {
      if (_deviceService.deviceId == null) {
        return AuthResult.failure('Device ID not available');
      }

      print('🔄 Refreshing user data...');

      final updatedUser = await _apiService.getUser(_deviceService.deviceId!);

      if (updatedUser.username.isNotEmpty) {
        _currentUser = updatedUser;
        await _storageService.saveUser(_currentUser!);

        print('✅ User data refreshed');
        return AuthResult.success(_currentUser!);
      } else {
        return AuthResult.failure('Invalid user data received');
      }
    } catch (e) {
      print('❌ Failed to refresh user data: $e');
      return AuthResult.failure('Refresh failed: $e');
    }
  }

  // Validate current session
  Future<bool> validateSession() async {
    try {
      if (_currentUser == null || _deviceService.deviceId == null) {
        return false;
      }

      // Check if user data is still valid
      final result = await refreshUserData();
      if (!result.isSuccess) {
        return false;
      }

      // Validate device integrity
      final deviceIntegrity = await _deviceService.validateDeviceIntegrity();
      if (!deviceIntegrity) {
        print('⚠️ Device integrity check failed');
        return false;
      }

      // Check if user account is still active
      if (_currentUser!.status != 'active') {
        print('⚠️ User account is not active: ${_currentUser!.status}');
        return false;
      }

      return true;
    } catch (e) {
      print('❌ Session validation failed: $e');
      return false;
    }
  }

  // Update user profile
  Future<AuthResult> updateUserProfile(Map<String, dynamic> updates) async {
    try {
      if (_currentUser == null) {
        return AuthResult.failure('No user logged in');
      }

      // Update user locally first
      _currentUser = _currentUser!.copyWith(lastLoginAt: DateTime.now());

      await _storageService.saveUser(_currentUser!);
      print('✅ User profile updated');

      return AuthResult.success(_currentUser!);
    } catch (e) {
      print('❌ Failed to update user profile: $e');
      return AuthResult.failure('Profile update failed: $e');
    }
  }

  // Handle subscription status change
  Future<void> updateSubscriptionStatus(bool isPremium) async {
    try {
      if (_currentUser == null) return;

      _currentUser = _currentUser!.copyWith(isPremium: isPremium);
      await _storageService.saveUser(_currentUser!);
      await _storageService.updateUserSubscriptionStatus(isPremium);

      print('💳 Subscription status updated: $isPremium');
    } catch (e) {
      print('❌ Failed to update subscription status: $e');
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      print('👋 Logging out user...');

      _currentUser = null;
      _authState = AuthState.unauthenticated;

      // Clear user data but keep device info
      await _storageService.logout();

      print('✅ User logged out');
    } catch (e) {
      print('❌ Logout failed: $e');
    }
  }

  // Reset authentication (complete reset)
  Future<void> resetAuth() async {
    try {
      print('🔄 Resetting authentication...');

      _currentUser = null;
      _authState = AuthState.unauthenticated;

      // Reset device registration
      await _deviceService.resetDeviceRegistration();

      // Clear all user data
      await _storageService.resetApp();

      print('✅ Authentication reset');
    } catch (e) {
      print('❌ Auth reset failed: $e');
    }
  }

  // Check user permissions
  bool hasPermission(String permission) {
    switch (permission) {
      case 'vpn':
        return _deviceService.hasVpnPermission;
      case 'notifications':
        return _deviceService.hasNotificationPermission;
      case 'premium':
        return _currentUser?.isPremium ?? false;
      default:
        return false;
    }
  }

  // Request permissions
  Future<bool> requestPermission(String permission) async {
    try {
      switch (permission) {
        case 'vpn':
          // VPN permission is handled by the VPN service
          return true;
        case 'notifications':
          // Notification permission is handled by notification service
          return true;
        default:
          return false;
      }
    } catch (e) {
      print('❌ Permission request failed: $e');
      return false;
    }
  }

  // Get user account summary
  Map<String, dynamic> getUserAccountSummary() {
    if (_currentUser == null) {
      return {'status': 'not_logged_in', 'message': 'No user logged in'};
    }

    return {
      'username': _currentUser!.username,
      'status': _currentUser!.status,
      'is_premium': _currentUser!.isPremium,
      'is_expired': _currentUser!.isExpired,
      'data_usage_percentage': _currentUser!.dataUsagePercentage,
      'remaining_data': _currentUser!.remainingData,
      'created_at': _currentUser!.createdAt.toIso8601String(),
      'last_login': _currentUser!.lastLoginAt?.toIso8601String(),
      'time_until_expiry': _currentUser!.timeUntilExpiry?.inDays,
      'device_registered': _deviceService.isRegistered,
      'auth_state': _authState.name,
    };
  }

  // Check if onboarding is needed
  bool needsOnboarding() {
    return !_storageService.isOnboardingCompleted() ||
        _authState == AuthState.deviceNotRegistered;
  }

  // Complete onboarding
  Future<void> completeOnboarding() async {
    try {
      await _storageService.setOnboardingCompleted(true);
      await _storageService.setFirstLaunch(false);
      print('✅ Onboarding completed');
    } catch (e) {
      print('❌ Failed to complete onboarding: $e');
    }
  }

  // Check if user setup is complete
  bool isSetupComplete() {
    return _authState == AuthState.authenticated &&
        _storageService.isOnboardingCompleted() &&
        _deviceService.isRegistered;
  }

  // Get authentication status for UI
  AuthStatus getAuthStatus() {
    return AuthStatus(
      isAuthenticated: _authState == AuthState.authenticated,
      isRegistered: _deviceService.isRegistered,
      needsOnboarding: needsOnboarding(),
      isSetupComplete: isSetupComplete(),
      user: _currentUser,
      authState: _authState,
    );
  }

  // Getters
  UserModel? get currentUser => _currentUser;
  AuthState get authState => _authState;
  bool get isAuthenticated => _authState == AuthState.authenticated;
  bool get isRegistered => _deviceService.isRegistered;
  bool get isPremium => _currentUser?.isPremium ?? false;
  String? get userId => _currentUser?.username;
  String? get deviceId => _deviceService.deviceId;

  // Dispose resources
  void dispose() {
    _isInitialized = false;
    _currentUser = null;
    _authState = AuthState.unknown;
    print('🔐 Auth service disposed');
  }
}

// Authentication states
enum AuthState {
  unknown,
  unauthenticated,
  registering,
  deviceNotRegistered,
  authenticated,
  error,
}

// Authentication result
class AuthResult {
  final bool isSuccess;
  final UserModel? user;
  final String? error;

  const AuthResult._({required this.isSuccess, this.user, this.error});

  factory AuthResult.success(UserModel user) {
    return AuthResult._(isSuccess: true, user: user);
  }

  factory AuthResult.failure(String error) {
    return AuthResult._(isSuccess: false, error: error);
  }
}

// Authentication status for UI
class AuthStatus {
  final bool isAuthenticated;
  final bool isRegistered;
  final bool needsOnboarding;
  final bool isSetupComplete;
  final UserModel? user;
  final AuthState authState;

  const AuthStatus({
    required this.isAuthenticated,
    required this.isRegistered,
    required this.needsOnboarding,
    required this.isSetupComplete,
    this.user,
    required this.authState,
  });

  @override
  String toString() {
    return 'AuthStatus(authenticated: $isAuthenticated, registered: $isRegistered, '
        'needsOnboarding: $needsOnboarding, setupComplete: $isSetupComplete)';
  }
}
