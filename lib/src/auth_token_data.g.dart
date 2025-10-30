// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokenData _$AuthTokenDataFromJson(Map<String, dynamic> json) =>
    AuthTokenData(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String?,
      expiry: DateTime.parse(json['expiry'] as String),
      type: json['type'] as String? ?? 'Bearer',
    );

Map<String, dynamic> _$AuthTokenDataToJson(AuthTokenData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'type': instance.type,
      'refreshToken': instance.refreshToken,
      'expiry': instance.expiry.toIso8601String(),
    };

RefreshAuthTokenData _$RefreshAuthTokenDataFromJson(
  Map<String, dynamic> json,
) => RefreshAuthTokenData(
  token: json['token'] as String,
  refreshToken: json['refreshToken'] as String?,
  refreshTokenExpiryTime: DateTime.parse(
    json['refreshTokenExpiryTime'] as String,
  ),
  type: json['type'] as String? ?? 'Bearer',
);

Map<String, dynamic> _$RefreshAuthTokenDataToJson(
  RefreshAuthTokenData instance,
) => <String, dynamic>{
  'token': instance.token,
  'type': instance.type,
  'refreshToken': instance.refreshToken,
  'refreshTokenExpiryTime': instance.refreshTokenExpiryTime.toIso8601String(),
};
