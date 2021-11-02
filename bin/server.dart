import 'dart:convert';
import 'dart:io';

import 'package:estoque_backend/data_base.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';

final overrideHeaders = {
  ACCESS_CONTROL_ALLOW_ORIGIN: '*',
  'Content-Type': 'application/json;charset=utf-8'
};
// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/setUser', _setUser)
  ..get('/getUser/<message>', _getUser);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Future<Response> _setUser(Request request) async {
  String message = await request.readAsString();
  Map<String, dynamic> user = jsonDecode(message);
  DataBase db = DataBase();
  db.setUsers(user);
  Response response = Response(
    201,
    body: message,
  );
  return response;
}

Future<Response> _getUser(Request request) async {
  Map<String, String> message = request.params;
  DataBase db = DataBase();
  Results results = await db.getUsers(message.values.first);
  return Response.ok('${jsonEncode(results.first.fields)}\n');
}

void main(List<String> args) async {
  DataBase db = DataBase();
  db.connect();

  // Use any available host or container IP (usually `0.0.0.0`).
  // final ip = InternetAddress.anyIPv4;
  final ip = "192.168.0.198";

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
