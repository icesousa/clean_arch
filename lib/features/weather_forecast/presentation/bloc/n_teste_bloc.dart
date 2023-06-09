import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'n_teste_event.dart';
part 'n_teste_state.dart';

class NTesteBloc extends Bloc<NTesteEvent, NTesteState> {
  NTesteBloc() : super(NTesteInitial()) {
    on<NTesteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
