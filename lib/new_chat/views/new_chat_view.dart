import 'package:ai_chat/new_chat/views/stylesheet.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:simple_grid/simple_grid.dart';
import '../new_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

// ignore: must_be_immutable
class NewChatView extends StatefulWidget {
  String? prompt;
  String? title;

  NewChatView({super.key, this.prompt, this.title});

  @override
  State<NewChatView> createState() => _NewChatState();
}

class _NewChatState extends State<NewChatView> {
  final _scrollController = ScrollController();
  ValueNotifier<bool> textEditing = ValueNotifier<bool>(false);
  ValueNotifier<bool> loadingIcon = ValueNotifier<bool>(false);
  ValueNotifier<bool> isTopList = ValueNotifier<bool>(true);

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
    loadingIcon.value = true;
    messageController.clear();

    context.read<NewChatBloc>().add(PromptSubmit(chats));
    print('loading indicator ${loadingIcon.value}');
  }

  chatListView() {
    return SingleChildScrollView(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ValueListenableBuilder(
          valueListenable: refreshResult,
          builder: ((context, value, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chats.length,
              itemBuilder: (ctx, idx) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 20,
                    ),
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: chats[idx].role == 'user'
                            ? Colors.white54
                            : Colors.black54,
                        borderRadius: BorderRadius.circular(16)),
                    child: Markdown(
                        styleSheet: stylesheet(chats[idx].role),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        data: chats[idx].parts?.lastOrNull?.text ??
                            'cannot generate data!'),
                  ),
                );
              },
            );
          }),
        ),
        ValueListenableBuilder(
          valueListenable: loadingIcon,
          builder: ((context, value, child) {
            return value
                ? const SizedBox(
                    width: 200,
                    height: 10,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballPulse,
                        colors: [Colors.white],
                        strokeWidth: 0.5,
                        backgroundColor: Colors.transparent,
                        pathBackgroundColor: Colors.transparent),
                  )
                : const SizedBox();
          }),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: ValueListenableBuilder(
            valueListenable: isTopList,
            builder: (context, value, child) {
              return AnimatedContainer(
                  padding: const EdgeInsets.only(top: 50, bottom: 20, left: 8),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  color: value == true
                      ? Colors.black.withOpacity(0.1)
                      : Colors.black,
                  child: SpGrid(
                    crossAlignment: WrapCrossAlignment.end,
                    children: [
                      SpGridItem(
                          xs: 2,
                          sm: 2,
                          md: 2,
                          lg: 2,
                          aligment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                          )),
                      SpGridItem(
                          xs: 8,
                          sm: 8,
                          md: 8,
                          lg: 8,
                          aligment: Alignment.center,
                          child: Text(
                            widget.title != null ? '${widget.title}' : '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )),
                      const SpGridItem(
                          xs: 2, sm: 2, md: 2, lg: 2, child: SizedBox()),
                    ],
                  ));
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff2d2026), Color(0xff1d1e54)],
                stops: [0.25, 0.75],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(children: [
                BlocBuilder<NewChatBloc, NewChatState>(
                    builder: (context, state) {
                  switch (state.status) {
                    case NewChatStatus.failure:
                      return const Center(child: Text('Fail'));
                    case NewChatStatus.success || NewChatStatus.loading:
                      {
                        if (state.chats.isNotEmpty) {
                          chats = state.chats;
                          refreshResult.value++;
                          loadingIcon.value = false;
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      );
                  }
                })
              ]),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color(0xffBFBFBF), width: 0.5),
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
        ));
  }

  /// Function ///

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    if (widget.prompt != null) {
      messageController.text = '${widget.prompt}';

      onSubmitPrompt();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() async {
    _scrollIndicator == 0.0 ? isTopList.value = true : isTopList.value = false;
  }

  get _scrollIndicator {
    if (!_scrollController.hasClients) return false;

    final currentScroll = _scrollController.offset;

    return currentScroll;
  }

  // bool get _isBottom {
  //   if (!_scrollController.hasClients) return false;
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.offset;
  //   return currentScroll >= (maxScroll * 0.9);
  // }
}
