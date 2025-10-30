class JwtClaims {
  JwtClaims({
    required this.jti,
    required this.nameIdentifier,
    required this.emailAddress,
    required this.name,
    required this.mobilePhone,
    required this.fullName,
    required this.surname,
    required this.ipAddress,
    required this.tenant,
    required this.imageUrl,
    required this.tin,
    required this.exp,
    required this.iss,
    required this.aud,
  });

  factory JwtClaims.fromJson(Map<String, dynamic> json) {
    return JwtClaims(
      jti: json['jti'] as String,
      nameIdentifier:
          json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']
              as String,
      emailAddress:
          json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress']
              as String,
      name:
          json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name']
              as String,
      mobilePhone:
          json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone']
              as String,
      fullName: json['fullName'] as String,
      surname:
          json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname']
              as String,
      ipAddress: json['ipAddress'] as String,
      tenant: json['tenant'] as String,
      imageUrl: json['image_url'] as String,
      tin: json['tin'] as String,
      exp: json['exp'] as int,
      iss: json['iss'] as String,
      aud: json['aud'] as String,
    );
  }

  final String? aud;
  final String? emailAddress;
  final int exp;
  final String? fullName;
  final String? imageUrl;
  final String? ipAddress;
  final String? iss;
  final String? jti;
  final String? mobilePhone;
  final String? name;
  final String? nameIdentifier;
  final String? surname;
  final String? tenant;
  final String tin;

  /// Get expiry date from timestamp
  DateTime get expiryDate => DateTime.fromMillisecondsSinceEpoch(exp * 1000);

  /// Check if token is expired
  bool get isExpired => DateTime.now().isAfter(expiryDate);

  bool get isExpiringSoon =>
      !isExpired &&
      expiryDate.isBefore(DateTime.now().add(const Duration(minutes: 30)));

  Map<String, dynamic> toJson() {
    return {
      'jti': jti,
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier':
          nameIdentifier,
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress':
          emailAddress,
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name': name,
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone':
          mobilePhone,
      'fullName': fullName,
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname': surname,
      'ipAddress': ipAddress,
      'tenant': tenant,
      'image_url': imageUrl,
      'tin': tin,
      'exp': exp,
      'iss': iss,
      'aud': aud,
    };
  }
}
