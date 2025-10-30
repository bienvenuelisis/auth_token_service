import 'jwt_claims.dart';

abstract class IJwtService {
  JwtClaims? decodeToken(String token);

  Map<String, dynamic>? getTokenPayload(String token);

  bool isTokenExpired(String token);
}
