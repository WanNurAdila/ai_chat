import 'package:equatable/equatable.dart';

class NewChatModel extends Equatable {

String params;

NewChatModel({
    required this.params,
  });

  @override
  List<Object?> get props => [params];
}