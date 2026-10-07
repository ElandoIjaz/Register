import '../models/user.dart';

/// Response result object untuk operasi autentikasi (OOP Data Transfer)
class AuthResult {
  final bool isSuccess;
  final String message;
  final User? user;

  const AuthResult({
    required this.isSuccess,
    required this.message,
    this.user,
  });
}

/// Abstract Interface IAuthService (Menerapkan prinsip OOP: Abstraction)
/// Mendefinisikan kontrak fungsi layanan autentikasi tanpa membeberkan detail implementasi.
abstract class IAuthService {
  AuthResult register(User user);
  AuthResult login(String identifier, String password);
  void logout();
  User? get currentUser;
  List<User> get registeredUsers;
}
