
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super (const HomeScreenState()) {
    on<HomeScreenFetched>(_onHomeScreenFetched);
  }

  Future<void> _onHomeScreenFetched (
      HomeScreenFetched campaigns, Emitter<HomeScreenState> emit) async {
            try {      
      if (state.status == HomeScreenStatus.initial) {
        
        return emit(state.copyWith(
            status: HomeScreenStatus.success,
            ));
      }
  
    } catch(_) {
         emit(state.copyWith(
            status: HomeScreenStatus.failure,
            ));
    }
      }
}