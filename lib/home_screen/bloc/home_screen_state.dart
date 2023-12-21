part of 'home_screen_bloc.dart';

enum HomeScreenStatus { initial, success, failure}

class HomeScreenState extends Equatable {

  const HomeScreenState ({
    this.status = HomeScreenStatus.initial,
  });

  final HomeScreenStatus  status;

  HomeScreenState copyWith({
    HomeScreenStatus? status,
  }) {
    return HomeScreenState( status: status ?? this.status);
  }

  @override
  String toString(){
    return ''' HomeScreenState { status : $status}''';
  }

  @override
  List<Object> get props => [status];


}
