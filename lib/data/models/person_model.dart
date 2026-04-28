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
  final bool isFavorite;

  const Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.city,
    required this.country,
    required this.phone,
    this.isFavorite = false,
  });

  Person copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? imageUrl,
    String? city,
    String? country,
    String? phone,
    bool? isFavorite,
  }) {
    return Person(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      city: city ?? this.city,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

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
      isFavorite: false,
    );
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    imageUrl,
    city,
    country,
    phone,
    isFavorite,
  ];
}
