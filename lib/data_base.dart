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
    db: 'estoque',
  );

  late MySqlConnection conn;

  Future<MySqlConnection> connect() async {
    conn = await MySqlConnection.connect(settings);
    return conn;
  }

  Future<Results> login(String email) async {
    return await conn.query(
      'SELECT email, name, password, isAdmin FROM user WHERE email = ?',
      [
        email,
      ],
    );
  }

  Future<Results> registerUser(Map<String, dynamic> userMap) async {
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

  Future<Results> updateUser(Map<String, dynamic> userMap) async {
    return await conn.query(
      'UPDATE user SET cpf = ?, name = ?, userType = ?, email = ?, isAdmin = ? WHERE email = ?',
      [
        userMap["cpf"],
        userMap["name"],
        userMap["userType"],
        userMap["email"],
        userMap["isAdmin"],
        userMap["oldEmail"],
      ],
    );
  }

  Future<Results> getUser(String email) async {
    return await conn.query(
      'SELECT cpf, name, CAST(entryDate as CHAR), userType, email, isAdmin FROM user WHERE email = ?;',
      [
        email,
      ],
    );
  }

  Future<Results> updatePassword(String password, String email) async {
    return await conn.query(
      'UPDATE user SET password = ? WHERE email = ?',
      [
        password,
        email,
      ],
    );
  }

  Future<Results> includeProduct(Map<String, dynamic> productMap) async {
    return await conn.query(
      'INSERT INTO estoque.product(name,productType) VALUES (?,?)',
      [
        productMap["name"],
        productMap["productType"],
      ],
    );
  }

  Future<Results> updateProduct(Map<String, dynamic> productMap) async {
    return await conn.query(
      'UPDATE product SET name = ?, productType = ? WHERE id = ?;',
      [
        productMap["name"],
        productMap["productType"],
        productMap["id"],
      ],
    );
  }

  Future<Results> getProducts() async {
    return await conn.query('SELECT id, name, productType FROM product');
  }

  Future<Results> getProduct(String productMap) async {
    return await conn.query(
      'SELECT name, productType FROM product WHERE LOCATE(?,NAME);',
      [
        productMap,
      ],
    );
  }

  Future<Results> deleteProduct(Map<String, dynamic> productMap) async {
    print(productMap);
    print("TESTE");
    return await conn.query(
      'DELETE FROM product WHERE id = ?;',
      [
        productMap["id"],
      ],
    );
  }
}
