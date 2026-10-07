/// Class AuthValidator menerapkan prinsip Clean Code (Single Responsibility Principle)
/// Bertanggung jawab khusus untuk memvalidasi input data pengguna (Form Validation).
class AuthValidator {
  // Regex untuk validasi format email yang fleksibel (mendukung domain umum & kampus/akademik)
  static final RegExp _emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$',
  );

  // Regex untuk validasi nomor telepon (hanya digit dan opsional prefix '+')
  static final RegExp _phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');

  /// Validasi Nama Lengkap
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama lengkap tidak boleh kosong';
    }
    if (value.trim().length < 3) {
      return 'Nama lengkap minimal 3 karakter';
    }
    return null;
  }

  /// Validasi Username
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username tidak boleh kosong';
    }
    final trimmed = value.trim();
    if (trimmed.contains(' ')) {
      return 'Username tidak boleh mengandung spasi';
    }
    if (trimmed.length < 3) {
      return 'Username minimal 3 karakter';
    }
    return null;
  }

  /// Validasi NIM (Mendukung kombinasi huruf dan angka, misal: E41253170)
  static String? validateNim(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'NIM tidak boleh kosong';
    }
    final trimmed = value.trim();
    if (trimmed.length < 4) {
      return 'NIM minimal 4 karakter';
    }
    return null;
  }

  /// Validasi Format Email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final trimmed = value.trim();
    if (!_emailRegex.hasMatch(trimmed)) {
      return 'Format email tidak valid (contoh: nama@domain.com)';
    }
    return null;
  }

  /// Validasi Tempat Lahir
  static String? validateBirthPlace(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Tempat lahir tidak boleh kosong';
    }
    return null;
  }

  /// Validasi Tanggal Lahir
  static String? validateBirthDate(DateTime? date) {
    if (date == null) {
      return 'Silakan pilih tanggal lahir Anda';
    }
    return null;
  }

  /// Validasi Nomor HP
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor HP tidak boleh kosong';
    }
    final trimmed = value.trim();
    if (!_phoneRegex.hasMatch(trimmed)) {
      return 'Nomor HP harus berupa angka valid (9-15 digit)';
    }
    return null;
  }

  /// Validasi Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  /// Validasi Identifier saat Login (Bisa Username, Email, atau NIM)
  static String? validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Harap masukkan Username, Email, atau NIM';
    }
    return null;
  }
}
