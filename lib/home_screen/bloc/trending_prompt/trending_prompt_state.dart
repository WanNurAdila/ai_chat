part of 'trending_prompt_bloc.dart';

enum TrendingPromptStatus { initial, success, failure }

class TrendingPromptState extends Equatable {
  const TrendingPromptState({
    this.status = TrendingPromptStatus.initial,
    this.result,
  });

  final TrendingPromptStatus status;
  final result;

  TrendingPromptState copyWith({
    TrendingPromptStatus? status,
    result,
  }) {
    return TrendingPromptState(
        status: status ?? this.status, result: result ?? result);
  }

  @override
  String toString() {
    return ''' TrendingPromptState { status : $status,result: $result}''';
  }

  @override
  List<Object> get props => [status];
}
