import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Theme/app_theme.dart';
import 'data/repositories/people_repository.dart';
import 'presentation/screens/landing_screen.dart';
import 'services/people/people_cubit.dart';

void main() {
  runApp(const PeopleBrowserApp());
}

class PeopleBrowserApp extends StatelessWidget {
  const PeopleBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PeopleRepository(),
      child: BlocProvider(
        create: (context) =>
            PeopleCubit(context.read<PeopleRepository>())..loadPeople(),
        child: MaterialApp(
          title: 'People Browser',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const LandingScreen(),
        ),
      ),
    );
  }
}
