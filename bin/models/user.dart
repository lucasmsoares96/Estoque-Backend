class User {
  int? _id;
  String? _cpf;
  String? _name;
  DateTime? _entryDate;
  String? _userType;
  String? _email;
  String? _password;
  bool _isADMIN;

  User() : _isADMIN = false;

  setId(int id) {
    _id = id;
  }

  int? getId() {
    return _id;
  }

  setCpf(String cpf) {
    _cpf = cpf;
  }

  String? getCpf() {
    return _cpf;
  }

  setName(String name) {
    _name = name;
  }

  String? getName() {
    return _name;
  }

  setentryDate(DateTime entryDate) {
    _entryDate = entryDate;
  }

  DateTime? getBirth() {
    return _entryDate;
  }

  setUserType(String userType) {
    _userType = userType;
  }

  String? getUserType() {
    return _userType;
  }

  setEmail(String email) {
    _email = email;
  }

  String? getEmail() {
    return _email;
  }

  setPassword(String password) {
    _password = password;
  }

  String? getPassword() {
    return _password;
  }

  setIsAdmin(bool isAdmin) {
    _isADMIN = isAdmin;
  }

  bool getIsAdmin() {
    return _isADMIN;
  }
}
