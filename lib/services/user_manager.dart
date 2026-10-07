import '../models/user.dart';
import 'auth_service_interface.dart';

/// Class UserManager (Menerapkan prinsip OOP: Encapsulation & Abstraction Implementation)
/// Menggunakan pola Singleton (Design Pattern) agar state data user konsisten di seluruh aplikasi.
class UserManager implements IAuthService {
  // Static instance untuk Singleton Pattern
  static final UserManager _instance = UserManager._internal();

  // Factory constructor mengembalikan instance tunggal
  factory UserManager() {
    return _instance;
  }

  // Private constructor
  UserManager._internal() {
    // Menambahkan contoh data user awal (demo/testing)
    _seedInitialUser();
  }

  // Enkapsulasi: List penyimpanan user dibuat private
  final List<User> _users = [];
  User? _currentUser;

  void _seedInitialUser() {
    final demoUser = User(
      fullName: 'Elando Ijaz M',
      username: 'Edo',
      nim: 'E41253170',
      email: 'edo@gmail.com',
      birthPlace: 'bondowoso',
      birthDate: DateTime(2006, 5, 18),
      gender: 'Laki-laki',
      phone: '089516477890',
      password: 'estehmanis',
    );
    _users.add(demoUser);
  }

  @override
  User? get currentUser => _currentUser;

  @override
  List<User> get registeredUsers => List.unmodifiable(_users);

  @override
  AuthResult register(User newUser) {
    // Validasi duplikasi username
    final usernameExists = _users.any(
      (u) => u.username.toLowerCase() == newUser.username.toLowerCase(),
    );
    if (usernameExists) {
      return const AuthResult(
        isSuccess: false,
        message: 'Username sudah digunakan, silakan gunakan username lain.',
      );
    }

    // Validasi duplikasi email
    final emailExists = _users.any(
      (u) => u.email.toLowerCase() == newUser.email.toLowerCase(),
    );
    if (emailExists) {
      return const AuthResult(
        isSuccess: false,
        message: 'Email sudah terdaftar, silakan gunakan email lain.',
      );
    }

    // Validasi duplikasi NIM
    final nimExists = _users.any(
      (u) => u.nim.trim().toLowerCase() == newUser.nim.trim().toLowerCase(),
    );
    if (nimExists) {
      return const AuthResult(
        isSuccess: false,
        message: 'NIM sudah terdaftar dalam sistem.',
      );
    }

    // Simpan objek user baru ke dalam koleksi internal
    _users.add(newUser);
    return AuthResult(
      isSuccess: true,
      message: 'Registrasi berhasil! Silakan masuk dengan akun Anda.',
      user: newUser,
    );
  }

  @override
  AuthResult login(String identifier, String password) {
    final trimmedId = identifier.trim().toLowerCase();

    // Mencari user berdasarkan username, email, atau NIM
    User? matchedUser;
    for (final user in _users) {
      if (user.username.toLowerCase() == trimmedId ||
          user.email.toLowerCase() == trimmedId ||
          user.nim.toLowerCase() == trimmedId) {
        matchedUser = user;
        break;
      }
    }

    if (matchedUser == null) {
      return const AuthResult(
        isSuccess: false,
        message: 'Akun dengan Username/Email/NIM tersebut tidak ditemukan.',
      );
    }

    // Menggunakan method enkapsulasi dari class User untuk memverifikasi password
    if (!matchedUser.verifyPassword(password)) {
      return const AuthResult(
        isSuccess: false,
        message: 'Kata sandi yang Anda masukkan salah.',
      );
    }

    _currentUser = matchedUser;
    return AuthResult(
      isSuccess: true,
      message: 'Login berhasil! Selamat datang kembali, ${matchedUser.fullName}.',
      user: matchedUser,
    );
  }

  @override
  void logout() {
    _currentUser = null;
  }
}
