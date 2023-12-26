import 'package:ai_chat/home_screen/bloc/trending_prompt/trending_prompt_bloc.dart';
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
            create: (_) => HomeScreenBloc()..add(AutomationFetched()),
          ),
          BlocProvider<TrendingPromptBloc>(
            create: (_) => TrendingPromptBloc()..add(TrendingPromptFetched()),
          ),
        ],
        child: const HomeScreenView(),
      ),
    );
  }
}
