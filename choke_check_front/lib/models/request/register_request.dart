class RegisterRequest {
  final String username;
  final String password;
  final String repeatPassword;
  final String name;
  final String surname;
  final int height;
  final int weight;
  final String email;
  final int age;
  final int byte;
  final String beltColor;

  RegisterRequest(
      {required this.username,
      required this.password,
      required this.repeatPassword,
      required this.name,
      required this.surname,
      required this.height,
      required this.weight,
      required this.email,
      required this.age,
      required this.beltColor,
      required this.byte});

  Map<String, dynamic> toMap() => {
        'username': username,
        'password': password,
        'repeatPassword': repeatPassword,
        'name': name,
        'surname': surname,
        'height': height,
        'weight': weight,
        'email': email,
        'age': age,
        'beltColor': beltColor
      };
}
