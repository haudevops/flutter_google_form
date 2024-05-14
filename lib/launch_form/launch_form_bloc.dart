import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'launch_form_event.dart';
part 'launch_form_state.dart';

class LaunchFormBloc extends Bloc<LaunchFormEvent, LaunchFormState> {
  LaunchFormBloc() : super(LaunchFormInitial()) {
    on<LaunchFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
