import 'package:flutter_test/flutter_test.dart';
import 'package:people_browser/data/models/person_model.dart';

void main() {
  group('Person Model', () {
    test('should parse from JSON correctly', () {
      final json = {
        'login': {'uuid': '123'},
        'name': {'first': 'Sri', 'last': 'Hari'},
        'email': 'Sri.Hari@gmail.com',
        'picture': {'large': 'https://example.com/img.jpg'},
        'location': {'city': 'London', 'country': 'UK'},
        'phone': '123456789',
      };

      final person = Person.fromJson(json);

      expect(person.id, '123');
      expect(person.firstName, 'Sri');
      expect(person.lastName, 'Hari');
      expect(person.fullName, 'Sri Hari');
      expect(person.email, 'Sri.Hari@example.com');
      expect(person.imageUrl, 'https://example.com/img.jpg');
      expect(person.city, 'London');
      expect(person.country, 'UK');
    });

    test('should handle missing fields in JSON', () {
      final json = {
        'login': {},
        'name': {},
        'email': 'test@test.com',
        'picture': {},
        'location': {},
        'phone': '123',
      };

      final person = Person.fromJson(json);

      expect(person.firstName, '');
      expect(person.lastName, '');
      expect(person.email, 'test@test.com');
    });
  });
}
