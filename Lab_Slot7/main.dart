import 'model/User.dart';
void main(){
  Map<String, dynamic> userData1 = {
    'id': 1,
    'name': 'John Doe',
    'email': 'john.doe@example.com'
  };
  Map<String, dynamic> userData2 = {
    'id': 2,
    'name': 'John Doe',
    'email': null
  };
  User user1 = User.fromJson(userData1);
  User user2 = User.fromJson(userData2);
  user1.showProfile();
  user2.showProfile();
}