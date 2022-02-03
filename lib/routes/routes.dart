import 'package:shelf_router/shelf_router.dart';
import 'package:estoque_backend/routes/administrator.dart';
import 'package:estoque_backend/routes/users.dart';
import 'package:estoque_backend/routes/products.dart';

class Routes {
  Routes();

  final _router = Router()
    ..post('/login', Users().login)
    ..post('/users', Administrator().registerUser)
    ..get('/users', Administrator().getUsers)
    ..post('/products', Products().includeProduct)
    ..get('/products', Products().getProducts)
    ..get('/products/<name>', Products().getProduct)
    ..put('/products', Products().updateProduct)
    ..delete('/products', Products().deleteProduct);
  Router getRouter() {
    return _router;
  }
}
