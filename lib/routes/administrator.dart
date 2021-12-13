import 'dart:convert';
import 'package:estoque_backend/data_base.dart';
import 'package:estoque_backend/models/user.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:estoque_backend/routes/routes.dart';

class Administrator extends Routes {
  Administrator();

  DBCrypt dbcrypt = DBCrypt();

  Future<Response> registerUser(Request request) async {
    String message = await request.readAsString();
    Map<String, dynamic> userMap = jsonDecode(message);
    User u = User(userMap["user"]);
    u.setPassword(dbcrypt.hashpw(
      u.getPassword()!,
      dbcrypt.gensalt(),
    ));
    if (verify(userMap['token'])['isAdmin'] == 1) {
      print("This user is Admin");
    } else {
      print("This user is not Admin");
      return Response(
        400,
        body: "This user is not Admin",
      );
    }
    try {
      await DataBase().registerUser(u.toMap());
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

  Future<Response> getUsers(Request request) async {
    String message = await request.readAsString();
    Map<String, dynamic> token = jsonDecode(message);
    if (verify(token['token'])['isAdmin'] == 1) {
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
}
