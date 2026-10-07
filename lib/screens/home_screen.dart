import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_manager.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              UserManager().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initialLetter = user.fullName.trim().isNotEmpty
        ? user.fullName.trim()[0].toUpperCase()
        : 'U';

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          'Homepage',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B),
        actions: [
          IconButton(
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      // ScrollConfiguration dengan overscroll: false dan ClampingScrollPhysics
      // Mencegah bug bouncing / stretching berlebihan saat di-scroll
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. Kartu Utama: Menampilkan Nama Lengkap & Email (Sesuai instruksi)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            Colors.indigo.shade700,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withAlpha(60),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Avatar dengan inisial
                          CircleAvatar(
                            radius: 34,
                            backgroundColor: Colors.white,
                            child: Text(
                              initialLetter,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // INFORMASI UTAMA: NAMA LENGKAP
                          Text(
                            user.fullName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // INFORMASI UTAMA: EMAIL
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(45),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    user.email,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Badge NIM / Role (Polymorphism: getRoleDescription)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade400,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              user.getRoleDescription(),
                              style: TextStyle(
                                color: Colors.brown.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 2. Kartu Rincian Data Profil Mahasiswa (Data tersimpan dalam Object User)
                    Card(
                      elevation: 2,
                      shadowColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.person_pin, color: Color(0xFF4F46E5), size: 22),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Data Lengkap Profil',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 20),
                            _buildProfileRow(
                              icon: Icons.badge_outlined,
                              label: 'Nama Lengkap',
                              value: user.fullName,
                              isHighlighted: true,
                            ),
                            _buildProfileRow(
                              icon: Icons.alternate_email,
                              label: 'Username',
                              value: user.username,
                            ),
                            _buildProfileRow(
                              icon: Icons.numbers_outlined,
                              label: 'NIM',
                              value: user.nim,
                              isHighlighted: true,
                            ),
                            _buildProfileRow(
                              icon: Icons.mail_outline,
                              label: 'Email',
                              value: user.email,
                              isHighlighted: true,
                            ),
                            _buildProfileRow(
                              icon: Icons.cake_outlined,
                              label: 'Tempat, Tgl Lahir',
                              value: user.birthPlaceAndDate,
                            ),
                            _buildProfileRow(
                              icon: Icons.wc_outlined,
                              label: 'Jenis Kelamin',
                              value: user.gender,
                            ),
                            _buildProfileRow(
                              icon: Icons.phone_android_outlined,
                              label: 'Nomor HP',
                              value: user.phone,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // 3. Kartu Konsep OOP (Rapi & Expandable)
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.blue.shade100),
                      ),
                      color: Colors.blue.shade50.withAlpha(120),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          initiallyExpanded: false,
                          leading: Icon(Icons.code, color: Colors.blue.shade800),
                          title: Text(
                            'Penerapan Konsep OOP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                              fontSize: 13,
                            ),
                          ),
                          subtitle: const Text(
                            'Ketuk untuk melihat implementasi OOP',
                            style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildOOPBadge(
                                    title: '1. Encapsulation (Enkapsulasi)',
                                    desc:
                                        'Atribut user (_password) dibuat private dan verifikasi dilakukan lewat method User.verifyPassword().',
                                  ),
                                  _buildOOPBadge(
                                    title: '2. Inheritance (Pewarisan)',
                                    desc:
                                        'Class User mewarisi properti dasar dari base class Person.',
                                  ),
                                  _buildOOPBadge(
                                    title: '3. Polymorphism (Polimorfisme)',
                                    desc:
                                        'Class User meng-override method getRoleDescription() dari base class Person.',
                                  ),
                                  _buildOOPBadge(
                                    title: '4. Abstraction & Singleton',
                                    desc:
                                        'Interface IAuthService diimplementasikan oleh UserManager secara singleton.',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // 4. Tombol Logout
                    OutlinedButton.icon(
                      onPressed: () => _handleLogout(context),
                      icon: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
                      label: const Text(
                        'Keluar (Logout)',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.redAccent),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow({
    required IconData icon,
    required String label,
    required String value,
    bool isHighlighted = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: isHighlighted ? const Color(0xFF4F46E5) : const Color(0xFF64748B),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF64748B),
                fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          const Text(' :  ', style: TextStyle(color: Color(0xFF94A3B8))),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                color: isHighlighted ? const Color(0xFF1E293B) : const Color(0xFF334155),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOOPBadge({required String title, required String desc}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: Color(0xFF1E40AF),
            ),
          ),
          Text(
            desc,
            style: const TextStyle(fontSize: 11, color: Color(0xFF334155)),
          ),
        ],
      ),
    );
  }
}
