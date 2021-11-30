import 'dart:convert';
import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:estoque_backend/data_base.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:dbcrypt/dbcrypt.dart';

final overrideHeaders = {
  ACCESS_CONTROL_ALLOW_ORIGIN: '*',
  'Content-Type': 'application/json;charset=utf-8'
};

final _router = Router()..post('/login', _login);

Future<Response> _login(Request request) async {
  String message = await request.readAsString();
  Map<String, dynamic> userMap = jsonDecode(message);

  if (!userMap["email"]!
      .toString()
      .contains(RegExp('^[a-z0-9.]+@[a-z0-9]+.[a-z]+\.([a-z]+)?\$'))) {
    return Response(
      400,
      body: 'Falha ao carregar o usuário: Email inválido',
    );
  }
  if (!userMap["password"]!.contains(RegExp('.{8,50}'))) {
    return Response(
      400,
      body: 'Falha ao carregar o usuário: Senha inválida',
    );
  }
  DataBase db = DataBase();
  Results user = await db.login(userMap['email']!);
  if (user.isEmpty) {
    return Response(
      400,
      body:
          'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email',
    );
  }
  //TODO: usar criptografia
  //criptografando
  var isCorrect =
      new DBCrypt().checkpw(userMap['password'], user.first.fields['password']);

  //TODO: criar payload e jwt
  final jwt = JWT(
      {'nome': user.first.fields['name'], 'email': user.first.fields['email']});
  String token = jwt.sign(SecretKey('randomword'));

  if (!isCorrect) {
    return Response(
      400,
      body:
          'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email e senha',
    );
  }
  return Response.ok(token);
}

void main(List<String> args) async {
  DataBase db = DataBase();
  db.connect();
  // final ip = InternetAddress.anyIPv4;
  final ip = "127.0.0.1";
  final _handler = Pipeline()
      .addMiddleware(corsHeaders(headers: overrideHeaders))
      .addMiddleware(logRequests())
      .addHandler(_router);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${server.port}');
}
