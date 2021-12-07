import 'package:mysql1/mysql1.dart';

class DataBase {
  // Pedrão de Projeto: Singleton
  static final DataBase _dataBase = DataBase._internal();

  factory DataBase() {
    return _dataBase;
  }

  DataBase._internal();
  // fim

  var settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'alex',
      password: '32129775@Lex',
      db: 'estoque');

  late MySqlConnection conn;

  Future<MySqlConnection> connect() async {
    conn = await MySqlConnection.connect(settings);
    return conn;
  }

  Future<Results> login(String email) async {
    return await conn.query(
        'SELECT email, name, password FROM user WHERE email = ?', [email]);
  }

  Future<Results> registerUser(Map<String, dynamic> userMap) async {
    return await conn.query(
        'INSERT INTO estoque.user(cpf,name,birthDay, userType,email,isAdmin, password) VALUES (?,?,?,?,?,?,?)',
        [
          userMap["cpf"],
          userMap["name"],
          userMap["birthDay"],
          userMap["userType"],
          userMap["email"],
          userMap["isAdmin"],
          userMap["password"]
        ]);
  }
}
