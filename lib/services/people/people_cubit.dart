import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_browser/services/people/people_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/people_repository.dart';

class PeopleCubit extends Cubit<PeopleState> {
  final PeopleRepository repository;
  static const _favoritesKey = 'favorite_people_ids';

  PeopleCubit(this.repository) : super(PeopleInitial());

  Future<void> loadPeople() async {
    emit(PeopleLoading());
    try {
      final people = await repository.fetchPeople();
      if (people.isEmpty) {
        emit(const PeopleEmpty('No people found.'));
      } else {
        final prefs = await SharedPreferences.getInstance();
        final favoriteIds = prefs.getStringList(_favoritesKey) ?? [];
        
        final updatedPeople = people.map((p) {
          if (favoriteIds.contains(p.id)) {
            return p.copyWith(isFavorite: true);
          }
          return p;
        }).toList();

        emit(PeopleLoaded(allPeople: updatedPeople, filteredPeople: updatedPeople));
      }
    } catch (e) {
      emit(PeopleError(e.toString()));
    }
  }

  Future<void> toggleFavourite(String id) async {
    if (state is PeopleLoaded) {
      final currentState = state as PeopleLoaded;
      final updatedAllPeople = currentState.allPeople.map((p) {
        if (p.id == id) {
          return p.copyWith(isFavorite: !p.isFavorite);
        }
        return p;
      }).toList();

      final prefs = await SharedPreferences.getInstance();
      final favoriteIds = updatedAllPeople
          .where((p) => p.isFavorite)
          .map((p) => p.id)
          .toList();
      await prefs.setStringList(_favoritesKey, favoriteIds);

      final newState = currentState.copyWith(allPeople: updatedAllPeople);
      _applyFilters(
        currentState: newState,
        query: currentState.searchQuery,
        showFavoritesOnly: currentState.showFavoritesOnly,
      );
    }
  }

  void toggleShowFavorites() {
    if (state is PeopleLoaded) {
      final currentState = state as PeopleLoaded;
      _applyFilters(
        currentState: currentState,
        query: currentState.searchQuery,
        showFavoritesOnly: !currentState.showFavoritesOnly,
      );
    }
  }

  void searchPeople(String query) {
    if (state is PeopleLoaded) {
      final currentState = state as PeopleLoaded;
      _applyFilters(
        currentState: currentState,
        query: query,
        showFavoritesOnly: currentState.showFavoritesOnly,
      );
    }
  }

  void _applyFilters({
    required PeopleLoaded currentState,
    required String query,
    required bool showFavoritesOnly,
  }) {
    var filtered = currentState.allPeople;

    if (showFavoritesOnly) {
      filtered = filtered.where((p) => p.isFavorite).toList();
    }

    if (query.isNotEmpty) {
      filtered = filtered.where((person) {
        final fullName = person.fullName.toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();
    }

    emit(currentState.copyWith(
      filteredPeople: filtered,
      searchQuery: query,
      showFavoritesOnly: showFavoritesOnly,
    ));
  }

  Future<void> refresh() => loadPeople();
}
