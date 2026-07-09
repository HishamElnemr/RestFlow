import 'dart:convert';

class JwtUtils {
  static Map<String, dynamic>? decodeToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      final payload = parts[1];
      var normalized = base64Url.normalize(payload);
      final decodedString = utf8.decode(base64Url.decode(normalized));
      return json.decode(decodedString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  static String? getRole(String token) {
    final payload = decodeToken(token);
    if (payload == null) return null;

    final roleClaim = payload['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] ?? payload['role'];

    if (roleClaim is List) {
      return roleClaim.isNotEmpty ? roleClaim.first.toString() : null;
    }
    return roleClaim?.toString();
  }

  static bool isExpired(String token) {
    final payload = decodeToken(token);
    if (payload == null) return true;
    final exp = payload['exp'];
    if (exp == null) return true;
    final expiry = DateTime.fromMillisecondsSinceEpoch(
      (exp as int) * 1000,
      isUtc: true,
    );
    return DateTime.now().toUtc().isAfter(expiry);
  }
}
