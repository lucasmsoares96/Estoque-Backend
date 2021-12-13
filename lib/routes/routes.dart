import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:estoque_backend/routes/administrator.dart';
import 'package:estoque_backend/routes/users.dart';

class Routes {
  Routes();

  final _router = Router()
    ..post('user/login', Users().login)
    ..post('admin/registerUser', Administrator().registerUser)
    ..get('admin/getUsers', Administrator().getUsers);

  Router getRouter() {
    return _router;
  }

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
