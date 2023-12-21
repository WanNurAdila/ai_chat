part of 'new_chat_bloc.dart';

enum NewChatStatus { initial, loading, success, failure }

// ignore: must_be_immutable
class NewChatState extends Equatable {
  NewChatState({
    this.status = NewChatStatus.initial,
    this.prompt = '',
    this.result,
    required this.chats,
  });

  final NewChatStatus status;
  final String? prompt;
  final result;
  List<Content> chats = [];

  NewChatState copyWith({
    NewChatStatus? status,
    result,
    String? prompt,
    required List<Content> chats,
  }) {
    return NewChatState(
        status: status ?? this.status,
        prompt: prompt ?? this.prompt,
        result: result ?? this.result,
        chats: chats);
  }

  @override
  String toString() {
    return ''' NewChatState { status : $status, prompt: $prompt, result: $result, chats: $chats}''';
  }

  @override
  List<Object> get props => [status, chats];
}
