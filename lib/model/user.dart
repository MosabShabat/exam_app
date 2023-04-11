class User {
  String? id;
  late String name;
  late String email;
  late String password;
  String? BD;
  String? BTime;

  User(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      this.BD,
      this.BTime});

  User.fromJson(Map map) {
    id = map['id'];
    password = map['password'];
    name = map['name'];
    email = map['email'];
    BD = map['BD'];
    BTime = map['BTime'];
  }

  toJson() {
    return {
      'id': id,
      'password': password,
      'name': name,
      'email': email,
      'BD': BD,
      'BTime': BTime,
    };
  }

  @override
  String toString() {
    return "$name , $BTime , $BD , $email , $password , $id";
  }
}
