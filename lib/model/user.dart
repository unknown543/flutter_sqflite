class User {
  int _id;
  String _name, _email, _password;
  User(this._email, this._name, this._password);
  User.withId(this._id, this._email, this._name, this._password);
  set setId(int id) => _id = id;
  set setName(String name) => _name = name;
  set setEmail(String email) => _email = email;
  set setPassword(String password) => _password = password;
  int get getId => _id;
  String get getNAme => _name;
  String get getEmail => _email;
  String get getPassword => _password;
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = _name;
    map["email"] = _email;
    map["password"] = _password;
    return map;
  }

  Map<String, dynamic> toMapWithId() {
    var map = Map<String, dynamic>();
    map["id"] = _id;
    map["name"] = _name;
    map["email"] = _email;
    map["password"] = _password;
    return map;
  }

  User.fromJson(Map<String, dynamic> map) {
    _email = map["email"];
    _name = map["name"];
    _password = map["password"];
    _id = map["id"];
  }
}
