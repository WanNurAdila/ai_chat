part of 'chat_detail_bloc.dart';

abstract class ChatDetailEvent extends Equatable {

@override
List<Object> get props => [];
}

class ChatDetailFetched extends ChatDetailEvent {
  ChatDetailFetched(this.prompt);
  final String prompt;

  @override
  List<Object> get props => [prompt];
}