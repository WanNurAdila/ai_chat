// ignore_for_file: must_be_immutable

part of 'new_chat_bloc.dart';

abstract class NewChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewChatFetched extends NewChatEvent {}

class PromptSubmit extends NewChatEvent {
  PromptSubmit(this.chats);
  List<Content> chats;

  @override
  List<Object> get props => [chats];
}
