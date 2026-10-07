import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:register/models/person.dart';
import 'package:register/models/user.dart';
import 'package:register/services/user_manager.dart';
import 'package:register/screens/home_screen.dart';
import 'package:register/screens/login_screen.dart';
import 'package:register/main.dart';

void main() {
  group('OOP Concepts Tests', () {
    test('User extends Person and properly encapsulates data', () {
      final user = User(
        fullName: 'Budi Santoso',
        username: 'budis',
        nim: '21102002',
        email: 'budi@example.com',
        birthPlace: 'Surabaya',
        birthDate: DateTime(2001, 8, 20),
        gender: 'Laki-laki',
        phone: '081298765432',
        password: 'rahasia123',
      );

      // Verify inheritance
      expect(user, isA<Person>());
      expect(user.fullName, 'Budi Santoso');
      expect(user.email, 'budi@example.com');
      expect(user.nim, '21102002');
      expect(user.birthPlaceAndDate, 'Surabaya, 20-08-2001');

      // Verify encapsulation
      expect(user.verifyPassword('rahasia123'), isTrue);
      expect(user.verifyPassword('wrongpassword'), isFalse);

      // Verify polymorphism
      expect(user.getRoleDescription(), contains('NIM: 21102002'));
    });

    test('UserManager handles registration and login correctly', () {
      final manager = UserManager();

      final testUser = User(
        fullName: 'Ahmad Dahlan',
        username: 'ahmad',
        nim: '21102099',
        email: 'ahmad@example.com',
        birthPlace: 'Yogyakarta',
        birthDate: DateTime(2000, 1, 1),
        gender: 'Laki-laki',
        phone: '081233334444',
        password: 'password_ahmad',
      );

      // Register new user
      final regResult = manager.register(testUser);
      expect(regResult.isSuccess, isTrue);

      // Duplicate username rejected
      final duplicateResult = manager.register(testUser);
      expect(duplicateResult.isSuccess, isFalse);

      // Login with correct credentials
      final loginResult = manager.login('ahmad', 'password_ahmad');
      expect(loginResult.isSuccess, isTrue);
      expect(loginResult.user?.fullName, 'Ahmad Dahlan');
      expect(manager.currentUser?.email, 'ahmad@example.com');

      // Logout
      manager.logout();
      expect(manager.currentUser, isNull);
    });
  });

  group('Screen Widget Tests', () {
    testWidgets('App renders RegisterScreen with required fields', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Pendaftaran Akun'), findsOneWidget);
      expect(find.text('1. Nama Lengkap'), findsOneWidget);
      expect(find.text('2. Username'), findsOneWidget);
      expect(find.text('3. NIM'), findsOneWidget);
      expect(find.text('4. Email'), findsOneWidget);
      expect(find.text('5. Tempat / Tanggal Lahir'), findsOneWidget);
      expect(find.text('6. Jenis Kelamin'), findsOneWidget);
      expect(find.text('7. Nomor Handphone (No HP)'), findsOneWidget);
      expect(find.text('8. Password'), findsOneWidget);
      expect(find.text('Daftar Sekarang'), findsOneWidget);
    });

    testWidgets('HomeScreen correctly displays full name and email', (tester) async {
      final testUser = User(
        fullName: 'Citra Kirana',
        username: 'citra',
        nim: '21102055',
        email: 'citra@example.com',
        birthPlace: 'Semarang',
        birthDate: DateTime(2003, 11, 10),
        gender: 'Perempuan',
        phone: '081255556666',
        password: 'password_citra',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(user: testUser),
        ),
      );
      await tester.pumpAndSettle();

      // Memastikan nama lengkap dan email tampil di homepage
      expect(find.text('Citra Kirana'), findsAtLeastNWidgets(1));
      expect(find.text('citra@example.com'), findsAtLeastNWidgets(1));
      expect(find.text('Homepage'), findsOneWidget);
    });

    testWidgets('LoginScreen logs in and navigates to HomeScreen', (tester) async {
      final seededUser = UserManager().registeredUsers.first;

      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(prefilledUsername: seededUser.username),
        ),
      );
      await tester.pumpAndSettle();

      // Masukkan password akun bawaan demo
      final passwordField = find.byType(TextFormField).last;
      await tester.enterText(passwordField, 'estehmanis');
      await tester.pump();

      // Klik tombol masuk
      final loginBtn = find.text('Masuk (Login)');
      await tester.tap(loginBtn);
      await tester.pumpAndSettle();

      // Harusnya sekarang berada di HomeScreen dan menampilkan nama lengkap dan email user
      expect(find.text(seededUser.fullName), findsAtLeastNWidgets(1));
      expect(find.text(seededUser.email), findsAtLeastNWidgets(1));
    });
  });
}
