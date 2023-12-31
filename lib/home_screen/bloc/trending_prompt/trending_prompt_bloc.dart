import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'trending_prompt_event.dart';
part 'trending_prompt_state.dart';

class TrendingPromptBloc
    extends Bloc<TrendingPromptEvent, TrendingPromptState> {
  TrendingPromptBloc() : super(const TrendingPromptState()) {
    on<TrendingPromptFetched>(_onTrendingPromptFetched);
  }
  final gemini = Gemini.instance;

  Future<void> _onTrendingPromptFetched(
      TrendingPromptFetched prompt, Emitter<TrendingPromptState> emit) async {
    try {
      if (state.status == TrendingPromptStatus.initial) {
        final res = await gemini.text(
            'generate 4 trending keywords  in an array of object  with id,  keyword, and  prompt variable in JSON');

        return emit(state.copyWith(
            status: TrendingPromptStatus.success,
            result: res?.content?.parts?.last.text));
      }
    } catch (_) {
      emit(state.copyWith(
        status: TrendingPromptStatus.failure,
      ));
    }
  }
}
