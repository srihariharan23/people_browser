import 'package:dio/dio.dart';

import '../../data/models/person_model.dart';

class PeopleRepository {
  final Dio _dio;
  static const String _baseUrl = 'https://randomuser.me/api/';

  PeopleRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<Person>> fetchPeople({int results = 50}) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'results': results, 'seed': 'abc'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['results'];
        return data.map((json) => Person.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load people');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'An error occurred while fetching people');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
