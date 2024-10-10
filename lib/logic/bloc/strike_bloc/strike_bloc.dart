import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'strike_event.dart';
part 'strike_state.dart';

class StrikeBloc extends Bloc<StrikeEvent, StrikeState> {
  StrikeBloc() : super(StrikeInitial()) {
    on<StrikeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
