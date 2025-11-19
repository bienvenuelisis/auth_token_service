import 'package:json_annotation/json_annotation.dart';

import 'jwt/jwt_claims.dart';
import 'jwt/jwt_service.dart';

part 'auth_token_data.g.dart';

@JsonSerializable()
final class AuthTokenData {
  AuthTokenData({
    required this.token,
    required this.refreshToken,
    required this.expiry,
    this.type = 'Bearer',
  });

  factory AuthTokenData.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenDataFromJson(json);

  final String token;
  final String type;
  final String? refreshToken;
  final DateTime expiry;

  bool get expired => DateTime.now().isAfter(expiry);

  /// Get JWT claims from the token
  JwtClaims? get claims {
    final jwtService = JwtService();

    return jwtService.decodeToken(token);
  }

  /// Get user ID from JWT claims
  String? get userId => claims?.nameIdentifier;

  /// Get user email from JWT claims
  String? get userEmail => claims?.emailAddress;

  /// Get user full name from JWT claims
  String? get userFullName => claims?.fullName;

  /// Get user TIN from JWT claims
  String? get userTin => claims?.getField('tin');

  /// Get user mobile phone from JWT claims
  String? get userMobilePhone => claims?.mobilePhone;

  Map<String, dynamic> toJson() => _$AuthTokenDataToJson(this);
}

@JsonSerializable()
final class RefreshAuthTokenData {
  RefreshAuthTokenData({
    required this.token,
    required this.refreshToken,
    required this.refreshTokenExpiryTime,
    this.type = 'Bearer',
  });

  factory RefreshAuthTokenData.fromJson(Map<String, dynamic> json) =>
      _$RefreshAuthTokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshAuthTokenDataToJson(this);

  final String token;
  final String type;
  final String? refreshToken;
  final DateTime refreshTokenExpiryTime;

  AuthTokenData get toAuthTokenData {
    return AuthTokenData(
      token: token,
      refreshToken: refreshToken,
      expiry: refreshTokenExpiryTime,
    );
  }
}
