import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AIConversationModel extends Equatable {
  
  String question;
  String result;

  AIConversationModel({required this.question, required this.result});

  @override
  List<Object?> get props => [question, result];
}
