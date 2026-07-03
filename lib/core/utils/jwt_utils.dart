import 'dart:convert';

class JwtUtils {
  /// Decodes the JWT token payload and returns it as a Map.
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

  /// Extracts the user's role from the JWT token.
  static String? getRole(String token) {
    final payload = decodeToken(token);
    if (payload == null) return null;

    // ASP.NET Identity usually stores roles in this specific claim URL, 
    // or sometimes just under the key "role".
    final roleClaim = payload['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] ?? payload['role'];

    if (roleClaim is List) {
      return roleClaim.isNotEmpty ? roleClaim.first.toString() : null;
    }
    return roleClaim?.toString();
  }
}
