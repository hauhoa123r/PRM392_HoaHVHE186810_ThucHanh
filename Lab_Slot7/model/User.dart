class User{
  int id;
  String name;
  String? email;

  User({required this.id, required this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      name: json['name'] ?? 'No name',
      email: json['email'],
    );
  }

  showProfile(){
    print('ID: $id');
    print('Name: $name');
    print('Email: ${email ?? 'Chua cap nhat'}');
  }
}