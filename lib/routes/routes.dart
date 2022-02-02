import 'package:shelf_router/shelf_router.dart';
import 'package:estoque_backend/routes/administrator.dart';
import 'package:estoque_backend/routes/users.dart';
import 'package:estoque_backend/routes/products.dart';

class Routes {
  Routes();

  final _router = Router()
    ..post('/login', Users().login)
    ..post('/registerUser', Administrator().registerUser)
    ..post('/includeProduct', Products().includeProduct)
    ..get('/getUsers', Administrator().getUsers)
    ..get('/getProducts', Products().getProducts)
    ..get('/getProduct', Products().getProduct)
    ..put('/updateProduct', Products().updateProduct)
    ..delete('/deleteProduct', Products().deleteProduct);

  Router getRouter() {
    return _router;
  }
}
