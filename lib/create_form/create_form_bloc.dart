import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_form_event.dart';
part 'create_form_state.dart';

class CreateFormBloc extends Bloc<CreateFormEvent, CreateFormState> {
  CreateFormBloc() : super(CreateFormInitial()) {
    on<CreateFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
