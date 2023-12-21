import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../new_chat.dart';

class NewChatPage extends StatelessWidget {
  const NewChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: false,
            elevation: 1,
            backgroundColor: Colors.white,
            titleSpacing: 0,
            title: const Text('New Chat')),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<NewChatBloc>(
            create: (_) => NewChatBloc(),
          ),
        ],
        child: const SafeArea(child: NewChatView()),
      ),
    );
  }
}
