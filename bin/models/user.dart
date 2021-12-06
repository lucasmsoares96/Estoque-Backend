class User {
  int? _id;
  String? _cpf;
  String? _name;
  DateTime? _birthDay;
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

  setBirthDay(DateTime birthDay) {
    _birthDay = birthDay;
  }

  DateTime? getBirth() {
    return _birthDay;
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
