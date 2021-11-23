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
      user: 'root',
      password: '123456',
      db: 'estoque');

  late MySqlConnection conn;

  Future<MySqlConnection> connect() async {
    conn = await MySqlConnection.connect(settings);
    return conn;
  }

  Future<Results> login(String email, String password) async {
    return await conn.query(
        'SELECT email, name FROM user WHERE email = ? AND password = ?',
        [email, password]);
  }
}
