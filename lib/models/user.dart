class User {
  int? id;
  String? _cpf;
  String? _name;
  DateTime? entryDate;
  String? _userType;
  String? _email;
  String? _password;
  String? hash;
  bool isAdmin = false;

  User(Map<String, dynamic> u) {
    email = u['email'];
    password = u['password'];
  }

  User.fromUser(Map<String, dynamic> u) {
    cpf = u['cpf'];
    name = u['name'];
    entryDate = DateTime.parse(u['entryDate']);
    userType = u['userType'];
    email = u['email'];
    isAdmin = u['isAdmin'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cpf': cpf,
      'name': name,
      'entryDate': entryDate,
      'userType': userType,
      'email': email,
      'hash': hash,
      'isAdmin': isAdmin,
    };
  }

  set cpf(String cpf) {
    if (!cpf.toString().contains(RegExp(r'[0-9]{11}'))) {
      print('Falha ao carregar o usuário: Cpf inválido');
      throw Exception('Falha ao carregar o usuário: Cpf inválido');
    }
    _cpf = cpf;
  }

  String get cpf => _cpf!;

  set name(String name) {
    if (!name.toString().contains(RegExp(r'^[a-zA-Z ]{1,50}\$'))) {
      print('Falha ao carregar o usuário: Nome inválido');
      throw Exception('Falha ao carregar o usuário: Nome inválido');
    }
    _name = name;
  }

  String get name => _name!;

  set userType(String userType) {
    if (userType.toString().contains(RegExp(r'^[a-zA-Z ]\$'))) {
      print('Falha ao carregar o usuário: Tipo inválido');
      throw Exception('Falha ao carregar o usuário: Tipo de usuário inválido');
    }
    _userType = userType;
  }

  String get userType => _userType!;

  set email(String email) {
    if (!email.toString().contains(RegExp(r'^\S+@\S+\.\S+$'))) {
      print('Falha ao carregar o usuário: Email inválido');
      throw Exception('Falha ao carregar o usuário: Email inválido');
    }
    _email = email;
  }

  String get email => _email!;

  set password(String password) {
    if (!password.contains(RegExp(r'.{8,60}'))) {
      print('Falha ao carregar o usuário: Senha inválida');
      throw Exception('Falha ao carregar o usuário: Senha inválida');
    }
  }

  String get password => _password!;
}
