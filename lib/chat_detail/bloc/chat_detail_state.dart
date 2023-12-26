part of 'chat_detail_bloc.dart';

enum ChatDetailStatus { initial, success, failure }

class ChatDetailState extends Equatable {
  const ChatDetailState({
    this.status = ChatDetailStatus.initial,
    this.prompt = '',
    this.result,
  });

  final ChatDetailStatus status;
  final String? prompt;
  final result;

  ChatDetailState copyWith({
    ChatDetailStatus? status,
    result,
     String? prompt,
  }) {
    return ChatDetailState(
        status: status ?? this.status,
        prompt: prompt ?? this.prompt,
        result: result ?? result);
  }

  @override
  String toString() {
    return ''' ChatDetailState { status : $status, prompt: $prompt, result: $result}''';
  }

  @override
  List<Object> get props => [status];
}
