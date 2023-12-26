import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  ChatDetailBloc() : super(const ChatDetailState()) {
    on<ChatDetailFetched>(_onChatDetailFetched);
  }

  final gemini = Gemini.instance;
  Future<void> _onChatDetailFetched(
      ChatDetailFetched chat, Emitter<ChatDetailState> emit) async {
    try {
      if (state.status == ChatDetailStatus.initial) {
        final res = await gemini.text(chat.prompt);

        

        return emit(state.copyWith(
            status: ChatDetailStatus.success,
            prompt: chat.prompt,
            result: res?.content?.parts?.last.text));
      }
    } catch (_) {
      emit(state.copyWith(
        status: ChatDetailStatus.failure,
      ));
    }
  }
}
