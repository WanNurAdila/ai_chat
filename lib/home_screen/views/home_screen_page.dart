import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../home_screen.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<HomeScreenBloc>(
            create: (_) => HomeScreenBloc()..add(HomeScreenFetched()),
          ),
        ],
        child: const HomeScreenView(),
      ),
    );
  }
}
