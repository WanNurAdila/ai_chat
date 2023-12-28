import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'new_chat_event.dart';
part 'new_chat_state.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  NewChatBloc() : super(NewChatState(chats: const [])) {
    on<NewChatFetched>(_onNewChatFetched);
    on<PromptSubmit>(_onPromptSubmit);
  }

  final gemini = Gemini.instance;

  Future<void> _onNewChatFetched(
      NewChatFetched campaigns, Emitter<NewChatState> emit) async {
    try {
      if (state.status == NewChatStatus.initial) {
        return emit(state.copyWith(
          status: NewChatStatus.success,
          chats: [],
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: NewChatStatus.failure,
        chats: [],
      ));
    }
  }

  Future<void> _onPromptSubmit(
      PromptSubmit prompt, Emitter<NewChatState> emit) async {  
    try {
      if (state.status != NewChatStatus.failure) {
        emit(
            state.copyWith(status: NewChatStatus.loading, chats: prompt.chats));
        await gemini.chat(prompt.chats).then((value) {
          print('value $value');
          prompt.chats
              .add(Content(role: 'model', parts: [Parts(text: value?.output)]));
          emit(state.copyWith(
              status: NewChatStatus.success, chats: prompt.chats));
        }).catchError((onError) {});
      }
    } catch (_) {
      emit(state.copyWith(status: NewChatStatus.failure, chats: prompt.chats));
    }
  }
}
