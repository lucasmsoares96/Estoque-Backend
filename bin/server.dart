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
import 'package:dotenv/dotenv.dart' show load, env;

final overrideHeaders = {
  ACCESS_CONTROL_ALLOW_ORIGIN: '*',
  'Content-Type': 'application/json;charset=utf-8'
};
DBCrypt dbcrypt = DBCrypt();
final _router = Router()
  ..post('/login', _login)
  ..post('/registerUser', _registerUser)
  ..post('/getUsers', _getUsers);

Future<Response> _login(Request request) async {
  String message = await request.readAsString();
  Map<String, dynamic> userMap = jsonDecode(message);

  if (!userMap["email"]!
      .toString()
      .contains(RegExp('^[a-z0-9.]+@[a-z0-9]+.[a-z]+\.([a-z]+)?\$'))) {
    print('Falha ao carregar o usuário: Email inválido');
    return Response(
      400,
      body: 'Falha ao carregar o usuário: Email inválido',
    );
  }
  if (!userMap["password"]!.contains(RegExp('.{8,50}'))) {
    print('Falha ao carregar o usuário: Senha inválida');
    return Response(
      400,
      body: 'Falha ao carregar o usuário: Senha inválida',
    );
  }
  DataBase db = DataBase();
  Results user = await db.login(userMap['email']!);
  if (user.isEmpty) {
    print(
        'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email');
    return Response(
      400,
      body:
          'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email',
    );
  }
  //TODO: usar criptografia
  //criptografando
  var isCorrect = dbcrypt.checkpw(
    userMap['password'],
    user.first.fields['password'],
  );

  //TODO: criar payload e jwt
  final jwt = JWT({
    'name': user.first.fields['name'],
    'email': user.first.fields['email'],
    'isAdmin': user.first.fields['isADMIN']
  });
  String token = jwt.sign(SecretKey(env['secret']!));

  if (!isCorrect) {
    print(
        'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email e senha');
    return Response(
      400,
      body:
          'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email e senha',
    );
  }
  return Response.ok(token);
}

Future<Response> _registerUser(Request request) async {
  String message = await request.readAsString();
  Map<String, dynamic> userMap = jsonDecode(message);
  userMap["password"] = dbcrypt.hashpw(userMap["password"], dbcrypt.gensalt());
  if (verify(userMap['jwt'])['isAdmin'] == 1) {
    print("This user is Admin");
  } else {
    print("This user is not Admin");
    return Response(
      400,
      body: "This user is not Admin",
    );
  }
  try {
    await DataBase().registerUser(userMap);
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
  return Response.ok('Usuário registrado com sucesso!!');
}

dynamic verify(String token) {
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

Future<Response> _getUsers(Request request) async {
  String message = await request.readAsString();
  Map<String, dynamic> token = jsonDecode(message);
  if (verify(token['jwt'])['isAdmin'] == 1) {
    print("This user is Admin");
  } else {
    print("This user is not Admin");
    return Response(
      400,
      body: "This user is not Admin",
    );
  }
  Results users;
  DataBase db = DataBase();
  users = await db.getUsers();
  return Response.ok('${jsonEncode(users.toList())}\n');
}

void main(List<String> args) async {
  DataBase db = DataBase();
  load();
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
