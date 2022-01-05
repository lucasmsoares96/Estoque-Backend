import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:estoque_backend/data_base.dart';
import 'package:estoque_backend/models/user.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:dotenv/dotenv.dart' show env;
import 'package:dbcrypt/dbcrypt.dart';
import 'package:estoque_backend/routes/abstract_routes.dart';

class Users extends AbstractRoutes {
  Users();

  DBCrypt dbcrypt = DBCrypt();

  Future<Response> login(Request request) async {
    String message = await request.readAsString();
    User u = User(jsonDecode(message));
    DataBase db = DataBase();
    Results userResult = await db.login(u.getEmail()!);
    if (userResult.isEmpty) {
      print(
          'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email');
      return Response(
        400,
        body:
            'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email',
      );
    }
    //criptografando
    if (!dbcrypt.checkpw(
      jsonDecode(message)['password'],
      userResult.first.fields['password'],
    )) {
      print(
          'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email e senha');
      return Response(
        400,
        body:
            'Falha ao carregar o usuário: Não foi encontrado um usuário com esse email e senha',
      );
    }

    //payload e jwt
    final jwt = JWT({
      'name': userResult.first.fields['name'],
      'email': userResult.first.fields['email'],
      'isAdmin': userResult.first.fields['isAdmin']
    });
    String token = jwt.sign(SecretKey(env['secret']!));
    return Response.ok(token);
  }
}
