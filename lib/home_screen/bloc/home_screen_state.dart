part of 'home_screen_bloc.dart';

enum HomeScreenStatus { initial, success, failure }

class HomeScreenState extends Equatable {
  const HomeScreenState(
      {this.status = HomeScreenStatus.initial,
      this.automationResult,
      this.promptResult});

  final HomeScreenStatus status;
  final automationResult;
  final promptResult;

  HomeScreenState copyWith(
      {HomeScreenStatus? status, automationResult, promptResult}) {
    return HomeScreenState(
        status: status ?? this.status,
        automationResult: automationResult ?? automationResult,
        promptResult: promptResult ?? promptResult);
  }

  @override
  String toString() {
    return ''' HomeScreenState { status : $status,automationResult: $automationResult, $promptResult:promptResult}''';
  }

  @override
  List<Object> get props => [status];
}
