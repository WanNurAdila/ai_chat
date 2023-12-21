import 'package:ai_chat/chat_detail/models/ai_conversation_model.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

import '../chat_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({super.key});

  @override
  State<ChatDetailView> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetailView> {
  final _scrollController = ScrollController();
  List<AIConversationModel> result = [];
  ValueNotifier<int> refreshResult = ValueNotifier<int>(0);

  refreshPage() async {
// You can do run any refresh function here
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ChatDetailBloc, ChatDetailState>(
          builder: (context, state) {
        switch (state.status) {
          case ChatDetailStatus.failure:
            return const Center(child: Text('Fail'));
          case ChatDetailStatus.success:
            {
              result.add(AIConversationModel(
                  question: '${state.prompt}', result: state.result));

              refreshResult.value++;
              return SingleChildScrollView(
                child: Column(children: [
                  ValueListenableBuilder(
                    valueListenable: refreshResult,
                    builder: ((context, value, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: result.length,
                        itemBuilder: (ctx, idx) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 60,
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical:16, horizontal: 12),
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Text(
                                    result[idx].question,
                                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal)
                                        
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 40,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Markdown(
                                    styleSheet: MarkdownStyleSheet(
                                      
                                      textScaleFactor: 1.3
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    data: result[idx].result,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }),
                  )
                ]),
              );

              //  ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: state.result.content.parts.length,
              //   itemBuilder:(ctx, idx) {

              //   } );
            }
          default:
            return const Center(child: Text('Loading'));
        }
      }),
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
