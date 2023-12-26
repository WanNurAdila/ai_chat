import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(const HomeScreenState()) {
    on<HomeScreenFetched>(_onHomeScreenFetched);
  }
  final gemini = Gemini.instance;
  Future<void> _onHomeScreenFetched(
      HomeScreenFetched chat, Emitter<HomeScreenState> emit) async {
    try {
      if (state.status == HomeScreenStatus.initial) {
        final res = await gemini.text(
            'generate four prompts for lifestyle in array of object  with id,  prompt , short title and 15 characters  of description variable in json');

        return emit(state.copyWith(
            status: HomeScreenStatus.success,
            result: res?.content?.parts?.last.text));
      }
    } catch (_) {
      emit(state.copyWith(
        status: HomeScreenStatus.failure,
      ));
    }
  }
}
