part of 'trending_prompt_bloc.dart';

abstract class TrendingPromptEvent extends Equatable {

@override
List<Object> get props => [];
}

class TrendingPromptFetched extends TrendingPromptEvent {}