import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(const HomeScreenState()) {
    on<AutomationFetched>(_onAutomationFetched);
  }
  final gemini = Gemini.instance;
  Future<void> _onAutomationFetched(
      AutomationFetched chat, Emitter<HomeScreenState> emit) async {
    try {
      if (state.status == HomeScreenStatus.initial) {
        print('_onAutomationFetched');
        final automationResult = await onGenerateResult(
            'generate 6 prompts for lifestyle in array of object with id, prompt, title and 15 characters  of description variable in json format without json word');

        print('automationResult $automationResult');
        final promptResult = await onGenerateResult(
            'generate 5 currently trending keywords in an array of object with id, keyword, and prompt variable in json format without json word');
        print('promptResult $promptResult');
        return emit(state.copyWith(
            status: HomeScreenStatus.success,
            automationResult: automationResult,
            promptResult: promptResult));
      }
    } catch (_) {
      print('error $_');
      emit(state.copyWith(
        status: HomeScreenStatus.failure,
      ));
    }
  }

  Future<String> onGenerateResult(String prompt) async {
    final value = await gemini.text(prompt);
print('value $value');
    final withoutchara =
        value?.content?.parts?.last.text!.replaceAll(RegExp('`'), '');

    final withoutJson = withoutchara!.replaceAll(RegExp('json'), '');

    return withoutJson;
  }
}
