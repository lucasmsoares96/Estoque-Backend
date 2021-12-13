import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AbstractRoutes {
  verify(String token) {
    try {
      // Verify a token
      final jwt = JWT.verify(token, SecretKey('randomword'));
      print('Payload: ${jwt.payload}');
      return jwt.payload;
    } on JWTExpiredError {
      print('jwt expired');
      throw JWTExpiredError;
    } on JWTError catch (ex) {
      print(ex.message); // ex: invalid signature
      throw JWTError(ex.message);
    }
  }
}
