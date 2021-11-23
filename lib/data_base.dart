import 'package:mysql1/mysql1.dart';

class DataBase {
  // Pedrão de Projeto: Singleton
  static final DataBase _dataBase = DataBase._internal();

  factory DataBase() {
    return _dataBase;
  }

  DataBase._internal();

  // Outra forma
  // DataBase._();
  // static final instance = DataBase._();

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

  // Future<Results> getUsers(String userId) async {
  //   return await conn
  //       .query('select name, email, age from users where id = ?', [userId]);
  // }

  Future<Results> getUser(String email, String password) async {
    return await conn.query(
        'select email, senha from usuario where email = ? AND senha = ?',
        [email, password]);
  }

  Future<Results> setUsers(Map<String, dynamic> user) async {
    return await conn
        .query('insert into users (name, email, age) values (?, ?, ?)', [
      user["name"] as String,
      user["email"] as String,
      user["age"],
    ]);
  }

// var results2 = await conn.queryMulti(
//     'insert into users (name, email, age) values (?, ?, ?)',
//     [['Bob', 'bob@bob.com', 25],
//     ['Bill', 'bill@bill.com', 26],
//     ['Joe', 'joe@joe.com', 37]])
  // await conn.query('update users set age=? where name=?', [26, 'Bob']);
  // var results = await conn.query('SHOW TABLES');
  // for (var row in results) {
  //   print('${row[0]}');
  // }
}
