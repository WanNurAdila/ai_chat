part of 'home_screen_bloc.dart';

enum HomeScreenStatus { initial, success, failure }

class HomeScreenState extends Equatable {
  const HomeScreenState({
    this.status = HomeScreenStatus.initial,
    this.result,
  });

  final HomeScreenStatus status;
  final result;

  HomeScreenState copyWith({
    HomeScreenStatus? status,
    result,
  }) {
    return HomeScreenState(
        status: status ?? this.status, result: result ?? result);
  }

  @override
  String toString() {
    return ''' HomeScreenState { status : $status,result: $result}''';
  }

  @override
  List<Object> get props => [status];
}
