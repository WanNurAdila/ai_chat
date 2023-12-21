import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../new_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewChatView extends StatefulWidget {
  const NewChatView({super.key});

  @override
  State<NewChatView> createState() => _NewChatState();
}

class _NewChatState extends State<NewChatView> {
  final _scrollController = ScrollController();
  ValueNotifier<bool> textEditing = ValueNotifier<bool>(false);
  TextEditingController messageController = TextEditingController();
  List<Content> chats = [];
  ValueNotifier<int> refreshResult = ValueNotifier<int>(0);

  onSubmitPrompt() async {
    chats.add(
      Content(
        role: 'user',
        parts: [
          Parts(text: messageController.text),
        ],
      ),
    );

    refreshResult.value++;
    messageController.clear();

    context.read<NewChatBloc>().add(PromptSubmit(chats));
  }

  chatListView() {
    return SingleChildScrollView(
      child: Column(children: [
        ValueListenableBuilder(
          valueListenable: refreshResult,
          builder: ((context, value, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chats.length,
              itemBuilder: (ctx, idx) {
                return Align(
                  alignment: chats[idx].role == 'user' ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: chats[idx].role == 'user' ? MediaQuery.of(context).size.width - 60 : MediaQuery.of(context).size.width - 40,
                    ),
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: chats[idx].role == 'user' ? Colors.blueGrey :Colors.grey,
                        borderRadius: BorderRadius.circular(16)),
                    child: Markdown(
                        styleSheet: MarkdownStyleSheet(textScaleFactor: 1.3),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        data: chats[idx].parts?.lastOrNull?.text ??
                            'cannot generate data!'),
                  ),
                );
              },
            );
          }),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: [
            BlocBuilder<NewChatBloc, NewChatState>(builder: (context, state) {
              switch (state.status) {
                case NewChatStatus.failure:
                  return const Center(child: Text('Fail'));
                case NewChatStatus.success || NewChatStatus.loading:
                  {
                    if (state.chats.isNotEmpty) {
                      chats = state.chats;
                      refreshResult.value++;
                    }
                    return chats.isNotEmpty
                        ? chatListView()
                        : const Text('No Result');
                  }
                default:
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    alignment: Alignment.center,
                    child: const Text(
                      'How can I help you today?',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  );
              }
            })
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xffBFBFBF), width: 0.5),
                    borderRadius: BorderRadius.circular(24)),
                child: TextFormField(
                  maxLines: 5,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  onTap: () => {},
                  style: const TextStyle(
                    color: Color(0xff262626),
                  ),
                  onChanged: (val) {
                    val.isEmpty
                        ? textEditing.value = false
                        : textEditing.value = true;
                  },
                  controller: messageController,
                  decoration: const InputDecoration(
                      hintText: 'Message..',
                      counterText: "",
                      hintStyle: TextStyle(
                        color: Color(0xffBFBFBF),
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: textEditing,
              builder: (context, value, child) {
                return InkWell(
                  onTap: value == false
                      ? null
                      : () {
                          onSubmitPrompt();
                        },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.send,
                      size: 24,
                      color: value == false
                          ? const Color(0xffBFBFBF)
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  /// Function ///

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() async {
    if (_isBottom) {
      // when the scroll reached bottom, all logic here will run
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
