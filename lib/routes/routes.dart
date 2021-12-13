import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:estoque_backend/routes/administrator.dart';
import 'package:estoque_backend/routes/users.dart';

class Routes {
  Routes();

  final _router = Router()
    ..post('/login', Users().login)
    ..post('/registerUser', Administrator().registerUser)
    ..get('/getUsers', Administrator().getUsers);

  Router getRouter() {
    return _router;
  }
}
