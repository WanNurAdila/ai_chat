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
      body: MultiBlocProvider(
        providers: [
          BlocProvider<NewChatBloc>(
            create: (_) => NewChatBloc(),
          ),
        ],
        child: NewChatView(
          prompt: prompt,
          title: title,
        ),
      ),
    );
  }
}
