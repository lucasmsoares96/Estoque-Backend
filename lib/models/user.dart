class User {
  int? _id;
  String? _cpf;
  String? _name;
  DateTime? _entryDate;
  String? _userType;
  String? _email;
  String? _password;
  String? _hash;
  bool _isAdmin = false;

  User(Map<String, dynamic> u) {
    setEmail(u['email']);
    setPassword(u['password']);
  }

  User.fromUser(Map<String, dynamic> u) {
    setCpf(u['cpf']);
    setName(u['name']);
    setEntryDate(DateTime.parse(u['entryDate']));
    setUserType(u['userType']);
    setEmail(u['email']);
    setPassword(u['password']);
    setisAdmin(u['isAdmin']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{}
      ..['cpf'] = getCpf()
      ..['name'] = getName()
      ..['entryDate'] = getEntryDate()
      ..['userType'] = getUserType()
      ..['email'] = getEmail()
      ..['hash'] = getHash()
      ..['isAdmin'] = getisAdmin();
  }

  setId(int id) {
    _id = id;
  }

  int? getId() {
    return _id;
  }

  setCpf(String cpf) {
    if (!cpf.toString().contains(RegExp('[0-9]{11}'))) {
      print('Falha ao carregar o usuário: Cpf inválido');
      throw Exception('Falha ao carregar o usuário: Cpf inválido');
    }
    _cpf = cpf;
  }

  String? getCpf() {
    return _cpf;
  }

  setName(String name) {
    if (!name.toString().contains(RegExp('^[a-zA-Z ]{1,50}\$'))) {
      print('Falha ao carregar o usuário: Nome inválido');
      throw Exception('Falha ao carregar o usuário: Nome inválido');
    }
    _name = name;
  }

  String? getName() {
    return _name;
  }

  setEntryDate(DateTime entryDate) {
    _entryDate = entryDate;
  }

  DateTime? getEntryDate() {
    return _entryDate;
  }

  setUserType(String userType) {
    if (userType.toString().contains(RegExp('^[a-zA-Z ]\$'))) {
      print('Falha ao carregar o usuário: Tipo inválido');
      throw Exception('Falha ao carregar o usuário: Tipo de usuário inválido');
    }
    _userType = userType;
  }

  String? getUserType() {
    return _userType;
  }

  setEmail(String email) {
    if (!email
        .toString()
        .contains(RegExp('^[a-zA-Z0-9.]+@[a-z0-9]+.[a-z]+\.([a-z]+)?\$'))) {
      print('Falha ao carregar o usuário: Email inválido');
      throw Exception('Falha ao carregar o usuário: Email inválido');
    }
    _email = email;
  }

  String? getEmail() {
    return _email;
  }

  setPassword(String password) {
    if (!password.contains(RegExp('.{8,60}'))) {
      print('Falha ao carregar o usuário: Senha inválida');
      throw Exception('Falha ao carregar o usuário: Senha inválida');
    }
  }

  String? getPassword() {
    return _password;
  }

  setisAdmin(bool isAdmin) {
    _isAdmin = isAdmin;
  }

  bool getisAdmin() {
    return _isAdmin;
  }

  setHash(String hash) {
    _hash = hash;
  }

  String? getHash() {
    return _hash;
  }
}
