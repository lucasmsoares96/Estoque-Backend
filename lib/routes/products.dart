import 'dart:convert';
import 'package:estoque_backend/data_base.dart';
import 'package:estoque_backend/models/product.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:estoque_backend/routes/abstract_routes.dart';

class Products extends AbstractRoutes {
  Products();

  DBCrypt dbcrypt = DBCrypt();

  Future<Response> includeProduct(Request request) async {
    String message = await request.readAsString();
    Map<String, dynamic> productMap = jsonDecode(message);
    print(productMap["product"]);
    Product p = Product.fromProduct(productMap["product"]);
    try {
      await DataBase().includeProduct(p.toMap());
    } on MySqlException catch (e) {
      print(e);
      return Response(
        500,
        body: e.toString(),
      );
    } catch (e) {
      print(e);
      return Response(
        500,
        body: e.toString(),
      );
    }
    return Response.ok('Produto incluído com sucesso!!');
  }

  Future<Response> getProducts(Request request) async {
    String message = await request.readAsString();
    Map<String, dynamic> token = jsonDecode(message);
    Results products;
    DataBase db = DataBase();
    try {
      verify(token['jwt']);
      products = await db.getProducts();
    } on MySqlException catch (e) {
      print(e);
      return Response(
        500,
        body: e.toString(),
      );
    } catch (e) {
      print(e);
      return Response(
        500,
        body: e.toString(),
      );
    }
    return Response.ok('${jsonEncode(products.toList())}\n');
  }
}
