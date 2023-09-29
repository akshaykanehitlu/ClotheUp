  class UserData {
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final bool isOrg;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.isOrg,
  });
}

List<UserData> usersData = [
  UserData(
    firstName: 'John',
    lastName: 'Doe',
    username: 'user',
    password: 'user',
    isOrg: false,
  ),
  UserData(
    firstName: 'Admin',
    lastName: '',
    username: 'admin',
    password: 'admin',
    isOrg: true,
  ),
];
