import 'dart:convert';

import 'i_jwt_service.dart';
import 'jwt_claims.dart';

class JwtService implements IJwtService {
  @override
  JwtClaims? decodeToken(String token) {
    try {
      final payload = getTokenPayload(token);
      if (payload == null) return null;

      return JwtClaims.fromJson(payload);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? getTokenPayload(String token) {
    try {
      // Split the token into its parts
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      // Decode the payload (second part)
      final payload = parts[1];

      // Add padding if necessary
      var normalizedPayload = payload;
      switch (payload.length % 4) {
        case 1:
          normalizedPayload += '===';
        case 2:
          normalizedPayload += '==';
        case 3:
          normalizedPayload += '=';
      }

      // Decode from base64
      final decoded = base64Url.decode(normalizedPayload);
      final jsonString = utf8.decode(decoded);

      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  @override
  bool isTokenExpired(String token) {
    try {
      final claims = decodeToken(token);
      return claims?.isExpired ?? true;
    } catch (e) {
      return true;
    }
  }
}
