/// Base Class Person (Menerapkan prinsip OOP: Abstraksi & Pewarisan/Inheritance)
abstract class Person {
  // Enkapsulasi properti data dasar
  final String fullName;
  final String birthPlace;
  final DateTime birthDate;
  final String gender;
  final String phone;

  Person({
    required this.fullName,
    required this.birthPlace,
    required this.birthDate,
    required this.gender,
    required this.phone,
  });

  // Polimorfisme: Method abstrak yang akan diimplementasikan secara spesifik oleh subclass
  String getRoleDescription();
}
