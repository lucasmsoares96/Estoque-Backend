import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AbstractRoutes {
  verify(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey('randomword'));
      print('Payload: ${jwt.payload}');
      return jwt.payload;
    } on JWTExpiredError {
      print('jwt expired');
      throw JWTExpiredError;
    } on JWTError catch (ex) {
      print('Erro no jwt: ' + ex.message);
      throw JWTError('Erro no jwt: ' + ex.message);
    } on FormatException catch (ex) {
      print('Erro no formato do jwt: ' + ex.message);
      throw JWTError('Erro no formato do jwt: ' + ex.message);
    }
  }
}
