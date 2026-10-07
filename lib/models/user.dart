// ignore_for_file: prefer_initializing_formals
import 'person.dart';

/// Class User merupakan turunan (subclass) dari Person.
/// Menerapkan prinsip OOP:
/// 1. Inheritance (Pewarisan sifat dari Person via extends)
/// 2. Encapsulation (Penyembunyian password dalam field private _password)
/// 3. Polymorphism (Override method getRoleDescription)
class User extends Person {
  final String username;
  final String nim;
  final String email;
  final String _password; // Field private untuk keamanan password

  User({
    required super.fullName,
    required super.birthPlace,
    required super.birthDate,
    required super.gender,
    required super.phone,
    required this.username,
    required this.nim,
    required this.email,
    required String password,
  }) : _password = password;

  // Enkapsulasi: Verifikasi password dilakukan di dalam objek User
  bool verifyPassword(String inputPassword) {
    return _password == inputPassword;
  }

  // Format tanggal lahir menjadi string ramah pengguna (DD-MM-YYYY)
  String get formattedBirthDate {
    final day = birthDate.day.toString().padLeft(2, '0');
    final month = birthDate.month.toString().padLeft(2, '0');
    final year = birthDate.year.toString();
    return '$day-$month-$year';
  }

  // Gabungan tempat dan tanggal lahir
  String get birthPlaceAndDate {
    return '$birthPlace, $formattedBirthDate';
  }

  // Polymorphism: Implementasi dari method abstrak Person
  @override
  String getRoleDescription() {
    return 'Mahasiswa Terdaftar (NIM: $nim)';
  }

  @override
  String toString() {
    return 'User(fullName: $fullName, username: $username, nim: $nim, email: $email)';
  }
}
