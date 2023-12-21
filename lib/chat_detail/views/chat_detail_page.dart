import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../chat_detail.dart';

class ChatDetailPage extends StatefulWidget {
  final String prompt;

  const ChatDetailPage({super.key, required this.prompt});

  @override
  State<ChatDetailPage> createState() => ChatDetailPageState();
}

class ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            titleSpacing: 0,
            title: const Text('ChatDetail Appbar')),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ChatDetailBloc>(
            create: (_) =>
                ChatDetailBloc()..add(ChatDetailFetched(widget.prompt)),
          ),
        ],
        child: const SafeArea(child: ChatDetailView()),
      ),
    );
  }
}
