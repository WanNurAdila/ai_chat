import 'package:equatable/equatable.dart';

class HomeScreenModel extends Equatable {

String params;

HomeScreenModel({
    required this.params,
  });

  @override
  List<Object?> get props => [params];
}