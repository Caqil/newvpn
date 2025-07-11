import 'dart:convert';

class Validators {
  // Email validation
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (password.length > 128) {
      return 'Password must be less than 128 characters';
    }

    return null;
  }

  // Strong password validation
  static String? validateStrongPassword(String? password) {
    final basicValidation = validatePassword(password);
    if (basicValidation != null) return basicValidation;

    if (password!.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  // Username validation
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }

    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }

    if (username.length > 50) {
      return 'Username must be less than 50 characters';
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    return null;
  }

  // Phone number validation
  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (digits.length < 10) {
      return 'Please enter a valid phone number';
    }

    if (digits.length > 15) {
      return 'Phone number is too long';
    }

    return null;
  }

  // URL validation
  static String? validateUrl(String? url) {
    if (url == null || url.isEmpty) {
      return 'URL is required';
    }

    try {
      final uri = Uri.parse(url);
      if (!uri.hasScheme || !uri.hasAuthority) {
        return 'Please enter a valid URL';
      }

      if (uri.scheme != 'http' && uri.scheme != 'https') {
        return 'URL must start with http:// or https://';
      }

      return null;
    } catch (e) {
      return 'Please enter a valid URL';
    }
  }

  // VPN config URL validation
  static String? validateVpnConfigUrl(String? configUrl) {
    if (configUrl == null || configUrl.isEmpty) {
      return 'Config URL is required';
    }

    final supportedProtocols = ['vmess://', 'vless://', 'trojan://', 'ss://'];
    final isSupported = supportedProtocols.any(
      (protocol) => configUrl.startsWith(protocol),
    );

    if (!isSupported) {
      return 'Unsupported config format. Supported: VMess, VLESS, Trojan, Shadowsocks';
    }

    try {
      // Try to parse the URL to ensure it's valid
      if (configUrl.startsWith('vmess://')) {
        final encoded = configUrl.substring(8);
        if (encoded.isEmpty) {
          return 'Invalid VMess config format';
        }
      } else {
        Uri.parse(configUrl);
      }

      return null;
    } catch (e) {
      return 'Invalid config URL format';
    }
  }

  // Device name validation
  static String? validateDeviceName(String? deviceName) {
    if (deviceName == null || deviceName.isEmpty) {
      return 'Device name is required';
    }

    if (deviceName.length < 2) {
      return 'Device name must be at least 2 characters';
    }

    if (deviceName.length > 100) {
      return 'Device name must be less than 100 characters';
    }

    if (RegExp(r'[<>:"/\\|?*]').hasMatch(deviceName)) {
      return 'Device name contains invalid characters';
    }

    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Minimum length validation
  static String? validateMinLength(
    String? value,
    int minLength,
    String fieldName,
  ) {
    if (value == null || value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }

  // Maximum length validation
  static String? validateMaxLength(
    String? value,
    int maxLength,
    String fieldName,
  ) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must be less than $maxLength characters';
    }
    return null;
  }

  // Numeric validation
  static String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return '$fieldName must contain only numbers';
    }

    return null;
  }

  // Decimal validation
  static String? validateDecimal(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (double.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }

    return null;
  }

  // Integer range validation
  static String? validateIntRange(
    String? value,
    int min,
    int max,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    final intValue = int.tryParse(value);
    if (intValue == null) {
      return '$fieldName must be a valid number';
    }

    if (intValue < min || intValue > max) {
      return '$fieldName must be between $min and $max';
    }

    return null;
  }

  // Port validation
  static String? validatePort(String? port) {
    return validateIntRange(port, 1, 65535, 'Port');
  }

  // IP address validation
  static String? validateIpAddress(String? ipAddress) {
    if (ipAddress == null || ipAddress.isEmpty) {
      return 'IP address is required';
    }

    final ipRegex = RegExp(
      r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
    );
    if (!ipRegex.hasMatch(ipAddress)) {
      return 'Please enter a valid IP address';
    }

    return null;
  }

  // Domain name validation
  static String? validateDomainName(String? domain) {
    if (domain == null || domain.isEmpty) {
      return 'Domain name is required';
    }

    if (domain.length > 253) {
      return 'Domain name is too long';
    }

    final domainRegex = RegExp(
      r'^[a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?)*$',
    );
    if (!domainRegex.hasMatch(domain)) {
      return 'Please enter a valid domain name';
    }

    return null;
  }

  // Date validation
  static String? validateDate(String? date, String fieldName) {
    if (date == null || date.isEmpty) {
      return '$fieldName is required';
    }

    try {
      DateTime.parse(date);
      return null;
    } catch (e) {
      return 'Please enter a valid date';
    }
  }

  // Future date validation
  static String? validateFutureDate(String? date, String fieldName) {
    final dateValidation = validateDate(date, fieldName);
    if (dateValidation != null) return dateValidation;

    final parsedDate = DateTime.parse(date!);
    if (parsedDate.isBefore(DateTime.now())) {
      return '$fieldName must be in the future';
    }

    return null;
  }

  // Past date validation
  static String? validatePastDate(String? date, String fieldName) {
    final dateValidation = validateDate(date, fieldName);
    if (dateValidation != null) return dateValidation;

    final parsedDate = DateTime.parse(date!);
    if (parsedDate.isAfter(DateTime.now())) {
      return '$fieldName must be in the past';
    }

    return null;
  }

  // Credit card number validation
  static String? validateCreditCard(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) {
      return 'Card number is required';
    }

    // Remove spaces and dashes
    final cleanNumber = cardNumber.replaceAll(RegExp(r'[\s\-]'), '');

    if (!RegExp(r'^[0-9]+$').hasMatch(cleanNumber)) {
      return 'Card number must contain only numbers';
    }

    if (cleanNumber.length < 13 || cleanNumber.length > 19) {
      return 'Please enter a valid card number';
    }

    // Luhn algorithm validation
    if (!_luhnCheck(cleanNumber)) {
      return 'Please enter a valid card number';
    }

    return null;
  }

  // CVV validation
  static String? validateCvv(String? cvv) {
    if (cvv == null || cvv.isEmpty) {
      return 'CVV is required';
    }

    if (!RegExp(r'^[0-9]{3,4}$').hasMatch(cvv)) {
      return 'CVV must be 3 or 4 digits';
    }

    return null;
  }

  // Expiry date validation (MM/YY format)
  static String? validateExpiryDate(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return 'Expiry date is required';
    }

    if (!RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$').hasMatch(expiryDate)) {
      return 'Please enter expiry date in MM/YY format';
    }

    final parts = expiryDate.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse(parts[1]) + 2000; // Convert YY to YYYY

    final now = DateTime.now();
    final expiry = DateTime(year, month + 1, 0); // Last day of expiry month

    if (expiry.isBefore(now)) {
      return 'Card has expired';
    }

    return null;
  }

  // Product ID validation
  static String? validateProductId(String? productId) {
    if (productId == null || productId.isEmpty) {
      return 'Product ID is required';
    }

    // Validate common product ID formats
    final patterns = [
      r'^com\.[a-zA-Z0-9_]+\.[a-zA-Z0-9_]+$', // com.company.product
      r'^[a-zA-Z0-9_]+\.[a-zA-Z0-9_]+$', // company.product
    ];

    final isValid = patterns.any(
      (pattern) => RegExp(pattern).hasMatch(productId),
    );
    if (!isValid) {
      return 'Invalid product ID format';
    }

    return null;
  }

  // Receipt data validation
  static String? validateReceiptData(String? receiptData) {
    if (receiptData == null || receiptData.isEmpty) {
      return 'Receipt data is required';
    }

    if (receiptData.length < 50) {
      return 'Receipt data appears to be invalid';
    }

    return null;
  }

  // Version validation (x.y.z format)
  static String? validateVersion(String? version) {
    if (version == null || version.isEmpty) {
      return 'Version is required';
    }

    if (!RegExp(r'^\d+\.\d+\.\d+$').hasMatch(version)) {
      return 'Version must be in x.y.z format';
    }

    return null;
  }

  // UUID validation
  static String? validateUuid(String? uuid) {
    if (uuid == null || uuid.isEmpty) {
      return 'UUID is required';
    }

    final uuidRegex = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    );
    if (!uuidRegex.hasMatch(uuid)) {
      return 'Please enter a valid UUID';
    }

    return null;
  }

  // Base64 validation
  static String? validateBase64(String? base64) {
    if (base64 == null || base64.isEmpty) {
      return 'Base64 data is required';
    }

    try {
      // Try to decode to validate format
      final decoded = base64Decode(base64);
      if (decoded.isEmpty) {
        return 'Invalid base64 data';
      }
      return null;
    } catch (e) {
      return 'Invalid base64 format';
    }
  }

  // JSON validation
  static String? validateJson(String? json) {
    if (json == null || json.isEmpty) {
      return 'JSON data is required';
    }

    try {
      jsonDecode(json);
      return null;
    } catch (e) {
      return 'Invalid JSON format';
    }
  }

  // Multiple field validation
  static List<String> validateMultiple(List<String? Function()> validators) {
    final errors = <String>[];
    for (final validator in validators) {
      final error = validator();
      if (error != null) {
        errors.add(error);
      }
    }
    return errors;
  }

  // Conditional validation
  static String? validateIf(bool condition, String? Function() validator) {
    return condition ? validator() : null;
  }

  // Custom validation with function
  static String? validateCustom(
    String? value,
    bool Function(String) isValid,
    String errorMessage,
  ) {
    if (value == null || !isValid(value)) {
      return errorMessage;
    }
    return null;
  }

  // Helper method for Luhn algorithm (credit card validation)
  static bool _luhnCheck(String cardNumber) {
    int sum = 0;
    bool alternate = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  // Combine multiple validators
  static String? Function(String?) combineValidators(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }

  // Common validation patterns
  static final RegExp emailPattern = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  static final RegExp phonePattern = RegExp(r'^\+?[1-9]\d{1,14}$');
  static final RegExp urlPattern = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  );
  static final RegExp ipPattern = RegExp(
    r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
  );
  static final RegExp uuidPattern = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );
}
