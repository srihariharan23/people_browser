import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final String city;
  final String country;
  final String phone;

  const Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.city,
    required this.country,
    required this.phone,
  });

  String get fullName => '$firstName $lastName';

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['login']['uuid'] ?? '',
      firstName: json['name']['first'] ?? '',
      lastName: json['name']['last'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['picture']['large'] ?? '',
      city: json['location']['city'] ?? '',
      country: json['location']['country'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, email, imageUrl, city, country, phone];
}
