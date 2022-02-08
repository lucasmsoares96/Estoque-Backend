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
    Results userResult = await db.login(u.email);
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

  Future<Response> updateUser(Request request) async {
    String message = await request.readAsString();
    Map<String, dynamic> userMap = jsonDecode(message);
    User u = User.fromUser(userMap["user"]);
    try {
      await DataBase().updateUser(
        u.toMap()..['oldEmail'] = verify(userMap['jwt'])['email'],
      );
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
    return Response.ok('Usuário atualizado com sucesso!!');
  }

  Future<Response> updatePassword(Request request) async {
    String message = await request.readAsString();
    String token = request.headers['Authorization']!;
    Map<String, dynamic> userMap = jsonDecode(message);
    try {
      //Pega usuário pelo email no token
      String email = verify(token)['email'];
      Results userResult = await DataBase().login(
        email,
      );
      //Confere se a senha atual é válida
      if (!dbcrypt.checkpw(
        userMap['user']['oldPassword'],
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
      //Confere se a senha nova é válida
      if (!userMap['user']['newPassword'].contains(RegExp(r'.{8,60}'))) {
        print('Falha ao carregar o usuário: Senha inválida');
        throw Exception('Falha ao carregar o usuário: Senha inválida');
      }

      //Confere se as senhas são diferentes
      if (userMap['user']['oldPassword']
              .compareTo(userMap['user']['newPassword']) ==
          0) {
        print('Falha ao atualizar a senha: As senhas não podem ser iguais');
        return Response(
          400,
          body: 'Falha ao atualizar a senha: As senhas não podem ser iguais',
        );
      }

      String hash = dbcrypt.hashpw(
        userMap["user"]["newPassword"]!,
        dbcrypt.gensalt(),
      );
      //Faz o update no banco com a nova Senha
      await DataBase().updatePassword(
        hash,
        email,
      );
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
    return Response.ok('Senha do usuário atualizada com sucesso!!');
  }

  Future<Response> getUser(Request request) async {
    //Apenas necessário passar o token
    String token = request.headers['Authorization']!;
    Results user;
    DataBase db = DataBase();
    try {
      user = await db.getUser(verify(token)['email']);
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
    return Response.ok('${jsonEncode(user.first)}\n');
  }
}
