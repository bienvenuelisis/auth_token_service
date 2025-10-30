import '../i_auth_token_service.dart';

export '../auth_token_data.dart';
export '../i_auth_token_service.dart';

class MemoryStorageAuthTokenService implements IAuthTokenService {
  AuthTokenData? _authToken;

  @override
  Future<AuthTokenData> getAuthToken() async {
    if (_authToken == null) {
      throw Exception('No auth token found');
    }
    return _authToken!;
  }

  @override
  Future<void> setAuthToken(AuthTokenData tokenData) async {
    _authToken = tokenData;
  }

  @override
  Future<void> clearAuthToken() async {
    _authToken = null;
  }
}
