import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:register/main.dart';
import 'package:register/screens/login_screen.dart';

void main() {
  testWidgets('RegisterPage menampilkan semua input', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Fullname'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Tgl Lahir'), findsOneWidget);
    expect(find.text('Jenis Kelamin'), findsOneWidget);
    expect(find.text('No.Hp'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Alamat'), findsOneWidget);
    expect(find.text('Submit Pendaftaran'), findsOneWidget);
  });

  testWidgets('Submit form kosong menampilkan pesan validasi', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.ensureVisible(find.text('Submit Pendaftaran'));
    await tester.tap(find.text('Submit Pendaftaran'));
    await tester.pump();

    expect(find.text('Fullname wajib diisi'), findsOneWidget);
    expect(find.text('Password wajib diisi'), findsOneWidget);
  });

  testWidgets('LoginPage menampilkan Snackbar saat login', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    await tester.enterText(find.byType(TextField).at(0), 'mina');
    await tester.enterText(find.byType(TextField).at(1), '123456');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    expect(find.text('Yeay, selamat datang kembali, mina!'), findsOneWidget);
  });
}
