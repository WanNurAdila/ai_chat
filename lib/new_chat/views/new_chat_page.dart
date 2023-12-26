import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../new_chat.dart';

// ignore: must_be_immutable
class NewChatPage extends StatelessWidget {
  NewChatPage({super.key, this.title, this.prompt});

  String? title = '';
  String? prompt;

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
            title: Text(title != null ? '$title' : 'New Chat')),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<NewChatBloc>(
            create: (_) => NewChatBloc(),
          ),
        ],
        child: SafeArea(child: NewChatView(prompt: prompt)),
      ),
    );
  }
}
