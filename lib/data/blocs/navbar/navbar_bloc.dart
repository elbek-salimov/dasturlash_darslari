import 'package:flutter_bloc/flutter_bloc.dart';

import 'navbar_event.dart';
import 'navbar_state.dart';


class NavBarBloc extends Bloc<ChangeIndexEvent, ChangeIndexState> {
  NavBarBloc() : super(ChangeIndexState(index: 0)) {
    on<ChangeIndexEvent>((event, emit) {
      emit(state.copyWith(index: event.index));
    });
  }
}
