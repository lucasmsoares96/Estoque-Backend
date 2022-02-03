import 'dart:convert';
import 'package:estoque_backend/data_base.dart';
import 'package:estoque_backend/models/product.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:estoque_backend/routes/abstract_routes.dart';
import 'package:shelf_router/src/router.dart';

class Products extends AbstractRoutes {
  Products();

  DBCrypt dbcrypt = DBCrypt();

  Future<Response> includeProduct(Request request) async {
    String message = await request.readAsString();
    String token = request.headers['Authorization']!;
    Map<String, dynamic> productMap = jsonDecode(message);
    Product p = Product.fromMap(productMap["product"]);
    try {
      verify(token);
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

  Future<Response> updateProduct(Request request) async {
    String message = await request.readAsString();
    String token = request.headers['Authorization']!;
    Map<String, dynamic> productMap = jsonDecode(message);
    Product p = Product.fromMap(productMap["product"]);
    p.id = productMap["product"]["id"];
    try {
      verify(token);
      await DataBase().updateProduct(p.toMap());
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
    return Response.ok('Produto atualizado com sucesso!!');
  }

  Future<Response> deleteProduct(Request request) async {
    String message = await request.readAsString();
    String token = request.headers['Authorization']!;
    Map<String, dynamic> productMap = jsonDecode(message);
    print("ProductMap");
    print(productMap);
    Product p = Product.fromMap(productMap["product"]);
    p.id = productMap["product"]["id"];
    try {
      verify(token);
      await DataBase().deleteProduct(p.toMap());
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
    return Response.ok('Produto deletado com sucesso!!');
  }

  Future<Response> getProducts(Request request) async {
    String token = request.headers['Authorization']!;
    Results products;
    DataBase db = DataBase();
    try {
      verify(token);
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

  Future<Response> getProduct(Request request) async {
    Map<String, String> product = request.params;
    String token = request.headers['Authorization']!;
    Results products;
    DataBase db = DataBase();
    try {
      verify(token);
      products = await db.getProduct(product["name"]!);
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
