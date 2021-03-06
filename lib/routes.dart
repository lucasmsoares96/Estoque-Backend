import 'package:shelf_router/shelf_router.dart';
import 'package:estoque_backend/routes/administrator.dart';
import 'package:estoque_backend/routes/users.dart';
import 'package:estoque_backend/routes/products.dart';

class Routes {
  Routes();

  final _router = Router()
    ..post('/login', Users().login)
    ..put('/updatePassword', Users().updatePassword)
    ..get('/getUser', Users().getUser)
    ..post('/users', Administrator().registerUser)
    ..get('/users', Administrator().getUsers)
    ..put('/users', Users().updateUser)
    ..post('/products', Products().includeProduct)
    ..get('/products', Products().getProducts)
    ..get('/products/<name>', Products().getProduct)
    ..put('/products', Products().updateProduct)
    ..delete('/products', Products().deleteProduct);
  Router getRouter() {
    return _router;
  }
}
