import 'dart:convert';
import 'dart:io';

import 'package:estoque_backend/data_base.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';
import "package:dart_jsonwebtoken/dart_jsonwebtoken.dart";

final overrideHeaders = {
  ACCESS_CONTROL_ALLOW_ORIGIN: '*',
  'Content-Type': 'application/json;charset=utf-8'
};
// Configure routes.
final _router = Router()..post('/login', _login);
//..get('/getUser/<message>', _getUser);

Future<Response> _login(Request request) async {
  String message = await request.readAsString();
  Map<String, dynamic> userMap = jsonDecode(message);

  if (!userMap["email"]!
      .toString()
      .contains(RegExp('^[a-z0-9.]+@[a-z0-9]+.[a-z]+\.([a-z]+)?\$'))) {
    Response response = Response(
      400,
      body: 'Falha ao carregar o usuário: Email inválido',
    );
    return response;
  }

  if (!userMap["password"]!.contains(RegExp('.{8,50}'))) {
    Response response = Response(
      400,
      body: 'Falha ao carregar o usuário: Senha inválida',
    );
    return response;
  }

  DataBase db = DataBase();
  Results user = await db.getUser(userMap['email']!, userMap['password']!);

  if (user.isEmpty) {
    Response response = Response(
      400,
      body:
          'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email e senha',
    );
    return response;
  }
  //final jwt = JWT({'email': userMap['email']});
  //String token = jwt.sign(SecretKey('secret passphrase'));
  Response response = Response(
    201,
    body: message,
  );

  return response;
}

// Future<Response> _getUser(Request request) async {
//   Map<String, String> message = request.params;
//   DataBase db = DataBase();
//   Results results = await db.getUsers(message.values.first);
//   return Response.ok('${jsonEncode(results.first.fields)}\n');
// }

void main(List<String> args) async {
  DataBase db = DataBase();
  db.connect();

  // Use any available host or container IP (usually `0.0.0.0`).
  // final ip = InternetAddress.anyIPv4;
  final ip = "127.0.0.1";

  // Configure a pipeline that logs requests.
  final _handler = Pipeline()
      .addMiddleware(corsHeaders(headers: overrideHeaders))
      .addMiddleware(logRequests())
      .addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${server.port}');
}
