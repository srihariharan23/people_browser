import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_browser/services/people/people_state.dart';

import '../../data/repositories/people_repository.dart';

class PeopleCubit extends Cubit<PeopleState> {
  final PeopleRepository repository;

  PeopleCubit(this.repository) : super(PeopleInitial());

  Future<void> loadPeople() async {
    emit(PeopleLoading());
    try {
      final people = await repository.fetchPeople();
      if (people.isEmpty) {
        emit(const PeopleEmpty('No people found.'));
      } else {
        emit(PeopleLoaded(allPeople: people, filteredPeople: people));
      }
    } catch (e) {
      emit(PeopleError(e.toString()));
    }
  }

  void toggleFavourite(bool favorite) {
    if (state is PeopleLoaded) {
      final currentState = state as PeopleLoaded;
      final index = currentState.filteredPeople.indexWhere(
        (person) => person.isFavorite == favorite,
      );
      if (index != -1) {
        final updatedPerson = currentState.filteredPeople[index].copyWith(
          isFavorite: !favorite,
        );
        final updatedPeople = [
          ...currentState.filteredPeople.sublist(0, index),
          updatedPerson,
          ...currentState.filteredPeople.sublist(index + 1),
        ];
        emit(currentState.copyWith(filteredPeople: updatedPeople));
      }
    }
    return;
  }

  void searchPeople(String query) {
    if (state is PeopleLoaded) {
      final currentState = state as PeopleLoaded;

      if (query.isEmpty) {
        emit(
          currentState.copyWith(
            filteredPeople: currentState.allPeople,
            searchQuery: query,
          ),
        );
        return;
      }

      final filtered = currentState.allPeople.where((person) {
        final fullName = person.fullName.toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();

      if (filtered.isEmpty) {
        emit(
          currentState.copyWith(filteredPeople: filtered, searchQuery: query),
        );
      } else {
        emit(
          currentState.copyWith(filteredPeople: filtered, searchQuery: query),
        );
      }
    }
  }

  Future<void> refresh() => loadPeople();
}
