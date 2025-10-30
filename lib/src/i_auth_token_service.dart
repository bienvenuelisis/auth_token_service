import 'auth_token_data.dart';

export 'auth_token_data.dart';

abstract class IAuthTokenService {
  Future<void> clearAuthToken();

  Future<AuthTokenData?> getAuthToken();

  Future<void> setAuthToken(AuthTokenData tokenData);
}
