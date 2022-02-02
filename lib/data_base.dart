import 'package:mysql1/mysql1.dart';
import 'package:dotenv/dotenv.dart' show load, env;

class DataBase {
  // Pedrão de Projeto: Singleton
  static final DataBase _dataBase = DataBase._internal();

  factory DataBase() {
    load();
    return _dataBase;
  }

  DataBase._internal();
  // fim

  var settings = ConnectionSettings(
      host: 'localhost',
      port: int.parse(env['port'] ?? "3306"),
      user: env['user'],
      password: env['password'],
      db: 'estoque');

  late MySqlConnection conn;

  Future<MySqlConnection> connect() async {
    conn = await MySqlConnection.connect(settings);
    return conn;
  }

  Future<Results> login(String email) async {
    return await conn.query(
        'SELECT email, name, password, isAdmin FROM user WHERE email = ?',
        [email]);
  }

  Future<Results> registerUser(Map<String, dynamic> userMap) async {
    print(userMap);
    return await conn.query(
      'INSERT INTO estoque.user(cpf,name,entryDate, userType,email,isAdmin, password) VALUES (?,?,?,?,?,?,?)',
      [
        userMap["cpf"],
        userMap["name"],
        userMap["entryDate"].toString(),
        userMap["userType"],
        userMap["email"],
        userMap["isAdmin"],
        userMap["hash"]
      ],
    );
  }

  Future<Results> getUsers() async {
    return await conn.query(
        'SELECT name, CAST(entryDate as CHAR) as entryDate, userType, email, isAdmin FROM user');
  }

  Future<Results> includeProduct(Map<String, dynamic> productMap) async {
    print(productMap);
    return await conn.query(
      'INSERT INTO estoque.product(name,productType) VALUES (?,?)',
      [
        productMap["name"],
        productMap["productType"],
      ],
    );
  }

  Future<Results> getProducts() async {
    return await conn.query('SELECT name, productType FROM product');
  }

  Future<Results> deleteProduct(Map<String, dynamic> productMap) async {
    return await conn
        .query('DELETE FROM product WHERE name = ?;', [productMap["name"]]);
  }
}
