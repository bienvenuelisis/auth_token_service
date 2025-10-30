# Auth Token Service

A reusable authentication token service with JWT support and multiple storage backends for Flutter applications.

## Features

- **Token Management**: Store, retrieve, and clear authentication tokens
- **JWT Decoding**: Parse and extract claims from JWT tokens without external dependencies
- **Multiple Storage Backends**:
  - Local storage (persistent)
  - Memory storage (non-persistent, useful for testing)
- **Token Expiration**: Built-in expiration checking
- **User Claims**: Easy access to common user claims (ID, email, name, TIN, etc.)
- **Type-Safe**: Interface-based design for easy testing and mocking

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  auth_token_service:
    path: packages/auth_token_service
```

## Usage

### Basic Token Management

```dart
import 'package:auth_token_service/auth_token_service.dart';
import 'package:local_storage_impl/local_storage_impl.dart';

// Create token service with local storage
final localStorage = LocalStorage();
final tokenService = LocalStorageAuthTokenService(localStorage);

// Store a token
final tokenData = AuthTokenData(
  token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
  refreshToken: 'refresh_token_here',
  expiry: DateTime.now().add(Duration(hours: 1)),
  type: 'Bearer',
);

await tokenService.setAuthToken(tokenData);

// Retrieve token
final storedToken = await tokenService.getAuthToken();
if (storedToken != null && !storedToken.expired) {
  print('Token is valid!');
}

// Clear token (e.g., on logout)
await tokenService.clearAuthToken();
```

### Memory Storage (Testing)

```dart
// Use memory storage for testing or temporary sessions
final tokenService = MemoryStorageAuthTokenService();

await tokenService.setAuthToken(tokenData);
final token = await tokenService.getAuthToken();
```

### Working with JWT Claims

```dart
// Get token data
final tokenData = await tokenService.getAuthToken();

if (tokenData != null) {
  // Access JWT claims
  final claims = tokenData.claims;

  // Or use convenience getters
  print('User ID: ${tokenData.userId}');
  print('Email: ${tokenData.userEmail}');
  print('Full Name: ${tokenData.userFullName}');
  print('TIN: ${tokenData.userTin}');
  print('Phone: ${tokenData.userMobilePhone}');

  // Check expiration
  if (tokenData.expired) {
    print('Token has expired!');
  }
}
```

### Direct JWT Decoding

```dart
import 'package:auth_token_service/auth_token_service.dart';

final jwtService = JwtService();

// Decode token
final claims = jwtService.decodeToken(token);
if (claims != null) {
  print('Token expires at: ${claims.expiryDate}');
  print('Is expired: ${claims.isExpired}');
  print('Expiring soon: ${claims.isExpiringSoon}');

  // Access all claims
  print('Issuer: ${claims.iss}');
  print('Audience: ${claims.aud}');
  print('Tenant: ${claims.tenant}');
}

// Check if token is expired
if (jwtService.isTokenExpired(token)) {
  print('Please refresh your token');
}

// Get raw payload
final payload = jwtService.getTokenPayload(token);
```

### Custom Storage Implementation

Implement your own storage backend:

```dart
class CustomStorageAuthTokenService implements IAuthTokenService {
  final YourCustomStorage _storage;

  CustomStorageAuthTokenService(this._storage);

  @override
  Future<void> setAuthToken(AuthTokenData tokenData) async {
    // Your custom implementation
  }

  @override
  Future<AuthTokenData?> getAuthToken() async {
    // Your custom implementation
  }

  @override
  Future<void> clearAuthToken() async {
    // Your custom implementation
  }
}
```

## API Reference

### IAuthTokenService

The main interface for token management.

**Methods:**

- `Future<void> setAuthToken(AuthTokenData tokenData)` - Store authentication token
- `Future<AuthTokenData?> getAuthToken()` - Retrieve stored token
- `Future<void> clearAuthToken()` - Remove stored token

### AuthTokenData

Token data model with JWT support.

**Properties:**

- `String token` - The JWT access token
- `String? refreshToken` - Optional refresh token
- `DateTime expiry` - Token expiration time
- `String type` - Token type (default: "Bearer")

**Getters:**

- `bool expired` - Check if token is expired
- `JwtClaims? claims` - Decoded JWT claims
- `String? userId` - User ID from claims
- `String? userEmail` - User email from claims
- `String? userFullName` - User full name from claims
- `String? userTin` - User TIN from claims
- `String? userMobilePhone` - User phone from claims

### JwtClaims

JWT claims extracted from token.

**Properties:**

- Standard claims: `jti`, `exp`, `iss`, `aud`
- User claims: `nameIdentifier`, `emailAddress`, `name`, `fullName`, `surname`
- Custom claims: `tin`, `tenant`, `mobilePhone`, `ipAddress`, `imageUrl`

**Getters:**

- `DateTime expiryDate` - Expiration date from timestamp
- `bool isExpired` - Check if expired
- `bool isExpiringSoon` - Check if expires within 30 minutes

### IJwtService

Interface for JWT operations.

**Methods:**

- `JwtClaims? decodeToken(String token)` - Decode JWT and extract claims
- `Map<String, dynamic>? getTokenPayload(String token)` - Get raw payload
- `bool isTokenExpired(String token)` - Check token expiration

## Storage Backends

### LocalStorageAuthTokenService

Persistent storage using `local_storage_impl` package (SharedPreferences).

**Use case**: Production apps where tokens should persist across app restarts.

```dart
final tokenService = LocalStorageAuthTokenService(localStorage);
```

### MemoryStorageAuthTokenService

In-memory storage (non-persistent).

**Use case**: Testing, temporary sessions, or when persistence is not needed.

```dart
final tokenService = MemoryStorageAuthTokenService();
```

## JWT Claims Mapping

The service maps standard JWT claims to user-friendly properties:

| JWT Claim | Property | Description |
|-----------|----------|-------------|
| `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier` | `nameIdentifier` | User unique identifier |
| `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress` | `emailAddress` | User email address |
| `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name` | `name` | User name |
| `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname` | `surname` | User surname |
| `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone` | `mobilePhone` | User mobile phone |
| `fullName` | `fullName` | User full name |
| `tin` | `tin` | Tax Identification Number |
| `tenant` | `tenant` | Tenant identifier |
| `image_url` | `imageUrl` | User profile image URL |
| `ipAddress` | `ipAddress` | User IP address |

## Dependencies

- `json_annotation: ^4.9.0` - JSON serialization annotations
- `local_storage_impl: ^0.0.5` - Local storage implementation

## Testing

The interface-based design makes testing easy:

```dart
class MockAuthTokenService implements IAuthTokenService {
  AuthTokenData? _token;

  @override
  Future<void> setAuthToken(AuthTokenData tokenData) async {
    _token = tokenData;
  }

  @override
  Future<AuthTokenData?> getAuthToken() async => _token;

  @override
  Future<void> clearAuthToken() async {
    _token = null;
  }
}

// Use in tests
final mockService = MockAuthTokenService();
```

## License

MIT License - See LICENSE file for details.
