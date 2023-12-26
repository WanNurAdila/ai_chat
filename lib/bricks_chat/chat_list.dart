import 'package:ai_chat/text_box/reusable_text_box.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:rive/rive.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  ChatListState createState() => ChatListState();
}

class ChatListState extends State<ChatList> {
  final ScrollController _scrollController = ScrollController();
  SMIInput<bool>? _boolExampleInput;

  String promptText = '';
  List<Message> messageList = [
    const Message(message: 'No 1', from: 'Adila'),
    const Message(message: 'No 2', from: 'Adila'),
    const Message(message: 'No 3', from: 'Adila'),
    const Message(message: 'No 4', from: 'Adila'),
    const Message(message: 'No 5', from: 'Adila'),
  ];

  @override
  void initState() {
    super.initState();
    _scrollDown();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _onInit(Artboard art) {
    var controller =
        StateMachineController.fromArtboard(art, 'State Machine 2');
    art.addController(controller!);
    _boolExampleInput = controller.findInput<bool>('mad') as SMIBool;
  }

  onPressed() {
    if (_boolExampleInput?.value == false) {
      _boolExampleInput?.value = true;
    } else if (_boolExampleInput?.value == true) {
      _boolExampleInput?.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => {FocusManager.instance.primaryFocus?.unfocus()},
        child: SafeArea(
          child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(children: [
                Container(
                    alignment: Alignment.center,
                    height: 400,
                    width: 400,
                    child: RiveAnimation.asset(
                      'assets/rive/emotion_test.riv',
                      onInit: _onInit,
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: InkWell(
                      onTap: onPressed,
                      child: const Text('Bool'),
                    )),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 10,
                    itemBuilder: (ctx, idx) {
                      return Column(
                        children: [
                          Text('Test $idx'),
                          const AnimatedEmoji(
                            AnimatedEmojis.rocket,
                            size: 30,
                          )
                        ],
                      );
                    }),
              ])),
        ),
      ),
      bottomNavigationBar: Container(
          padding: MediaQuery.of(context).viewInsets,
          margin: const EdgeInsets.all(16),
          child: ReusableTextBox(
              value: promptText,
              hintText: 'hintText',
              readOnly: false,
              keyboardType: TextInputType.multiline,
              errorText: 'errorText',
              onChanged: (value) => {
                    promptText = value,
                  })),
    );
  }
}

class Message extends Equatable {
  final String message;
  final String from;

  const Message({required this.message, required this.from});

  @override
  List<Object?> get props => [message, from];
}
