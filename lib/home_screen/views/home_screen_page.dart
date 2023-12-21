import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home_screen.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<HomeScreenBloc>(
            create: (_) => HomeScreenBloc()..add(HomeScreenFetched()),
          ),
        ],
        child: const SafeArea(child: HomeScreenView()),
      ),
    );
  }
}
