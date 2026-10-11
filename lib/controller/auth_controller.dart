import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

/// Controller untuk logika Register & Login.
/// Tampilan (screens) cukup memanggil method di sini,
/// sehingga screen bisa menggunakan StatelessWidget.
class AuthController extends ChangeNotifier {
  // Singleton: satu instance dipakai bersama oleh semua screen
  AuthController._();
  static final AuthController instance = AuthController._();

  // ===================== REGISTER =====================
  final registerFormKey = GlobalKey<FormState>();

  // Controller sesuai kriteria
  final fullnameCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final alamatCtrl = TextEditingController();

  // Variabel pendukung Tgl Lahir & Jenis Kelamin
  DateTime? tglLahir;
  String? jenisKelamin;

  final List<String> pilihanJenisKelamin = const ['Laki-laki', 'Perempuan'];

  String get tglLahirText => tglLahir == null
      ? 'Pilih Tanggal Lahir'
      : '${tglLahir!.day}-${tglLahir!.month}-${tglLahir!.year}';

  // Fungsi DatePicker
  Future<void> pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tglLahir ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != tglLahir) {
      tglLahir = picked;
      notifyListeners(); // pengganti setState
    }
  }

  void setJenisKelamin(String? val) {
    jenisKelamin = val;
    notifyListeners();
  }

  // Validator sederhana untuk field wajib
  String? wajibDiisi(String? val, String label) =>
      (val == null || val.isEmpty) ? '$label wajib diisi' : null;

  void submitRegister(BuildContext context) {
    if (registerFormKey.currentState!.validate()) {
      if (tglLahir == null || jenisKelamin == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tanggal lahir dan jenis kelamin wajib diisi!'), backgroundColor: Colors.orange),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi Berhasil Disimpan!'), backgroundColor: Colors.teal),
      );

      // Arahkan ke halaman Login setelah submit berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  // ===================== LOGIN =====================
  // Controller untuk menangkap teks input
  final loginUserCtrl = TextEditingController();
  final loginPassCtrl = TextEditingController();

  void submitLogin(BuildContext context) {
    final String username = loginUserCtrl.text.trim();

    // Validasi singkat biar gak kosong
    if (username.isEmpty || loginPassCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan Password tidak boleh kosong!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // SnackBar (notifikasi) sesuai kriteria
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Yeay, selamat datang kembali, $username!'),
        backgroundColor: Colors.indigo,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
