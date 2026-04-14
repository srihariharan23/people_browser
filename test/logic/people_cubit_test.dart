import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:people_browser/data/models/person_model.dart';
import 'package:people_browser/data/repositories/people_repository.dart';
import 'package:people_browser/services/people/people_cubit.dart';
import 'package:people_browser/services/people/people_state.dart';

class MockPeopleRepository extends Mock implements PeopleRepository {}

void main() {
  late PeopleRepository mockRepository;
  late PeopleCubit cubit;

  final tPeople = [
    const Person(
      id: '1',
      firstName: 'Sri',
      lastName: 'Hari',
      email: 'Sri@Hari.com',
      imageUrl: '',
      city: 'London',
      country: 'UK',
      phone: '123',
    ),
    const Person(
      id: '2',
      firstName: 'Hari',
      lastName: 'Haran',
      email: 'Hari@Haran.com',
      imageUrl: '',
      city: 'Paris',
      country: 'France',
      phone: '456',
    ),
  ];

  setUp(() {
    mockRepository = MockPeopleRepository();
    cubit = PeopleCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('PeopleCubit', () {
    test('initial state is PeopleInitial', () {
      expect(cubit.state, PeopleInitial());
    });

    blocTest<PeopleCubit, PeopleState>(
      'emits [PeopleLoading, PeopleLoaded] when loadPeople is successful',
      build: () {
        when(
          () => mockRepository.fetchPeople(),
        ).thenAnswer((_) async => tPeople);
        return cubit;
      },
      act: (cubit) => cubit.loadPeople(),
      expect: () => [
        PeopleLoading(),
        PeopleLoaded(allPeople: tPeople, filteredPeople: tPeople),
      ],
    );

    blocTest<PeopleCubit, PeopleState>(
      'emits [PeopleLoading, PeopleError] when loadPeople fails',
      build: () {
        when(
          () => mockRepository.fetchPeople(),
        ).thenThrow(Exception('Error fetching data'));
        return cubit;
      },
      act: (cubit) => cubit.loadPeople(),
      expect: () => [
        PeopleLoading(),
        const PeopleError('Exception: Error fetching data'),
      ],
    );

    blocTest<PeopleCubit, PeopleState>(
      'filters people correctly when searchPeople is called',
      build: () {
        when(
          () => mockRepository.fetchPeople(),
        ).thenAnswer((_) async => tPeople);
        return cubit;
      },
      seed: () => PeopleLoaded(allPeople: tPeople, filteredPeople: tPeople),
      act: (cubit) => cubit.searchPeople('Sri'),
      expect: () => [
        PeopleLoaded(
          allPeople: tPeople,
          filteredPeople: [tPeople[0]],
          searchQuery: 'Sri',
        ),
      ],
    );

    blocTest<PeopleCubit, PeopleState>(
      'returns all people when search query is empty',
      build: () {
        return cubit;
      },
      seed: () => PeopleLoaded(
        allPeople: tPeople,
        filteredPeople: [tPeople[0]],
        searchQuery: 'Sri',
      ),
      act: (cubit) => cubit.searchPeople(''),
      expect: () => [
        PeopleLoaded(
          allPeople: tPeople,
          filteredPeople: tPeople,
          searchQuery: '',
        ),
      ],
    );
  });
}
