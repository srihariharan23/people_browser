import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Theme/app_theme.dart';
import '../../services/people/people_cubit.dart';
import '../../services/people/people_state.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/person_list_tile.dart';
import 'person_detail_screen.dart';

class PeopleListScreen extends StatefulWidget {
  const PeopleListScreen({super.key});

  @override
  State<PeopleListScreen> createState() => _PeopleListScreenState();
}

class _PeopleListScreenState extends State<PeopleListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People Browser'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {});
                context.read<PeopleCubit>().searchPeople(query);
              },
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppTheme.textSecondary,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<PeopleCubit>().searchPeople('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<PeopleCubit, PeopleState>(
        builder: (context, state) {
          if (state is PeopleLoading) {
            return const PeopleLoadingView();
          } else if (state is PeopleError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<PeopleCubit>().loadPeople(),
            );
          } else if (state is PeopleEmpty) {
            return const EmptyView(message: 'Try something else.');
          } else if (state is PeopleLoaded) {
            if (state.filteredPeople.isEmpty) {
              return const EmptyView(
                title: 'No matched results',
                message: 'We couldn\'t find anyone matching your search.',
              );
            }
            return RefreshIndicator(
              onRefresh: () => context.read<PeopleCubit>().refresh(),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                itemCount: state.filteredPeople.length,
                itemBuilder: (context, index) {
                  final person = state.filteredPeople[index];
                  return PersonListTile(
                    person: person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PersonDetailScreen(person: person),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
          return const Center(child: Text('Initialize to load people'));
        },
      ),
    );
  }
}
