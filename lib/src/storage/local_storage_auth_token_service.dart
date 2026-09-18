import 'dart:convert';

import 'package:local_storage_impl/local_storage_impl.dart';

import '../i_auth_token_service.dart';

export '../auth_token_data.dart';
export '../i_auth_token_service.dart';

const String _authTokenKey = 'auth_token';

class LocalStorageAuthTokenService implements IAuthTokenService {
  LocalStorageAuthTokenService(this._localStorage, [this.authTokenKey]);

  final LocalStorage _localStorage;

  final String? authTokenKey;

  @override
  Future<void> clearAuthToken() async {
    await _localStorage.remove(authTokenKey ?? _authTokenKey);
  }

  @override
  Future<AuthTokenData?> getAuthToken() async {
    final tokenString = await _localStorage.getString(authTokenKey ?? _authTokenKey);

    if (tokenString == null) {
      return null;
    }

    return AuthTokenData.fromJson(
      jsonDecode(tokenString) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> setAuthToken(AuthTokenData tokenData) async {
    await _localStorage.setString(
      authTokenKey ?? _authTokenKey,
      jsonEncode(tokenData.toJson()),
    );
  }
}
