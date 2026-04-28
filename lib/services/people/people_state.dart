import 'package:equatable/equatable.dart';
import '../../data/models/person_model.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();

  @override
  List<Object?> get props => [];
}

class PeopleInitial extends PeopleState {}

class PeopleLoading extends PeopleState {}

class PeopleLoaded extends PeopleState {
  final List<Person> allPeople;
  final List<Person> filteredPeople;
  final String searchQuery;
  final bool showFavoritesOnly;

  const PeopleLoaded({
    required this.allPeople,
    required this.filteredPeople,
    this.searchQuery = '',
    this.showFavoritesOnly = false,
  });

  @override
  List<Object?> get props => [allPeople, filteredPeople, searchQuery, showFavoritesOnly];

  PeopleLoaded copyWith({
    List<Person>? allPeople,
    List<Person>? filteredPeople,
    String? searchQuery,
    bool? showFavoritesOnly,
  }) {
    return PeopleLoaded(
      allPeople: allPeople ?? this.allPeople,
      filteredPeople: filteredPeople ?? this.filteredPeople,
      searchQuery: searchQuery ?? this.searchQuery,
      showFavoritesOnly: showFavoritesOnly ?? this.showFavoritesOnly,
    );
  }
}

class PeopleError extends PeopleState {
  final String message;

  const PeopleError(this.message);

  @override
  List<Object?> get props => [message];
}

class PeopleEmpty extends PeopleState {
  final String message;

  const PeopleEmpty(this.message);

  @override
  List<Object?> get props => [message];
}
