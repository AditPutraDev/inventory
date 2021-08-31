part of 'models.dart';

class User {
  String userId;
  String username;
  String nama;
  String role;
  String email;
  String phone;
  String jabatan;
  User(
      {this.userId = '',
      this.username = '',
      this.nama = '',
      this.role = '',
      this.email = '',
      this.phone = '',
      this.jabatan = ''});
  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'],
      username: map['username'],
      nama: map['full_name'],
      role: map['role'],
      email: map['email'],
      phone: map['phone'],
      jabatan: map['jabatan'],
    );
  }
}
