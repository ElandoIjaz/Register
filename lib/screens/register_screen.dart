import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  AuthController get _auth => AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendaftaran Akun'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _auth.registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lengkapi Data Diri Anda',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              const SizedBox(height: 16),

              // 1. Fullname (TextFormField)[cite: 6]
              TextFormField(
                controller: _auth.fullnameCtrl,
                decoration: const InputDecoration(labelText: 'Fullname', border: OutlineInputBorder()),
                validator: (val) => _auth.wajibDiisi(val, 'Fullname'),
              ),
              const SizedBox(height: 14),

              // 2. Username (TextFormField)[cite: 6]
              TextFormField(
                controller: _auth.usernameCtrl,
                decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
                validator: (val) => _auth.wajibDiisi(val, 'Username'),
              ),
              const SizedBox(height: 14),

              // 3. Email (TextFormField)[cite: 6]
              TextFormField(
                controller: _auth.emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                validator: (val) => _auth.wajibDiisi(val, 'Email'),
              ),
              const SizedBox(height: 14),

              // 4. Tgl Lahir (DatePicker)[cite: 6]
              // ListenableBuilder akan rebuild saat controller memanggil notifyListeners()
              ListenableBuilder(
                listenable: _auth,
                builder: (context, _) => InkWell(
                  onTap: () => _auth.pilihTanggal(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Tgl Lahir',
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      _auth.tglLahirText,
                      style: TextStyle(color: _auth.tglLahir == null ? Colors.grey.shade600 : Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // 5. Jenis Kelamin (Dropdown)[cite: 6]
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(),
                ),
                initialValue: _auth.jenisKelamin,
                items: _auth.pilihanJenisKelamin.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: _auth.setJenisKelamin,
              ),
              const SizedBox(height: 14),

              // 6. No.Hp (TextFormField)[cite: 6]
              TextFormField(
                controller: _auth.phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'No.Hp', border: OutlineInputBorder()),
                validator: (val) => _auth.wajibDiisi(val, 'No.Hp'),
              ),
              const SizedBox(height: 14),

              // 7. Password (TextFormField, obscuretext)[cite: 6]
              TextFormField(
                controller: _auth.passwordCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                validator: (val) => _auth.wajibDiisi(val, 'Password'),
              ),
              const SizedBox(height: 14),

              // 8. Alamat (TextFormField)[cite: 6]
              TextFormField(
                controller: _auth.alamatCtrl,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Alamat', border: OutlineInputBorder()),
                validator: (val) => _auth.wajibDiisi(val, 'Alamat'),
              ),
              const SizedBox(height: 24),

              // 9. Button Submit[cite: 6]
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _auth.submitRegister(context),
                  child: const Text('Submit Pendaftaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}