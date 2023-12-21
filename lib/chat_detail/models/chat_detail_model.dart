import 'package:equatable/equatable.dart';

class ChatDetailModel extends Equatable {

String params;

ChatDetailModel({
    required this.params,
  });

  @override
  List<Object?> get props => [params];
}